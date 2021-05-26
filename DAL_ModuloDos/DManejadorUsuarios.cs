using System;
using System.Collections.Generic;
using System.Data;
using Entidades;

namespace DAL_ModuloDos
{
    
    class DManejadorUsuarios
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
                Calle = direccionDB.Rows[0].ItemArray[1].ToString(),
                Altura = direccionDB.Rows[0].ItemArray[2].ToString(),
                Localidad = direccionDB.Rows[0].ItemArray[3].ToString(),
                CodigoPostal = direccionDB.Rows[0].ItemArray[4].ToString(),
                Provincia = direccionDB.Rows[0].ItemArray[5].ToString(),
            };

            usuario.Direccion = direccionAuxiliar;

            return usuario;
        }
    }
}
