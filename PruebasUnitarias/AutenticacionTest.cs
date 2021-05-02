using Microsoft.VisualStudio.TestTools.UnitTesting;
using BLL_ModuloDos;
using Entidades;

namespace PruebasUnitarias
{
    [TestClass]
    public class AutenticacionTest
    {
        [TestMethod]
        public void LoginAndLogout()
        {
            
            LoginAplicacion loginAplicacion = new LoginAplicacion();
            loginAplicacion.Login("1234", "ADMINISTRADOR");

            Assert.AreNotEqual(ManejadorDeSesion.Sesion, null);

            loginAplicacion.Logout();
            Assert.AreEqual(ManejadorDeSesion.Sesion, null);

        }

    }
}
