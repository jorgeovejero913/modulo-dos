USE [dbTecProg]
GO

/****** Object:  StoredProcedure [dbo].[sp_editar_cliente]    Script Date: 20/6/2021 23:28:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[sp_editar_cliente]
@id_persona int,
@apellido nvarchar(50),
@nombre nvarchar(50),
@dni int,
@calle nvarchar(50),
@altura nvarchar(20),
@localidad nvarchar(50),
@codigo_postal nvarchar(50),
@provincia nvarchar(50)
as
begin
declare @id_direccion int
set @id_direccion = (Select id_direccion from persona where id = @id_persona)
UPDATE persona
   SET apellido = @apellido
      ,nombre = @nombre
      ,dni = @dni
      ,id_direccion = @id_direccion
 WHERE id = @id_persona;

UPDATE [dbo].[direccion]
   SET [calle] = @calle
      ,[altura] = @altura
      ,[localidad] = @localidad
      ,[codigo_postal] = @codigo_postal
      ,[provincia] = @provincia
 WHERE id = @id_direccion;

 return @@ROWCOUNT
end

GO


