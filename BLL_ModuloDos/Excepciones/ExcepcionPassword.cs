using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    public class ExcepcionPassword : ExcepcionBase
    {
        public ExcepcionPassword()
        {
            this.Descripcion = "¡Las contraseñas no coinciden! Ingrese nuevamente.";
        }
    }
}
