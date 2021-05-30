using System;
using System.Collections.Generic;
using System.Text;
using Entidades;
using System.Data;

namespace DAL_ModuloDos
{
    public class DManejadorRoles
    {
        Conexion _db = new Conexion();

        public List<Rol> obtenerListaRoles()
        {
            DataTable listaRolesDB = new DataTable();
            List<Rol> roles = new List<Rol>();
            try
            {
                string queryLista = string.Format("SELECT id, descripcion FROM rol ORDER BY descripcion ASC");
                listaRolesDB = _db.LeerPorComando(queryLista);

                foreach (DataRow item in listaRolesDB.Rows)
                {
                    roles.Add(new Rol()
                    {
                        ID = int.Parse(item.ItemArray[0].ToString()),
                        Descripcion = item.ItemArray[0].ToString()
                    });
                }

                return roles;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
