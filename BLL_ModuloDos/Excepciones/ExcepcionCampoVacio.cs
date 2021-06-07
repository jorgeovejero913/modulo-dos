using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    class ExcepcionCampoVacio : ExcepcionBase
    {
        public ExcepcionCampoVacio(string campo)
        {
            this.Descripcion = string.Format("El campo {0} no puede estar vacío.", campo);
        }
    }
}
