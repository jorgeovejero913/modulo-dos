using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    public class ExcepcionErrorGenerico : ExcepcionBase
    {
        public ExcepcionErrorGenerico(string descripcion="Ha ocurrido un error al tratar de realizar la acción solicitada. Comuniquese con el soporte.")
        {
            this.Descripcion = descripcion;
        }
    }
}
