USE [dbTecProg]
GO

/****** Object:  StoredProcedure [dbo].[sp_reporte_ventas_semana]    Script Date: 21/6/2021 00:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[sp_reporte_ventas_semana] @fecha datetime, @fecha2 datetime
as
select o.[id]
      ,[fecha]
      ,o.[id_persona] as 'legajo_vendedor'
	  ,pe.nombre +' '+ pe.apellido as 'nombre_vendedor'
	  ,mp.tipo as 'metodo_pago'
	  ,do.cantidad 'cantidad_producto'
	  ,p.precio_venta as 'precio_producto'
	  ,p.nombre as 'nombre_producto'
	  
  from [dbo].[orden] o inner join usuario u on u.id_persona = o.[id_persona] inner join orden_venta ov on o.id = ov.id_orden inner join metodo_pago mp on ov.id_metodo_pago = mp.id_metodo_pago inner join detalle_orden do on o.id = do.id_orden inner join producto p on p.id_producto = do.id_producto inner join persona pe on pe.id = u.id_persona where fecha between @fecha and @fecha2 
GO


