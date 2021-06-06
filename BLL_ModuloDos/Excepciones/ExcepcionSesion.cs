using BLL_ModulosDos.Excepciones;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL_ModuloDos.Excepciones
{
    class ExcepcionSesion : ExcepcionBase
    {
        public ExcepcionSesion(string descripcion="¡Sesión inválida!")
        {
            this.Descripcion = descripcion;
        }
    }
}
