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


        /// <summary>
        /// Consulta y devuelve los roles cargados en la base de datos
        /// </summary>
        /// <returns>Objeto del tipo 'List Rol'</returns>
        public List<Rol> obtenerListaRoles()
        {
            DataTable listaRolesDB;
            List<Rol> roles = new List<Rol>();

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
    }
}
