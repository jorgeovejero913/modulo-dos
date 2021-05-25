using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Entidades;

namespace DAL_ModuloDos
{
    public class AutenticacionUsuario
    {
        Conexion _db = new Conexion();

        public Sesion Login(int legajo, string password)
        {
            try
            {
                // HACK: Harcodeamos un usuario. Esto debe hacerse contra la base de datos
                string query = string.Format("Select id, persona_id, rol_id, legajo  from usuario where legajo={0} and password='{1}'", legajo, password);

                DataTable usuarioDB = _db.LeerPorComando(query);

                /*
                 * usuario[0]=id
                 * usuario[1]=persona_id
                 * usuario[2]=rol_id
                 * usuario[3]=legajo
                 * **/

                if (usuarioDB.Rows.Count > 0)
                {
                    string queryRol = string.Format("Select id, descripcion from rol where id={0}", usuarioDB.Rows[0].ItemArray[2]);
                    DataTable rolDB = _db.LeerPorComando(queryRol);


                    Rol rolAuxiliar = new Rol() {
                        ID = int.Parse(rolDB.Rows[0].ItemArray[0].ToString()),
                        Descripcion = rolDB.Rows[0].ItemArray[1].ToString()
                    };

                    string queryPermisos = string.Format("Select permiso.id, permiso.descripcion from permiso, rol, permiso_por_rol " +
                        "where rol.id=permiso_por_rol.rol_id and permiso.id=permiso_por_rol.permiso_id and rol.id={0}", rolDB.Rows[0].ItemArray[0]);
                    DataTable permisosDB = _db.LeerPorComando(queryPermisos);

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
                    string queryPersona = string.Format("Select id, nombre, apellido, dni, direccion_id from persona where id={0}", usuarioDB.Rows[0].ItemArray[1]);
                    DataTable personaDB = _db.LeerPorComando(queryPersona);

                    Usuario usuario = new Usuario()
                    {
                        ID = int.Parse(usuarioDB.Rows[0].ItemArray[0].ToString()),
                        Nombre = personaDB.Rows[0].ItemArray[1].ToString(),
                        Apellido = personaDB.Rows[0].ItemArray[2].ToString(),
                        DNI = int.Parse(personaDB.Rows[0].ItemArray[3].ToString()),
                        Legajo= int.Parse(usuarioDB.Rows[0].ItemArray[3].ToString()),
                        Rol = rolAuxiliar
                    };


                    //DIRECCION
                    string queryDireccion = string.Format("Select id, calle, altura, localidad, codigo_postal, provincia from direccion where id={0}", personaDB.Rows[0].ItemArray[4]);
                    DataTable direccionDB = _db.LeerPorComando(queryDireccion);

                    Direccion direccionAuxiliar = new Direccion(){
                        Calle = direccionDB.Rows[0].ItemArray[1].ToString(),
                        Altura = direccionDB.Rows[0].ItemArray[2].ToString(),
                        Localidad = direccionDB.Rows[0].ItemArray[3].ToString(),
                        CodigoPostal = direccionDB.Rows[0].ItemArray[4].ToString(),
                        Provincia = direccionDB.Rows[0].ItemArray[5].ToString(),
                    };

                    usuario.Direccion = direccionAuxiliar;

                    Sesion sesion = new Sesion();
                    sesion.Usuario = usuario;
                    sesion.Inicio = DateTime.Now;
                    string sqlFormattedDate = sesion.Inicio.ToString("yyyy-MM-dd HH:mm:ss.fff");

                    string insertSesion = string.Format("Insert into sesion(usuario_id, fecha_inicio) values({0}, '{1}')", sesion.Usuario.ID, sqlFormattedDate);

                    if(1 != _db.EscribirPorComando(insertSesion))
                    {
                        throw new Exception("Error al iniciar la sesión");
                    }
                    else
                    {
                        string querySesion = string.Format("Select top 1 id from sesion where usuario_id={0} order by id desc", sesion.Usuario.ID);
                        DataTable sesionDB = _db.LeerPorComando(querySesion);

                        sesion.ID = int.Parse(sesionDB.Rows[0].ItemArray[0].ToString());

                        return sesion;
                    }
                }
                else
                {
                    return null;
                }
            }
            catch (Exception e)
            {

                throw e;
            }
            

        }

        public void Logout()
        {
            //Falta probarlo
            try
            {
                ManejadorDeSesion.Sesion.Fin = DateTime.Now;

                string sqlFormattedDate = ManejadorDeSesion.Sesion.Fin.ToString("yyyy-MM-dd HH:mm:ss.fff");

                string updateSesion = string.Format("UPDATE sesion SET fecha_fin='{0}' where id={1}", sqlFormattedDate, ManejadorDeSesion.Sesion.ID);
               
                if (1 != _db.EscribirPorComando(updateSesion))
                {
                    throw new Exception("Error al cerrar la sesión");
                }

            }
            catch (Exception e)
            {

                throw e;
            }
           
        }

        public Sesion obtenerSesion()
        {
            //Falta Desarrollar
            return new Sesion();
        }

    }
}
