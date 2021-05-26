using System;
using System.Collections.Generic;
using System.Text;
using Entidades;
using DAL_ModuloDos;

namespace BLL_ModuloDos
{
    public class BManejadorUsuarios
    {
        private DManejadorUsuarios _dManejadorUsuarios = new DManejadorUsuarios();
             
        public Usuario altaUsuario(string[] datos)
        {
            try
            {
                Usuario nuevousuario = new Usuario();
                nuevousuario = _dManejadorUsuarios.altaUsuario(datos);

                if (nuevousuario == null)
                    throw new Exception("Error al dar de alta al usuario.");
                else
                    return nuevousuario;
            }
            catch(Exception e)
            {
                throw e;
            }
        }

        public bool desactivarUnUsuario(int usuarioId)
        {
            try
            {
                if(_dManejadorUsuarios.desactivarUsuario(usuarioId) == false)
                {
                    throw new Exception("Error! no se pudo dar de alta al usuario");
                }
                else
                {
                    return true;
                }
            }
            catch(Exception e)
            {
                throw e;
            }
        }
    }
}
