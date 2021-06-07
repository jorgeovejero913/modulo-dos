using Microsoft.VisualStudio.TestTools.UnitTesting;
using BLL_ModuloDos;
using Entidades;
using System.Collections.Generic;

namespace PruebasUnitarias
{
    [TestClass]
    public class ManejadorUsuariosTest
    {

        [TestMethod]
        public void AltaUsuarios()
        {
            BManejadorUsuarios _bManejadorUsuarios = new BManejadorUsuarios();
            BManejadorRoles _bManejadorRoles = new BManejadorRoles();

            List<Rol> roles = _bManejadorRoles.obtenerRoles();

            Direccion direccion = new Direccion()
            {
                Calle= "Las rosas",
                Altura= "123",
                CodigoPostal="1842",
                Localidad="Monte Grande",
                Provincia="Buenos AIRES"
            };

            Usuario usuario = new Usuario()
            {
                Nombre="Florencia Noemi",
                Apellido="Morrone 30/05",
                Legajo=12451,
                Rol=roles[0],
                DNI=4223334,
                Direccion=direccion
            };

            Usuario nuevoUsuario = _bManejadorUsuarios.altaUsuario(usuario, "flor1", "flor1");

            Assert.AreNotEqual(null, nuevoUsuario);
            
        }

        [TestMethod]
        public void ModificarUsuarios()
        {
            BManejadorUsuarios _bManejadorUsuarios = new BManejadorUsuarios();
            BManejadorRoles _bManejadorRoles = new BManejadorRoles();

            List<Rol> roles = _bManejadorRoles.obtenerRoles();
            Usuario usuario = _bManejadorUsuarios.obtenerListaUsuarios()[0];

            usuario.Nombre = "Maria";
            usuario.Direccion.Calle = "Uriarte";
            Usuario nuevoUsuario = _bManejadorUsuarios.modicarUsuario(usuario);

            Assert.AreNotEqual(null, nuevoUsuario);

        }

        [TestMethod]
        public void DesactivarUsuarioTest()
        {
            
            BManejadorUsuarios manejadorUsuario = new BManejadorUsuarios();
            Usuario usuario = manejadorUsuario.obtenerListaUsuarios()[0];

            Usuario usuarioDesactivado = manejadorUsuario.desactivarUnUsuario(usuario);

            Assert.AreNotEqual(null, usuarioDesactivado.Deshabilitado);
            
        }

        [TestMethod]
        public void ActivarUsuarioTest()
        {

            BManejadorUsuarios manejadorUsuario = new BManejadorUsuarios();
            Usuario usuario = manejadorUsuario.obtenerListaUsuarios()[0];

            Usuario usuarioActivado = manejadorUsuario.activarUnUsuario(usuario);

            Assert.AreEqual(null, usuarioActivado.Deshabilitado);

        }

    }
}
