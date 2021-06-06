using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL_ModulosDos.Excepciones
{
    public class ExcepcionBase : Exception
    {
        private string _descripcion;

        public string Descripcion
        {
            get { return _descripcion; }
            set { _descripcion = value; }
        }

    }
}

