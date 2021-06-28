USE [dbTecProg]
GO

/****** Object:  StoredProcedure [dbo].[sp_almacenar_detalle]    Script Date: 20/6/2021 23:26:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[sp_almacenar_detalle]
@cantidad int,
@idProducto int
AS
BEGIN

INSERT INTO [dbo].[detalle_orden]
           ([cantidad]
           ,[id_orden]
           ,[id_producto])
     VALUES
           (@cantidad
		   ,(SELECT IDENT_CURRENT ('orden') AS id_orden)
		   ,@idProducto);

UPDATE stock
   SET cantidad = cantidad - @cantidad
 WHERE id_producto = @idProducto;

RETURN @@ROWCOUNT
END
GO


