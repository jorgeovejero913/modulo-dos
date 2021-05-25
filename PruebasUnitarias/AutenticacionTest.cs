using Microsoft.VisualStudio.TestTools.UnitTesting;
using BLL_ModuloDos;
using Entidades;

namespace PruebasUnitarias
{
    [TestClass]
    public class AutenticacionTest
    {
        [TestMethod]
        public void LoginTest()
        {
            
            LoginAplicacion loginAplicacion = new LoginAplicacion();
            loginAplicacion.Login("1", "123456");

            Assert.AreNotEqual(ManejadorDeSesion.Sesion, null);

        }

    }
}
