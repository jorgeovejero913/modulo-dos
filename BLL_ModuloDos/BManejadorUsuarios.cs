using System;
using System.Collections.Generic;
using System.Text;
using Entidades;
using DAL_ModuloDos;
using BLL_ModuloDos.Excepciones;

namespace BLL_ModuloDos
{
    public class BManejadorUsuarios
    {
        private DManejadorUsuarios _dManejadorUsuarios = new DManejadorUsuarios();


        /// <summary>
        /// Devuelve un listado de usuarios.
        /// </summary>
        /// <returns>Lista del tipo 'List Usuario'</returns>
        public List<Usuario> obtenerListaUsuarios()
        {
            try
            {
                return _dManejadorUsuarios.obtenerListaUsuarios();
            }
            catch (Exception)
            {
                throw new ExcepcionErrorGenerico("Error al tratar de devolver el listado de usuarios.");
            }
        }

        /// <summary>
        /// Da de alta un nuevo usuario
        /// </summary>
        /// <param name="usuario">Objeto del tipo Usuario</param>
        /// <param name="password">string</param>
        /// <param name="confirmPassword">string</param>
        /// <returns>Objeto del tipo 'Usuario'</returns>
        public Usuario altaUsuario(Usuario usuario, string password, string confirmPassword)
        {
            this.validarCampos(usuario);

            if (!password.Equals(confirmPassword))
            {
                throw new ExcepcionPassword();
            }

            Usuario nuevousuario = _dManejadorUsuarios.altaUsuario(usuario, password);

            if (nuevousuario == null)
                throw new ExcepcionErrorGenerico("Error al dar de alta al usuario.");
            else
                return nuevousuario;
            
        }

        /// <summary>
        /// Modifica un usuario
        /// Si la contraseña no se pasa, la misma no se valida con la confirmacion de contraseña y no se actualiza.
        /// </summary>
        /// <param name="usuario">Objeto del tipo Usuario</param>
        /// <param name="password">string</param>
        /// <param name="confirmPassword">string</param>
        /// <returns>Objeto del tipo 'Usuario'</returns>
        public Usuario modicarUsuario(Usuario usuario, string password="", string confirmPassword="")
        {
            this.validarCampos(usuario);

            if (password != "" && !password.Equals(confirmPassword))
            {
                throw new ExcepcionPassword();
            }
            Usuario usuarioModificado = _dManejadorUsuarios.modificarUsuario(usuario, password);

            if (usuarioModificado == null)
                throw new ExcepcionErrorGenerico("Error al modificar un usuario.");
            else
                return usuarioModificado;
        }

        /// <summary>
        /// Desactiva un usuario
        /// </summary>
        /// <param name="usuario">Objeto del tipo Usuario</param>
        /// <returns>Objeto del tipo 'Usuario'</returns>
        public Usuario desactivarUnUsuario(Usuario usuario)
        {
            Usuario usuarioDesactivado = _dManejadorUsuarios.desactivarUsuario(usuario);
            if (usuarioDesactivado == null)
            {
                throw new ExcepcionErrorGenerico("¡Error! no se pudo deshabilitar al usuario");
            }

            return usuarioDesactivado;
            
        }

        /// <summary>
        /// Activa un usuario
        /// </summary>
        /// <param name="usuario">Objeto del tipo Usuario</param>
        /// <returns>Objeto del tipo 'Usuario'</returns>
        public Usuario activarUnUsuario(Usuario usuario)
        {
            Usuario usuarioActivado = _dManejadorUsuarios.activarUsuario(usuario);

            if (usuarioActivado == null)
            {
                throw new ExcepcionErrorGenerico("¡Error! no se pudo activar al usuario");
            }
            return usuarioActivado;
        }

        private void validarCampos(Usuario usuario)
        {
            if (string.IsNullOrEmpty(usuario.Nombre))
            {
                throw new ExcepcionCampoVacio("nombre");
            }

            if (string.IsNullOrEmpty(usuario.Apellido))
            {
                throw new ExcepcionCampoVacio("apellido");
            }

            if (string.IsNullOrEmpty(usuario.DNI.ToString()))
            {
                throw new ExcepcionCampoVacio("DNI");
            }
            else if (usuario.DNI.ToString().Length < 7 || usuario.DNI.ToString().Length > 8)
            {
                throw new ExcepcionDNIInvalido();
            }

            if (string.IsNullOrEmpty(usuario.Legajo.ToString()))
            {
                throw new ExcepcionCampoVacio("legajo");
            }

            if (string.IsNullOrEmpty(usuario.Direccion.Calle))
            {
                throw new ExcepcionCampoVacio("calle");
            }

            if (string.IsNullOrEmpty(usuario.Direccion.Altura))
            {
                throw new ExcepcionCampoVacio("altura");
            }

            if (string.IsNullOrEmpty(usuario.Direccion.Localidad))
            {
                throw new ExcepcionCampoVacio("localidad");
            }

            if (string.IsNullOrEmpty(usuario.Direccion.Provincia))
            {
                throw new ExcepcionCampoVacio("provincia");
            }

            if (usuario.Rol == null)
            {
                throw new ExcepcionNoSeleccionado("el rol");
            }
        }
    }
}   
