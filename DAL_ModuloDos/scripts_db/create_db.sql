/****** Script de creaccion DB ******/
/*
	v1: Creacion de tablas  modulos 2, 3, 4


	NOTA: Se deben modificar las rutas donde se guradaran los archivos, en el caso de que sea necesario.
*/
/****** START ******/
USE [master]
GO
/****** Object:  Database [dbTecProg]    Script Date: 31/5/2021 14:05:26 ******/
CREATE DATABASE [dbTecProg]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbTecProg', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\dbTecProg.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbTecProg_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\dbTecProg_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [dbTecProg] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbTecProg].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbTecProg] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbTecProg] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbTecProg] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbTecProg] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbTecProg] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbTecProg] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbTecProg] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbTecProg] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbTecProg] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbTecProg] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbTecProg] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbTecProg] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbTecProg] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbTecProg] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbTecProg] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbTecProg] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbTecProg] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbTecProg] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbTecProg] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbTecProg] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbTecProg] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbTecProg] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbTecProg] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbTecProg] SET  MULTI_USER 
GO
ALTER DATABASE [dbTecProg] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbTecProg] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbTecProg] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbTecProg] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbTecProg] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbTecProg] SET QUERY_STORE = OFF
GO
USE [dbTecProg]
GO
/****** Object:  Table [dbo].[direccion]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[direccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[calle] [nvarchar](50) NULL,
	[altura] [nvarchar](20) NULL,
	[localidad] [nvarchar](50) NOT NULL,
	[codigo_postal] [nvarchar](50) NULL,
	[provincia] [nvarchar](50) NULL,
 CONSTRAINT [PK_direccion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permiso]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permiso](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_permiso] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permiso_por_rol]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permiso_por_rol](
	[id_rol] [int] NOT NULL,
	[id_permiso] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persona]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persona](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[apellido] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[dni] [int] NOT NULL,
	[id_direccion] [int] NULL,
 CONSTRAINT [PK_persona] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_persona] UNIQUE NONCLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_rol] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sesion]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sesion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NULL,
 CONSTRAINT [PK_sesion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 31/5/2021 14:05:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [int] NOT NULL,
	[id_rol] [int] NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[legajo] [int] NOT NULL,
	[deshabilitado] [bit] NOT NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[usuario] ADD  CONSTRAINT [DF_usuario_deshabilitado]  DEFAULT ((0)) FOR [deshabilitado]
GO
ALTER TABLE [dbo].[permiso_por_rol]  WITH CHECK ADD  CONSTRAINT [FK_permiso_por_rol_permiso] FOREIGN KEY([id_permiso])
REFERENCES [dbo].[permiso] ([id])
GO
ALTER TABLE [dbo].[permiso_por_rol] CHECK CONSTRAINT [FK_permiso_por_rol_permiso]
GO
ALTER TABLE [dbo].[permiso_por_rol]  WITH CHECK ADD  CONSTRAINT [FK_permiso_por_rol_rol] FOREIGN KEY([id_rol])
REFERENCES [dbo].[rol] ([id])
GO
ALTER TABLE [dbo].[permiso_por_rol] CHECK CONSTRAINT [FK_permiso_por_rol_rol]
GO
ALTER TABLE [dbo].[persona]  WITH CHECK ADD  CONSTRAINT [FK_persona_direccion] FOREIGN KEY([id_direccion])
REFERENCES [dbo].[direccion] ([id])
GO
ALTER TABLE [dbo].[persona] CHECK CONSTRAINT [FK_persona_direccion]
GO
ALTER TABLE [dbo].[sesion]  WITH CHECK ADD  CONSTRAINT [FK_sesion_usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[sesion] CHECK CONSTRAINT [FK_sesion_usuario]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_persona] FOREIGN KEY([id_persona])
REFERENCES [dbo].[persona] ([id])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_persona]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_rol] FOREIGN KEY([id_rol])
REFERENCES [dbo].[rol] ([id])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_rol]
GO
USE [master]
GO
ALTER DATABASE [dbTecProg] SET  READ_WRITE 
GO



/****** MODULO 3 ******/

/* Drop Foreign Key Constraints */

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_CLIENTE_PERSONA]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [CLIENTE] DROP CONSTRAINT [FK_CLIENTE_PERSONA]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_ID_ORDEN]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [DETALLE_ORDEN] DROP CONSTRAINT [FK_ID_ORDEN]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_ID_PRODUCTO]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [DETALLE_ORDEN] DROP CONSTRAINT [FK_ID_PRODUCTO]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_ORDEN_VENTA_METODO_PAGO]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [ORDEN_VENTA] DROP CONSTRAINT [FK_ORDEN_VENTA_METODO_PAGO]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_ORDEN_VENTA_ORDEN]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [ORDEN_VENTA] DROP CONSTRAINT [FK_ORDEN_VENTA_ORDEN]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_PERSONA_DIRECCION]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [PERSONA] DROP CONSTRAINT [FK_PERSONA_DIRECCION]
GO

