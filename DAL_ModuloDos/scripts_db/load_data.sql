/* Carga de datos iniciales*/

/*Datos Tabla Direccion*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[direccion]
           ([calle]
           ,[altura]
           ,[localidad]
           ,[codigo_postal]
           ,[provincia])
     VALUES
           ('Las Rosas', '3245','Monte Grande','1842','Buenos Aires'),
		   ('Malvinas', '464','Luis Guillon','1200','Buenos Aires'),
		   ('Las Heras', '4556','Lomas de Zamora','1800','Buenos Aires'),
		   ('Fair', '123','Ezeiza','1111','Buenos Aires'),
		   ('Oliver', '3454','Monte Grande','1842','Buenos Aires'),
		   ('9 de Julio', '355','Monte Grande','1842','Buenos Aires'),
		   ('Las Rosas', '34','Monte Grande','1842','Buenos Aires'),
		   ('25 de Mayo', '34','Ezeiza','1333','Buenos Aires')

GO





/*Datos Tabla Personas*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[persona]
           ([apellido]
           ,[nombre]
           ,[dni]
		   ,[id_direccion])
     VALUES
		   ('Morrone','Florencia','22333444', 1),
		   ('Solohaga','Braian','22333111', 2),
		   ('Ovejero','Jorge','33444666', 3),
           ('Ramirez','Martin','33444555', 4),
           ('Santos','Mario','33666999', 5),
           ('Medina','Gabriel','11333999', 6),
           ('Lampone','Pablo','11222999', 7),
           ('Ravenna','Emilio','11555999', 8)

GO

/*Datos Tabla Permiso*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[permiso]
           ([descripcion])
     VALUES
		   ('ADMINISTRAR_USUARIOS'),
		   ('CONTROLAR_STOCK'),
		   ('CONFIGURAR_ALERTAS'),
		   ('GENERAR_ORDEN_DE_COMPRA'),
		   ('VENDER_PRODUCTOS'),
		   ('GESTIONAR_CLIENTES'),
		   ('APROBAR_ORDEN_DE_COMPRA'),
		   ('VER_REPORTES_DE_VENTA')
GO



/*Datos Tabla Rol*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[rol]
           ([descripcion])
     VALUES
		   ('Administrador'),
		   ('Encargado de inventario y logistica'),
		   ('Vendedor'),
		   ('Gerente')
GO


/*Datos Tabla Permiso_Por_Rol*/
USE [dbTecProg]
GO
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(1,1)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(2,2)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(2,3)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(2,4)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(3,5)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(3,6)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(4,7)
INSERT INTO [dbo].[permiso_por_rol]([id_rol],[id_permiso]) VALUES(4,8)
GO


/*Datos Tabla Usuario*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[usuario]
           ([id_persona]
           ,[id_rol]
           ,[password]
           ,[legajo])
     VALUES
			((select persona.id from persona where persona.apellido like 'morrone'),1, '123456', '0001'),
			((select persona.id from persona where persona.apellido like 'solohaga'),1, '123456', '0002'),
			((select persona.id from persona where persona.apellido like 'ovejero'),1, '123456', '0003'),
			((select persona.id from persona where persona.apellido like 'ramirez'),1, '123456', '0004'),
			((select persona.id from persona where persona.apellido like 'santos'),2, '123456', '0005'),
			((select persona.id from persona where persona.apellido like 'medina'),3, '123456', '0006'),
			((select persona.id from persona where persona.apellido like 'lampone'),4, '123456', '0007'),
			((select persona.id from persona where persona.apellido like 'ravenna'),4, '123456', '0008')

GO