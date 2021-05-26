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
        /// Método para el logueo de un usuario
        /// </summary>
        /// <param name="legajo">Número de legajo</param>
        /// <param name="password">Contraseña</param>
        /// <returns>Un objeto del tipo Sesion</returns>
        public Sesion Login(int legajo, string password)
        {
            try
            {
                string query = string.Format("Select id, persona_id, rol_id, legajo from usuario where legajo={0} and password='{1}'", legajo, password);
                DataTable usuarioDB = _db.LeerPorComando(query);

                if (usuarioDB.Rows.Count > 0)
                {
                    
                    Sesion sesion = new Sesion();
                    sesion.Usuario = manejadorUsuarios.obtenerUsuarioObj(usuarioDB.Rows[0].ItemArray);
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
            try
            {
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

        public bool SesionValida()
        {
            string querySesion = string.Format("Select top 1 id, usuario_id, fecha_inicio from sesion where id = {0} and fecha_fin is null", ManejadorDeSesion.Sesion.ID);
            DataTable sesionDB = _db.LeerPorComando(querySesion);

            if(sesionDB.Rows.Count == 0)
            {
                return false;
            }
            return true;
        }
    }
}
