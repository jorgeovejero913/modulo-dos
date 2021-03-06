using System;
using System.Collections.Generic;
using System.Text;
using BLL_ModuloDos.Excepciones;
using DAL_ModuloDos;
using Entidades;

namespace BLL_ModuloDos
{
    public class BAutenticacion
    {

        private DAutenticacion _autenticacionUsuario;

        public BAutenticacion()
        {
            _autenticacionUsuario = new DAutenticacion();
        }

        
        /// <summary>
        /// Inicia la sesión del usuario en base a su legajo y contraseña
        /// </summary>
        /// <param name="legajo">Numero de legajo</param>
        /// <param name="password">Contraseña</param>
        public void Login(string legajo, string password)
        {

            if (String.IsNullOrEmpty(password) || String.IsNullOrEmpty(legajo)) throw new Exception("Los valores no pueden estar vacios");

            Sesion sesion = _autenticacionUsuario.Login(int.Parse(legajo), password);
            if (sesion == null) throw new ExcepcionLogin();
                
            ManejadorDeSesion.Login(sesion);
            
        }

        
        /// <summary>
        /// Cierra la sesion del usuario
        /// </summary>
        public void Logout()
        {
            if (ManejadorDeSesion.Sesion == null)
                throw new ExcepcionSesion("No existe una sesion iniciada para cerrarla.");

            ManejadorDeSesion.Sesion.Fin = DateTime.Now;

            _autenticacionUsuario.Logout();

            ManejadorDeSesion.Logout();
        }

        // <summary>
        /// Verifica si la sesión es valida. En caso negativo, desloguea al usuario.
        /// Caso pensado: Se deshabilita un usuario logueado y, en consecuencia, se cierra su sesion a nivel base de datos, pero no a nivel aplicacion(porque es imposible)
        /// Entonces al llamar este metodo siempre antes de cualquier operación, validamos que ningín usuario deshabilitado pueda afectar la informacion del sistema.
        /// </summary>
        public void VerificarSesion()
        {
            if (ManejadorDeSesion.Sesion == null)
                throw new ExcepcionSesion("No existe una sesion iniciada.");
            if (!_autenticacionUsuario.SesionValida())
            {
                ManejadorDeSesion.Logout();
                throw new ExcepcionSesion("Su sesion no es válida, por lo tanto se ha cerrado.");
            }
        }
    }
}
