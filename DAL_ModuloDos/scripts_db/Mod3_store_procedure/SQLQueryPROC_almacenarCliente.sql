USE [dbTecProg]
GO

/****** Object:  StoredProcedure [dbo].[sp_almacenar_cliente]    Script Date: 20/6/2021 23:26:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[sp_almacenar_cliente]
@calle nvarchar(50),
@altura nvarchar(50),
@localidad nvarchar(50),
@codigo_postal nvarchar(50),
@provincia nvarchar(50),
@apellido nvarchar(50),
@nombre nvarchar(50),
@dni int

AS
BEGIN

INSERT INTO [dbo].[direccion]
           ([calle]
           ,[altura]
           ,[localidad]
           ,[codigo_postal]
           ,[provincia])
     VALUES
           (@calle
           ,@altura
           ,@localidad
           ,@codigo_postal
           ,@provincia);

INSERT INTO [dbo].[persona]
           ([apellido]
           ,[nombre]
           ,[dni]
           ,[id_direccion])
     VALUES
           (@apellido
           ,@nombre
           ,@dni
           ,(SELECT IDENT_CURRENT ('direccion')));

INSERT INTO [dbo].[cliente]
           ([id_persona])
     VALUES
           ((SELECT IDENT_CURRENT ('persona')));

RETURN @@ROWCOUNT
END;
GO


