using Microsoft.VisualStudio.TestTools.UnitTesting;
using BLL_ModuloDos;
using Entidades;

namespace PruebasUnitarias
{
    [TestClass]
    public class AutenticacionTest
    {
        [TestMethod]
        public void LoginLogoutTest()
        {
            
            BAutenticacion loginAplicacion = new BAutenticacion();
            loginAplicacion.Login("4", "1234");

            Assert.AreNotEqual(ManejadorDeSesion.Sesion, null);

            loginAplicacion.Logout();

            Assert.AreEqual(ManejadorDeSesion.Sesion, null);

        }
    }
}
