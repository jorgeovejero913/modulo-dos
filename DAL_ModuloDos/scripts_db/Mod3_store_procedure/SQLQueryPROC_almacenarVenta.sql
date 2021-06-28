USE [dbTecProg]
GO

/****** Object:  StoredProcedure [dbo].[sp_almacenar_venta_efectivo]    Script Date: 20/6/2021 23:27:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROC [dbo].[sp_almacenar_venta_efectivo]
@tipoMetodoDePago varchar(50),
@idPersona int,
@idCliente int
AS
BEGIN


INSERT INTO [dbo].[orden]
           ([fecha]
           ,[id_persona])
     VALUES
           ((Select getdate())
           ,@idPersona);

INSERT INTO [dbo].[orden_venta]
           ([id_orden]
           ,[id_metodo_pago]
		   ,[id_cliente])
     VALUES
           ((SELECT IDENT_CURRENT ('orden'))
           ,(SELECT id_metodo_pago from metodo_pago where TIPO = @tipoMetodoDePago)
		   ,@idCliente);

RETURN @@ROWCOUNT
END;
GO


USE [dbTecProg]
GO

/****** Object:  StoredProcedure [dbo].[sp_almacenar_venta_tarjeta]    Script Date: 20/6/2021 23:27:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[sp_almacenar_venta_tarjeta]
@tipoMetodoDePago varchar(50),
@idPersona int,
@idCliente int,
@cvc varchar(50),
@fechaVencimiento varchar(50),
@nombreTarjeta varchar(50),
@nroTarjeta nvarchar(50)
AS
BEGIN


INSERT INTO [dbo].[orden]
           ([fecha]
           ,[id_persona])
     VALUES
           ((Select getdate())
           ,@idPersona );

INSERT INTO [dbo].[orden_venta]
           ([id_orden]
           ,[id_metodo_pago]
		   ,[id_cliente])
     VALUES
           ((SELECT IDENT_CURRENT ('orden'))
           ,(SELECT id_metodo_pago from metodo_pago where TIPO = @tipoMetodoDePago)
		   ,@idCliente);

INSERT INTO [dbo].[tarjeta]
		   ([cvc]
		   ,[fecha_vencimiento]
	       ,[nombre_tarjeta]
	       ,[numero_tarjeta]
	       ,[id_orden])
	VALUES
		   (@cvc
		   ,@fechaVencimiento
		   ,@nombreTarjeta
		   ,@nroTarjeta
		   ,(SELECT IDENT_CURRENT ('orden')));

RETURN @@ROWCOUNT
END;
GO

