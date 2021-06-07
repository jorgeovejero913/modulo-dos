using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    class ExcepcionNoSeleccionado : ExcepcionBase
    {
        public ExcepcionNoSeleccionado(string campo)
        {
            this.Descripcion = string.Format("Debes seleccionar una opción para {0}", campo);
        }
    }
}
