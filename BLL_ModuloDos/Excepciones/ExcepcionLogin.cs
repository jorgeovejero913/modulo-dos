using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    class ExcepcionLogin : ExcepcionBase
    {
        public ExcepcionLogin()
        {
            this.Descripcion = "¡Legajo y/o Contraseña incorrectos!";
        }
    }
}
