using System;
using System.Collections.Generic;
using System.Text;
using Entidades;

namespace DAL_ModuloDos
{
    public class AutenticacionUsuario
    {
        const int LEGAJO_ADMINISTRADOR_HACK = 1234;
        const string PASSWORD_ADMINISTRADOR_HACK = "ADMINISTRADOR";
        const int LEGAJO_VENDEDOR_HACK = 1234;
        const string PASSWORD_VENDEDOR_HACK = "VENDEDOR";
        const int LEGAJO_GERENTE_HACK = 1234;
        const string PASSWORD_GERENTE_HACK = "GERENTE";
        const int LEGAJO_ENCARGADO_HACK = 1234;
        const string PASSWORD_ENCARGADO_HACK = "ENCARGADO";

        string[] PERMISOS_ADMINISTRADOR_HACK = { "ADMINISTRAR_USUARIOS" };
        string[] PERMISOS_VENDEDOR_HACK = { "ADMINISTRAR_CLIENTES", "VENDER", "SELECCIONAR_METODO_PAGO"};
        string[] PERMISOS_GERENTE_HACK = { "APRUEBA_ORDENES_COMPRA", "VER_REPORTES"};
        string[] PERMISOS_ENCARGADO_HACK = { "CONTROLAR_STOCK", "CONFIGURAR_ALERTAS", "GENERAR_ORDENES_COMPRA", "INGRESAR_MERCADERIA" };

        public Sesion Login(int legajo, string password)
        {
            try
            {
                // HACK: Harcodeamos un usuario. Esto debe hacerse contra la base de datos
                if ((legajo == LEGAJO_ADMINISTRADOR_HACK 
                    || legajo == LEGAJO_VENDEDOR_HACK 
                    || legajo == LEGAJO_GERENTE_HACK 
                    || legajo == LEGAJO_ENCARGADO_HACK) 
                    && (password.Equals(PASSWORD_ADMINISTRADOR_HACK)
                    || password.Equals(PASSWORD_VENDEDOR_HACK)
                    || password.Equals(PASSWORD_GERENTE_HACK)
                    || password.Equals(PASSWORD_ENCARGADO_HACK))
                   )
                {

                    Rol rolAuxiliar = new Rol();
                    List<Permiso> permisosAuxiliar = new List<Permiso>();

                    if (password.Equals(PASSWORD_ADMINISTRADOR_HACK))
                    {
                        rolAuxiliar.Descripcion="Administrador";

                        foreach (var permiso in PERMISOS_ADMINISTRADOR_HACK)
                        {
                            permisosAuxiliar.Add(new Permiso(permiso));
                        }

                    }
                    if (password.Equals(PASSWORD_VENDEDOR_HACK))
                    {
                        rolAuxiliar.Descripcion = "Vendedor";

                        foreach (var permiso in PERMISOS_VENDEDOR_HACK)
                        {
                            permisosAuxiliar.Add(new Permiso(permiso));
                        }

                    }
                    if (password.Equals(PASSWORD_ENCARGADO_HACK))
                    {
                        rolAuxiliar.Descripcion = "Encargado de inventario y logística";

                        foreach (var permiso in PERMISOS_ENCARGADO_HACK)
                        {
                            permisosAuxiliar.Add(new Permiso(permiso));
                        }

                    }
                    if (password.Equals(PASSWORD_GERENTE_HACK))
                    {
                        rolAuxiliar.Descripcion = "Gerente";

                        foreach (var permiso in PERMISOS_GERENTE_HACK)
                        {
                            permisosAuxiliar.Add(new Permiso(permiso));
                        }

                    }

                    rolAuxiliar.Permisos = permisosAuxiliar;

                    Direccion direccionAuxiliar = new Direccion();
                    direccionAuxiliar.Calle = "Calle";
                    direccionAuxiliar.Altura = "123";
                    direccionAuxiliar.CodigoPostal = "1842";

                    Usuario usuarioPrueba = new Usuario();
                    usuarioPrueba.Rol = rolAuxiliar;
                    usuarioPrueba.Legajo = legajo;
                    usuarioPrueba.Nombre = "Usuario";
                    usuarioPrueba.Apellido = "Prueba";
                    usuarioPrueba.Direccion = direccionAuxiliar;
                    usuarioPrueba.DNI = 11222333;

                    Sesion prueba = new Sesion();
                    prueba.Usuario = usuarioPrueba;
                    prueba.Inicio = DateTime.Now;

                    return prueba;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception e)
            {

                throw e;
            }
            

        }

        public void Logout()
        {

            try
            {
                ManejadorDeSesion.Sesion.Fin = DateTime.Now;
                //TODO: Aca se setearia en la base de datos la fecha de fin de la sesion

                
            }
            catch (Exception e)
            {

                throw e;
            }
           
        }

    }
}
