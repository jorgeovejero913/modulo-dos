/* Carga de datos iniciales*/


/*Datos Tabla Personas*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[persona]
           ([apellido]
           ,[nombre]
           ,[dni])
     VALUES
		   ('Morrone','Florencia','22333444'),
		   ('Solohaga','Braian','22333111'),
		   ('Ovejero','Jorge','33444666'),
           ('Ramirez','Martin','33444555'),
           ('Santos','Mario','33666999'),
           ('Medina','Gabriel','11333999'),
           ('Lampone','Pablo','11222999'),
           ('Ravenna','Emilio','11555999')

GO

/*Datos Tabla Rol*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[rol]
           ([descripcion])
     VALUES
           ('superadmin'),
		   ('Administrador'),
		   ('Encargado'),
		   ('Vendedor'),
		   ('Gerente')
GO


/*Datos Tabla Usuario*/
USE [dbTecProg]
GO

INSERT INTO [dbo].[usuario]
           ([persona_id]
           ,[rol_id]
           ,[username]
           ,[password]
           ,[legajo])
     VALUES
			((select persona.id from persona where persona.apellido like 'morrone'),1,'morrone', '123456', '0001'),
			((select persona.id from persona where persona.apellido like 'solohaga'),1,'solohaga', '123456', '0002'),
			((select persona.id from persona where persona.apellido like 'ovejero'),1,'ovejero', '123456', '0003'),
			((select persona.id from persona where persona.apellido like 'ramirez'),1,'ramirez', '123456', '0004'),
			((select persona.id from persona where persona.apellido like 'santos'),2,'santos', '123456', '0005'),
			((select persona.id from persona where persona.apellido like 'medina'),3,'medina', '123456', '0006'),
			((select persona.id from persona where persona.apellido like 'lampone'),4,'lampone', '123456', '0007'),
			((select persona.id from persona where persona.apellido like 'ravenna'),5,'ravenna', '123456', '0008')

GO
