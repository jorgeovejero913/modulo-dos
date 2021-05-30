using System;
using System.Collections.Generic;
using System.Text;
using Entidades;
using DAL_ModuloDos;

namespace BLL_ModuloDos
{
    public class BManejadorRoles
    {
        private DManejadorRoles _dManejadorRoles = new DManejadorRoles();

        public List<Rol> obtenerRoles()
        {
            try
            {
                return _dManejadorRoles.obtenerListaRoles();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
