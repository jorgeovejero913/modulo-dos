using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    class ExcepcionDNIInvalido : ExcepcionBase
    {
        public ExcepcionDNIInvalido()
        {
            this.Descripcion = "El DNI ingresado es inválido.";
        }
    }
}
