using Microsoft.VisualStudio.TestTools.UnitTesting;
using BLL_ModuloDos;
using Entidades;

namespace PruebasUnitarias
{
    [TestClass]
    public class ManejadorUsuariosTest
    {

        [TestMethod]
        public void AltaUsuarios()
        {
            string[] data = { "Test", "Test", "1223132", "21331", "pass", "bsas", "caba", "1234", "San Martin", "234", "gerente" };
            BManejadorUsuarios manejadorUsuario = new BManejadorUsuarios();
            Usuario nuevoUsuario = manejadorUsuario.altaUsuario(data);

            Assert.AreNotEqual(nuevoUsuario, null);

        }

        [TestMethod]
        public void DesactivarUsuario()
        {
            int usuarioId = 3;
            BManejadorUsuarios manejadorUsuario = new BManejadorUsuarios();

            Assert.AreEqual(manejadorUsuario.desactivarUnUsuario(usuarioId), true);

        }

    }
}
