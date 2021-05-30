using System;
using System.Collections.Generic;
using System.Data;
using Entidades;

namespace DAL_ModuloDos
{
    
    public class DManejadorUsuarios
    {
        Conexion _db = new Conexion();

        /// <summary>
        /// Devuelve un objeto del tipo Usuario al recibir el resultado de una consulta a la base de datos
        /// usuarioColumnas[0]=id
        /// usuarioColumnas[1]=persona_id
        /// usuarioColumnas[2]=rol_id
        /// usuarioColumnas[3]=legajo
        /// </summary>
        /// <param name="usuarioColumnas">Columnas de la consulta a la tabla usuario</param>
        /// <returns>Un objeto del tipo Sesion</returns>
        public Usuario obtenerUsuarioObj(object[] usuarioColumnas)
        {
            //Rol
            string queryRol = string.Format("Select id, descripcion from rol where id={0}", usuarioColumnas[2]);
            DataTable rolDB = _db.LeerPorComando(queryRol);
            /*
             * rolDB - ItemArray[0]=id
             * rolDB - ItemArray[1]=descripcion
             * **/

            Rol rolAuxiliar = new Rol()
            {
                ID = int.Parse(rolDB.Rows[0].ItemArray[0].ToString()),
                Descripcion = rolDB.Rows[0].ItemArray[1].ToString()
            };


            // Permisos
            string queryPermisos = string.Format("Select permiso.id, permiso.descripcion from permiso, rol, permiso_por_rol " +
                "where rol.id=permiso_por_rol.rol_id and permiso.id=permiso_por_rol.permiso_id and rol.id={0}", rolDB.Rows[0].ItemArray[0]);
            DataTable permisosDB = _db.LeerPorComando(queryPermisos);
            /*
             * permisosDB - ItemArray[0]=id
             * permisosDB - ItemArray[1]=descripcion
             * **/

            List<Permiso> permisosAuxiliar = new List<Permiso>();
            foreach (DataRow item in permisosDB.Rows)
            {
                Permiso permisoDB = new Permiso()
                {
                    ID = int.Parse(item.ItemArray[0].ToString()),
                    Descripcion = item.ItemArray[1].ToString()
                };
                permisosAuxiliar.Add(permisoDB);
            }

            rolAuxiliar.Permisos = permisosAuxiliar;


            //Persona
            string queryPersona = string.Format("Select id, nombre, apellido, dni, direccion_id from persona where id={0}", usuarioColumnas[1]);
            DataTable personaDB = _db.LeerPorComando(queryPersona);
            /*
             * personaDB - ItemArray[0]=id
             * personaDB - ItemArray[1]=nombre
             * personaDB - ItemArray[2]=apellido
             * personaDB - ItemArray[3]=dni
             * personaDB - ItemArray[4]=direccion_id
             * **/

            Usuario usuario = new Usuario()
            {
                ID = int.Parse(usuarioColumnas[0].ToString()),
                Nombre = personaDB.Rows[0].ItemArray[1].ToString(),
                Apellido = personaDB.Rows[0].ItemArray[2].ToString(),
                DNI = int.Parse(personaDB.Rows[0].ItemArray[3].ToString()),
                Legajo = int.Parse(usuarioColumnas[3].ToString()),
                Rol = rolAuxiliar
            };

            if (DBNull.Value.Equals(usuarioColumnas[4]))
            {
                usuario.Deshabilitado = null;
            }
            else
            {
                usuario.Deshabilitado = Convert.ToDateTime(usuarioColumnas[4].ToString());
            }

            //DIRECCION
            string queryDireccion = string.Format("Select id, calle, altura, localidad, codigo_postal, provincia from direccion where id={0}", personaDB.Rows[0].ItemArray[4]);
            DataTable direccionDB = _db.LeerPorComando(queryDireccion);
            /*
             * direccionDB - ItemArray[0]=id
             * direccionDB - ItemArray[1]=calle
             * direccionDB - ItemArray[2]=altura
             * direccionDB - ItemArray[3]=localidad
             * direccionDB - ItemArray[4]=codigo_postal
             * direccionDB - ItemArray[4]=provincia
             * **/

            Direccion direccionAuxiliar = new Direccion()
            {
                ID = int.Parse(direccionDB.Rows[0].ItemArray[0].ToString()),
                Calle = direccionDB.Rows[0].ItemArray[1].ToString(),
                Altura = direccionDB.Rows[0].ItemArray[2].ToString(),
                Localidad = direccionDB.Rows[0].ItemArray[3].ToString(),
                CodigoPostal = direccionDB.Rows[0].ItemArray[4].ToString(),
                Provincia = direccionDB.Rows[0].ItemArray[5].ToString(),
            };

            usuario.Direccion = direccionAuxiliar;

            return usuario;
        }
        
