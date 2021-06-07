using System;
using System.Collections.Generic;
using System.Text;
using Entidades;
using DAL_ModuloDos;
using BLL_ModuloDos.Excepciones;

namespace BLL_ModuloDos
{
    public class BManejadorRoles
    {
        private DManejadorRoles _dManejadorRoles = new DManejadorRoles();


        /// <summary>
        /// Obtiene una lista de Roles
        /// </summary>
        /// <returns>Lista del tipo 'List Rol'</returns>
        public List<Rol> obtenerRoles()
        {
            try
            {
                return _dManejadorRoles.obtenerListaRoles();
            }
            catch (Exception)
            {

                throw new ExcepcionErrorGenerico("Error al obtener el listado de roles.");
            }
        }
    }
}
