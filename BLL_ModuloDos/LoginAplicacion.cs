using System;
using System.Collections.Generic;
using System.Text;
using DAL_ModuloDos;
using Entidades;

namespace BLL_ModuloDos
{
    public class LoginAplicacion
    {

        private AutenticacionUsuario _autenticacionUsuario;

        public LoginAplicacion()
        {
            _autenticacionUsuario = new AutenticacionUsuario();
        }

        public void Login(string legajo, string password)
        {

            try
            {
                if (String.IsNullOrEmpty(password) || String.IsNullOrEmpty(password)) throw new Exception("Los valores no pueden estar vacios");

                Sesion sesion = _autenticacionUsuario.Login(int.Parse(legajo), password);
                if (sesion == null) throw new Exception("Legajo/Contraseña incorrectos.");

                ManejadorDeSesion.Login(sesion);
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
                _autenticacionUsuario.Logout();
                ManejadorDeSesion.Logout();
            }
            catch (Exception e)
            {

                throw e;
            }
            
        }
    }
}
