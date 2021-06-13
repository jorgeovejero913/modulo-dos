using System;
using System.Data;
using Entidades;

namespace DAL_ModuloDos
{
    public class DAutenticacion
    {
        Conexion _db = new Conexion();
        DManejadorUsuarios manejadorUsuarios = new DManejadorUsuarios();

        /// <summary>
        /// Método para el logueo de un usuario en la base de datos
        /// </summary>
        /// <param name="legajo">Número de legajo</param>
        /// <param name="password">Contraseña</param>
        /// <returns>Un objeto del tipo 'Sesion'</returns>
        public Sesion Login(int legajo, string password)
        {
            string query = string.Format("Select id_persona, id_rol, legajo, deshabilitado from usuario where legajo={0} and password='{1}'", legajo, password);
            DataTable usuarioDB = _db.LeerPorComando(query);

                if (usuarioDB.Rows.Count > 0 && !DBNull.Value.Equals(usuarioDB.Rows[0].ItemArray[3]))
                {
                    
                Sesion sesion = new Sesion();
                sesion.Usuario = manejadorUsuarios.obtenerUsuarioObj(usuarioDB.Rows[0].ItemArray);
                sesion.Inicio = DateTime.Now;
                string sqlFormattedDate = sesion.Inicio.ToString("yyyy-MM-dd HH:mm:ss.fff");

                string insertSesion = string.Format("Insert into sesion(id_usuario, fecha_inicio) values({0}, '{1}')", sesion.Usuario.ID, sqlFormattedDate);

                if(1 != _db.EscribirPorComando(insertSesion))
                {
                    throw new Exception("Error al iniciar la sesión");
                }
                else
                {
                    string querySesion = string.Format("Select top 1 id from sesion where id_usuario={0} order by id desc", sesion.Usuario.ID);
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


        /// <summary>
        /// Cierra la sesión en la base de datos
        /// </summary>
        public void Logout()
        {
            string sqlFormattedDate = ManejadorDeSesion.Sesion.Fin.ToString("yyyy-MM-dd HH:mm:ss.fff");

            string updateSesion = string.Format("UPDATE sesion SET fecha_fin='{0}' where id={1}", sqlFormattedDate, ManejadorDeSesion.Sesion.ID);
               
            if (1 != _db.EscribirPorComando(updateSesion))
            {
                throw new Exception("Error al cerrar la sesión");
            }
        }

        /// <summary>
        /// Comprueba si existe una sesión valida en la base de datos del usuario autenticado.
        /// </summary>
        public bool SesionValida()
        {
            string querySesion = string.Format("Select top 1 id, id_usuario, fecha_inicio from sesion where id = {0} and fecha_fin is null", ManejadorDeSesion.Sesion.ID);
            DataTable sesionDB = _db.LeerPorComando(querySesion);

            if(sesionDB.Rows.Count == 0)
            {
                return false;
            }
            return true;
        }
    }
}
