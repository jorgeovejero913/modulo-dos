/****** Script de creaccion DB ******/
/*
	v0.3: Creacion de tabla modulo 2


	NOTA: Se deben modificar las rutas donde se guradaran los archivos, en el caso de que sea necesario.
*/
/****** START ******/
USE [master]
GO
/****** Object:  Database [dbTecProg]    Script Date: 11/5/2021 21:06:36 ******/
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
/****** Object:  Table [dbo].[direccion]    Script Date: 11/5/2021 21:06:36 ******/
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
/****** Object:  Table [dbo].[permiso]    Script Date: 11/5/2021 21:06:36 ******/
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
/****** Object:  Table [dbo].[permiso_por_rol]    Script Date: 11/5/2021 21:06:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permiso_por_rol](
	[rol_id] [int] NOT NULL,
	[permiso_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persona]    Script Date: 11/5/2021 21:06:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persona](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[apellido] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[dni] [int] NOT NULL,
	[direccion_id] [int] NULL,
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
/****** Object:  Table [dbo].[rol]    Script Date: 11/5/2021 21:06:36 ******/
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
/****** Object:  Table [dbo].[sesion]    Script Date: 11/5/2021 21:06:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sesion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usuario_id] [int] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NULL,
	[deshabilitado] [datetime] NULL,
 CONSTRAINT [PK_sesion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 11/5/2021 21:06:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[persona_id] [int] NOT NULL,
	[rol_id] [int] NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[legajo] [int] NOT NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[permiso_por_rol]  WITH CHECK ADD  CONSTRAINT [FK_permiso_por_rol_permiso] FOREIGN KEY([permiso_id])
REFERENCES [dbo].[permiso] ([id])
GO
ALTER TABLE [dbo].[permiso_por_rol] CHECK CONSTRAINT [FK_permiso_por_rol_permiso]
GO
ALTER TABLE [dbo].[permiso_por_rol]  WITH CHECK ADD  CONSTRAINT [FK_permiso_por_rol_rol] FOREIGN KEY([rol_id])
REFERENCES [dbo].[rol] ([id])
GO
ALTER TABLE [dbo].[permiso_por_rol] CHECK CONSTRAINT [FK_permiso_por_rol_rol]
GO
ALTER TABLE [dbo].[persona]  WITH CHECK ADD  CONSTRAINT [FK_persona_direccion] FOREIGN KEY([direccion_id])
REFERENCES [dbo].[direccion] ([id])
GO
ALTER TABLE [dbo].[persona] CHECK CONSTRAINT [FK_persona_direccion]
GO
ALTER TABLE [dbo].[sesion]  WITH CHECK ADD  CONSTRAINT [FK_sesion_usuario] FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[sesion] CHECK CONSTRAINT [FK_sesion_usuario]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_persona] FOREIGN KEY([persona_id])
REFERENCES [dbo].[persona] ([id])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_persona]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_rol] FOREIGN KEY([rol_id])
REFERENCES [dbo].[rol] ([id])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_rol]
GO
USE [master]
GO
ALTER DATABASE [dbTecProg] SET  READ_WRITE 
GO