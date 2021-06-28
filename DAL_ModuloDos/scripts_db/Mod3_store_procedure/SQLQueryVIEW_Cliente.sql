USE [dbTecProg]
GO

/****** Object:  View [dbo].[v_Cliente]    Script Date: 15/6/2021 22:39:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_Cliente]
as
SELECT       c.id_cliente,
			 p.nombre,
			 p.apellido, 
			 dni = convert(nvarchar(10),p.dni), 
			 d.calle, 
			 d.altura, 
			 d.localidad, 
			 d.codigo_postal, 
			 d.provincia
		FROM cliente c
		INNER JOIN dbo.persona p ON c.id_persona = p.id 
		INNER JOIN dbo.direccion d ON p.id_direccion = d.id
GO