        /*
         * funcion para obtener una lista con datos de todos los usuarios
         * parametros: null
         * retorna: datatable con datos de usuarios (id_usuario, legajo, nombre, apellido)
         * **/
        public List<Usuario> obtenerListaUsuarios()
        {
            DataTable listaUsuariosDB = new DataTable();
            List<Usuario> usuarios = new List<Usuario>();
            try
            {
                string queryLista = string.Format("SELECT id, persona_id, rol_id, legajo, deshabilitado FROM usuario");
                listaUsuariosDB = _db.LeerPorComando(queryLista);

                foreach (DataRow item in listaUsuariosDB.Rows)
                {
                    usuarios.Add(obtenerUsuarioObj(item.ItemArray));
                }

                return usuarios;
            }
            catch(Exception e)
            {
                throw e;
            }            
        }

        public List<Rol> obtenerListaRoles()
        {
            DataTable listaRolesDB = new DataTable();
            List<Rol> roles = new List<Rol>();
            try
            {
                string queryLista = string.Format("SELECT id, descripcion FROM rol ORDER BY descripcion ASC");
                listaRolesDB = _db.LeerPorComando(queryLista);

                foreach (DataRow item in listaRolesDB.Rows)
                {
                    roles.Add(new Rol() {
                        ID=int.Parse(item.ItemArray[0].ToString()),
                        Descripcion= item.ItemArray[0].ToString()
                    });
                }

                return roles;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        /*
         * funcion para obtener el ultimo id de una tabla
         * parametro: string nombre de la tabla
         * retorna: int id
         * **/
        public int obtenerUltimoId(string tabla)
        {
            try
            {
                string queryUltimoId = string.Format("SELECT TOP 1 id FROM {0} ORDER BY id DESC", tabla);
                DataTable ultimoId = _db.LeerPorComando(queryUltimoId);

                if (int.Parse(ultimoId.Rows[0].ItemArray[0].ToString()) > 0)
                    return int.Parse(ultimoId.Rows[0].ItemArray[0].ToString());
                else
                    throw new Exception("Error al ultimo ID");
            }
            catch(Exception e)
            {
                throw e;
            }
            

        }
        /*
         * funcion para obtener el id de un rol segun su descripcion
         * parametro: string nombre del ron
         * retorna: int id del rol
         * **/
        public int obtenerRolId(string nombreRol)
        {
            try
            {
                string queryRolId = string.Format("SELECT id FROM rol WHERE descripcion = {0}", nombreRol);
                DataTable idRol = _db.LeerPorComando(queryRolId);

                if (int.Parse(idRol.Rows[0].ItemArray[0].ToString()) > 0)                
                    return int.Parse(idRol.Rows[0].ItemArray[0].ToString());                
                else
                    throw new Exception("Rol no encontrado");                
            }
            catch(Exception e)
            {
                throw e;
            }           
        }

        /*
         * funcion para dar de alta a un usuario
         * parametros: object[] con datos del usuario
         * retorna: Usuario
         * **/
        public Usuario altaUsuario(Usuario usuario, string password)
        {

            //INSERT DIRECCION
            string queryDireccion = string.Format("INSERT INTO direccion (calle, altura, localidad, codigo_postal, provincia) VALUES ('{0}','{1}','{2}','{3}','{4}')", 
                usuario.Direccion.Calle,
                usuario.Direccion.Altura,
                usuario.Direccion.Localidad,
                usuario.Direccion.CodigoPostal,
                usuario.Direccion.Provincia);

            if (1 != _db.EscribirPorComando(queryDireccion))
            {
                return null;
            }
            else
            {
                int idDireccion = obtenerUltimoId("direccion");
                
                //INSERT PERSONA
                string queryPersona = string.Format("INSERT INTO persona (apellido, nombre, dni, direccion_id) VALUES ('{0}','{1}',{2},{3})", usuario.Apellido, usuario.Nombre, usuario.DNI, idDireccion);
                
                if (1 != _db.EscribirPorComando(queryPersona))
                {
                    return null;
                }
                else
                {
                    int idPersona = obtenerUltimoId("persona");
                    
                    //INSERT USUARIO
                    string queryUsuario = string.Format("INSERT INTO usuario (persona_id, rol_id, password, legajo) VALUES ({0},{1},'{2}',{3})", 
                        idPersona, 
                        usuario.Rol.ID,
                        password,
                        usuario.Legajo);
                    
                    if (1 != _db.EscribirPorComando(queryUsuario))
                    {
                        return null;
                    }
                    else
                    {
                        int idUsuario = obtenerUltimoId("usuario");
                        usuario.ID = idUsuario;
                        return usuario;
                    }
                }

            }

        }

        public Usuario modificarUsuario(Usuario usuario, string password="")
        {

            //UPDATE DIRECCION
            string queryDireccion = string.Format("UPDATE direccion SET calle='{0}', altura='{1}', localidad='{2}', codigo_postal='{3}', provincia='{4}' WHERE id={5}",
                usuario.Direccion.Calle,
                usuario.Direccion.Altura,
                usuario.Direccion.Localidad,
                usuario.Direccion.CodigoPostal,
                usuario.Direccion.Provincia,
                usuario.Direccion.ID);

            if (1 != _db.EscribirPorComando(queryDireccion))
            {
                return null;
            }
            else
            {
                string queryPersona = string.Format("Select persona_id from usuario where id={0}", usuario.ID);
                DataTable personaDB = _db.LeerPorComando(queryPersona);
                //UPDATE PERSONA
                queryPersona = string.Format("UPDATE persona SET apellido='{0}', nombre='{1}', dni={2} WHERE id={3}", 
                    usuario.Apellido, 
                    usuario.Nombre, 
                    usuario.DNI, 
                    personaDB.Rows[0].ItemArray[0]);

                if (1 != _db.EscribirPorComando(queryPersona))
                {
                    return null;
                }
                else
                {
                    string queryUsuario = "";
                    //UPDATE USUARIO
                    if (password.Equals(""))
                    {
                        queryUsuario = string.Format("UPDATE usuario SET rol_id={0}, legajo={1} where id={2}",
                        usuario.Rol.ID,
                        usuario.Legajo,
                        usuario.ID);
                    }
                    else
                    {
                        queryUsuario = string.Format("UPDATE usuario SET rol_id={0}, legajo={1}, password='{2}' where id={3}",
                        usuario.Rol.ID,
                        password,
                        usuario.Legajo,
                        usuario.ID);
                    }
                    

                    if (1 != _db.EscribirPorComando(queryUsuario))
                    {
                        return null;
                    }
                    else
                    {
                        return usuario;
                    }
                }

            }

        }

        /*
         * funcion para desactivar usuario
         * parametro: Usuario
         * retorna: bool
         * **/
        public Usuario desactivarUsuario(Usuario usuario)
        {
            try
            {
                DateTime deshabilitado = DateTime.Now;
                usuario.Deshabilitado = deshabilitado;
                string sqlFormattedDate = deshabilitado.ToString("yyyy-MM-dd HH:mm:ss.fff");
                string queryUsuario = string.Format("UPDATE usuario SET deshabilitado = '{0}' where id={1}", sqlFormattedDate, usuario.ID);

                if (1 != _db.EscribirPorComando(queryUsuario))
                    return null;
                else
                    return usuario;
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        /*
         * funcion para desactivar usuario
         * parametro: Usuario
         * retorna: bool
         * **/
        public Usuario activarUsuario(Usuario usuario)
        {
            try
            {
                usuario.Deshabilitado = null;
                string queryUsuario = string.Format("UPDATE usuario SET deshabilitado = NULL where id={0}", usuario.ID);

                if (1 != _db.EscribirPorComando(queryUsuario))
                    return null;
                else
                    return usuario;
            }
            catch (Exception e)
            {
                throw e;
            }

        }
    }
}