/*  comment for MR
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_PRODUCTO_CATEGORIA]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [PRODUCTO] DROP CONSTRAINT [FK_PRODUCTO_CATEGORIA]
GO
*/

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_TARJETA_METODO_PAGO]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [Tarjeta] DROP CONSTRAINT [FK_TARJETA_METODO_PAGO]
GO

/* Drop Tables */

/*  comment for MR
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[CATEGORIA]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [CATEGORIA]
GO
*/

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[CLIENTE]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [CLIENTE]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[DETALLE_ORDEN]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [DETALLE_ORDEN]
GO

/*  comment for MR
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[DIRECCION]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [DIRECCION]
GO
*/

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[METODO_PAGO]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [METODO_PAGO]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[ORDEN]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [ORDEN]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[ORDEN_VENTA]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [ORDEN_VENTA]
GO

/*  comment for MR
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[PERSONA]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [PERSONA]
GO
*/

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[PRODUCTO]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [PRODUCTO]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[Tarjeta]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [Tarjeta]
GO

/* Create Tables */

USE [dbTecProg]
GO
/*  comment for MR
CREATE TABLE [CATEGORIA]
(
	[ID_CATEGORIA] int NOT NULL IDENTITY (1, 1),
	[NOMBRE] varchar(50) NOT NULL
)
GO
*/

CREATE TABLE [CLIENTE]
(
	[ID_CLIENTE] int NOT NULL IDENTITY (1, 1),
	[ID_PERSONA] int NOT NULL
)
GO

CREATE TABLE [DETALLE_ORDEN]
(
	[ID_DETALLE_ORDEN] int NOT NULL IDENTITY (1, 1),
	[CANTIDAD] varchar(50) NOT NULL,
	[ID_ORDEN] int NOT NULL,
	[ID_PRODUCTO] int NOT NULL
)
GO

/*  comment for MR
CREATE TABLE [DIRECCION]
(
	[ID_DIRECCION] int NOT NULL IDENTITY (1, 1),
	[ALTURA] varchar(50) NOT NULL,
	[CALLE] varchar(50) NOT NULL,
	[CODIGO_POSTAL] varchar(50) NOT NULL,
	[LOCALIDAD] varchar(50) NOT NULL,
	[PROVINCIA] varchar(50) NOT NULL
)
GO
*/

CREATE TABLE [METODO_PAGO]
(
	[ID_METODO_PAGO] int NOT NULL IDENTITY (1, 1),
	[TIPO] varchar(50) NOT NULL
)
GO

CREATE TABLE [ORDEN]
(
	[ID] int NOT NULL IDENTITY (1, 1),
	[FECHA] datetime NOT NULL,
	ID_PERSONA INT NOT NULL,
	   HABILITADO DATETIME NULL,                            
       PRIMARY KEY
               (
               ID
               ),
       FOREIGN KEY
               (
               ID_PERSONA
               )
          REFERENCES USUARIO
               (
               ID
               )
);

GO

CREATE TABLE [ORDEN_VENTA]
(
	[ID_ORDEN_VENTA] int NOT NULL IDENTITY (1, 1),
	[ID_ORDEN] int NOT NULL,
	[ID_METODO_PAGO] int NOT NULL
)
GO

/*  comment for MR
CREATE TABLE [PERSONA]
(
	[ID_PERSONA] int NOT NULL IDENTITY (1, 1),
	[APELLIDO] varchar(50) NOT NULL,
	[DNI] varchar(50) NOT NULL,
	[NOMBRE] varchar(50) NOT NULL,
	[ID_DIRECCION] int NOT NULL
)
GO
*/

CREATE TABLE [PRODUCTO]
(
	[ID_PRODUCTO] int NOT NULL IDENTITY (1, 1),
	[NOMBRE] varchar(50) NOT NULL,
	[STOCK] int NOT NULL,
	[PRECIO_COMPRA] float NOT NULL,
	[PRECIO_VENTA] float NOT NULL,
	[ID_CATEGORIA] int NOT NULL
)
GO

