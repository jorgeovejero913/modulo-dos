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
             
        public List<Usuario> obtenerListaUsuarios()
        {
            try
            {
                return _dManejadorUsuarios.obtenerListaUsuarios();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Usuario altaUsuario(Usuario usuario, string password, string confirmPassword)
        {
            try
            {
                if (!password.Equals(confirmPassword))
                {
                    throw new Exception("Las contraseñas deben coincidir.");
                }
                Usuario nuevousuario = _dManejadorUsuarios.altaUsuario(usuario, password);

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

        public Usuario modicarUsuario(Usuario usuario, string password="", string confirmPassword="")
        {
            try
            {
                if (password != "" && !password.Equals(confirmPassword))
                {
                    throw new Exception("Las contraseñas deben coincidir.");
                }
                Usuario usuarioModificado = _dManejadorUsuarios.modificarUsuario(usuario, password);

                if (usuarioModificado == null)
                    throw new Exception("Error al modificar un usuario.");
                else
                    return usuarioModificado;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Usuario desactivarUnUsuario(Usuario usuario)
        {
            try
            {
                Usuario usuarioDesactivado = _dManejadorUsuarios.desactivarUsuario(usuario);
                if (usuarioDesactivado == null)
                {
                    throw new Exception("Error! no se pudo deshabilitar al usuario");
                }
                return usuarioDesactivado;
            }
            catch(Exception e)
            {
                throw e;
            }
        }

        public Usuario activarUnUsuario(Usuario usuario)
        {
            try
            {
                Usuario usuarioActivado = _dManejadorUsuarios.activarUsuario(usuario);

                if (usuarioActivado == null)
                {
                    throw new Exception("Error! no se pudo activar al usuario");
                }
                return usuarioActivado;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}   