CREATE TABLE [TARJETA]
(
	[ID_TARJETA] int NOT NULL IDENTITY (1, 1),
	[CVC] varchar(50) NOT NULL,
	[FECHA_VENCIMIENTO] varchar(50) NOT NULL,
	[NOMBRE_TARJETA] varchar(50) NOT NULL,
	[NUMERO_TARJETA] int NOT NULL,
	[ID_METODO_PAGO] int NOT NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

/*  comment for MR
ALTER TABLE [CATEGORIA] 
 ADD CONSTRAINT [PK_CATEGORIA]
	PRIMARY KEY CLUSTERED ([ID_CATEGORIA] ASC)
GO
*/

ALTER TABLE [CLIENTE] 
 ADD CONSTRAINT [PK_CLIENTE]
	PRIMARY KEY CLUSTERED ([ID_CLIENTE] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_CLIENTE_PERSONA] 
 ON [CLIENTE] ([ID_PERSONA] ASC)
GO

ALTER TABLE [DETALLE_ORDEN] 
 ADD CONSTRAINT [PK_ID_DETALLE_ORDEN]
	PRIMARY KEY CLUSTERED ([ID_DETALLE_ORDEN] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_ID_PRODUCTO] 
 ON [DETALLE_ORDEN] ([ID_PRODUCTO] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_ID_ORDEN] 
 ON [DETALLE_ORDEN] ([ID_ORDEN] ASC)
GO

/*  comment for MR
ALTER TABLE [DIRECCION] 
 ADD CONSTRAINT [PK_DIRECCION]
	PRIMARY KEY CLUSTERED ([ID_DIRECCION] ASC)
GO
*/

ALTER TABLE [METODO_PAGO] 
 ADD CONSTRAINT [PK_METODO_PAGO]
	PRIMARY KEY CLUSTERED ([ID_METODO_PAGO] ASC)
GO


ALTER TABLE [ORDEN_VENTA] 
 ADD CONSTRAINT [PK_ORDEN_VENTA]
	PRIMARY KEY CLUSTERED ([ID_ORDEN_VENTA] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_ORDEN_VENTA_METODO_PAGO] 
 ON [ORDEN_VENTA] ([ID_METODO_PAGO] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_ORDEN_VENTA_ORDEN] 
 ON [ORDEN_VENTA] ([ID_ORDEN] ASC)
GO

/*  comment for MR
ALTER TABLE [PERSONA] 
 ADD CONSTRAINT [PK_PERSONA]
	PRIMARY KEY CLUSTERED ([ID_PERSONA] ASC)
GO


CREATE NONCLUSTERED INDEX [IXFK_PERSONA_DIRECCION] 
 ON [PERSONA] ([ID_DIRECCION] ASC)
GO
*/

ALTER TABLE [PRODUCTO] 
 ADD CONSTRAINT [PK_PRODUCTO]
	PRIMARY KEY CLUSTERED ([ID_PRODUCTO] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_PRODUCTO_CATEGORIA] 
 ON [PRODUCTO] ([ID_CATEGORIA] ASC)
GO

ALTER TABLE [Tarjeta] 
 ADD CONSTRAINT [PK_TARJETA]
	PRIMARY KEY CLUSTERED ([ID_TARJETA] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_TARJETA_METODO_PAGO] 
 ON [Tarjeta] ([ID_METODO_PAGO] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [CLIENTE] ADD CONSTRAINT [FK_CLIENTE_PERSONA]
	FOREIGN KEY ([ID_PERSONA]) REFERENCES [PERSONA] ([ID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [DETALLE_ORDEN] ADD CONSTRAINT [FK_ID_ORDEN]
	FOREIGN KEY ([ID_ORDEN]) REFERENCES [ORDEN] ([ID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [DETALLE_ORDEN] ADD CONSTRAINT [FK_ID_PRODUCTO]
	FOREIGN KEY ([ID_PRODUCTO]) REFERENCES [PRODUCTO] ([ID_PRODUCTO]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [ORDEN_VENTA] ADD CONSTRAINT [FK_ORDEN_VENTA_METODO_PAGO]
	FOREIGN KEY ([ID_METODO_PAGO]) REFERENCES [METODO_PAGO] ([ID_METODO_PAGO]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [ORDEN_VENTA] ADD CONSTRAINT [FK_ORDEN_VENTA_ORDEN]
	FOREIGN KEY ([ID_ORDEN]) REFERENCES [ORDEN] ([ID]) ON DELETE No Action ON UPDATE No Action
GO
/*  comment for MR
ALTER TABLE [PERSONA] ADD CONSTRAINT [FK_PERSONA_DIRECCION]
	FOREIGN KEY ([ID_DIRECCION]) REFERENCES [DIRECCION] ([ID_DIRECCION]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [PRODUCTO] ADD CONSTRAINT [FK_PRODUCTO_CATEGORIA]
	FOREIGN KEY ([ID_CATEGORIA]) REFERENCES [CATEGORIA] ([ID_CATEGORIA]) ON DELETE No Action ON UPDATE No Action
GO
*/

ALTER TABLE [Tarjeta] ADD CONSTRAINT [FK_TARJETA_METODO_PAGO]
	FOREIGN KEY ([ID_METODO_PAGO]) REFERENCES [METODO_PAGO] ([ID_METODO_PAGO]) ON DELETE No Action ON UPDATE No Action
GO


/****** MODULO 4 ******/

USE [dbTecProg]
GO

/*  comment for MR
GO
CREATE TABLE DIRECCION
       (
       IDDIRECCION INT IDENTITY,                              
       ALTURA VARCHAR(6) NOT NULL,                              
       CALLE VARCHAR(30) NOT NULL,                              
       CODIGOPOSTAL VARCHAR(20) NOT NULL,                              
       LOCALIDAD VARCHAR(30) NOT NULL,                              
       PROVINCIA VARCHAR(30) NOT NULL,
	   CONSTRAINT CHK_DIR CHECK (ALTURA >= 0 AND CODIGOPOSTAL >= 0),
       PRIMARY KEY
               (
               IDDIRECCION
               )
       );
GO
*/

GO
CREATE TABLE CATEGORIA /*Necesaria*/
       (
       ID_CATEGORIA SMALLINT IDENTITY,                              
       DESCRIPCION VARCHAR(30) UNIQUE NOT NULL,
	   HABILITADO DATETIME NULL,
       PRIMARY KEY
               (
               ID_CATEGORIA
               )
       );
GO


GO
CREATE TABLE PROVEEDOR /*Necesaria*/
       (
       ID_PROVEEDOR INT IDENTITY,                              
       ID_DIRECCION INT NOT NULL,                              
       CUIL VARCHAR(13) UNIQUE NOT NULL,                              
       RAZONSOCIAL VARCHAR(30) NOT NULL,
	   HABILITADO DATETIME NULL,                    
       PRIMARY KEY
               (
               ID_PROVEEDOR
               ),
       FOREIGN KEY
               (
               ID_DIRECCION
               )
          REFERENCES DIRECCION
               (
               ID
               )
       );


GO
CREATE TABLE ORDENCOMPRA /*Necesaria*/
       (
       ID_ORDEN INT UNIQUE NOT NULL,                              
       ID_PROVEEDOR INT NOT NULL,                              
       ID_PERSONA INT  NULL,                              
       FECHAAPROVACION DATETIME NULL,                        
       PRIMARY KEY
               (
               ID_ORDEN
               ),
       FOREIGN KEY
               (
               ID_ORDEN
               )
          REFERENCES ORDEN
               (
               ID
               ),
       FOREIGN KEY
               (
               ID_PROVEEDOR
               )
          REFERENCES PROVEEDOR
               (
               ID_PROVEEDOR
               ),
       FOREIGN KEY
               (
               ID_PERSONA
               )
          REFERENCES USUARIO
               (
               ID
               )
       );
GO


GO
CREATE TABLE DETALLEORDEN /*Necesaria(Posiblemente mediar con modulo 3/4)*/ /*Entidad debil, tengo el detalle y le asocio la ultima orden generada*/ 
       (
       ID_DETALLE INT IDENTITY,       /*No lo reinicio con cada orden, despues juzgo si tiene la orden asociada*/
       ID_ORDEN INT NOT NULL,                              
       ID_PRODUCTO INT NOT NULL,                              
       CANTIDAD SMALLINT NOT NULL CHECK (CANTIDAD > 0),                              /* Permite vender hasta 32000 del mismo producto */
       PRIMARY KEY
               (
               ID_ORDEN,
               ID_DETALLE
               ),
       FOREIGN KEY
               (
               ID_ORDEN
               )
          REFERENCES ORDEN
               (
               ID
               ),
       FOREIGN KEY
               (
               ID_PRODUCTO
               )
          REFERENCES PRODUCTO
               (
               ID_PRODUCTO
               )
       );
GO

GO
CREATE TABLE STOCK /*Necesaria(Posiblemente mediar con modulo 3/4)*/
       (
       ID_STOCK INT IDENTITY,                              
       ID_PRODUCTO INT NOT NULL UNIQUE,                              
       CANTIDAD INT NOT NULL CHECK (CANTIDAD >= 0),
	   HABILITADO DATETIME NULL,                              
       PRIMARY KEY
               (
               ID_STOCK
               ),
       FOREIGN KEY
               (
               ID_PRODUCTO
               )
          REFERENCES PRODUCTO
               (
               ID_PRODUCTO
               )
       );
GO

GO
CREATE TABLE ALERTA /*Necesaria*/
       (
       ID_ALERTA INT IDENTITY,                              
       ID_STOCK INT NOT NULL UNIQUE,    /*Una alerta por stock*/                          
       ID_PERSONA INT NOT NULL,                              
       CANTIDADMINIMA INT NOT NULL CHECK (CANTIDADMINIMA >= 0),                              
       PRIMARY KEY
               (
               ID_ALERTA
               ),
       FOREIGN KEY
               (
               ID_STOCK
               )
          REFERENCES STOCK
               (
               ID_STOCK
               ),
       FOREIGN KEY
               (
               ID_PERSONA
               )
          REFERENCES USUARIO
               (
               ID
               )
       );
GO