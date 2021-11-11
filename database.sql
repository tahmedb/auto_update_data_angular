USE [master]
GO
/****** Object:  Database [auto_updatedb]    Script Date: 11/11/2021 3:23:22 PM ******/
CREATE DATABASE [auto_updatedb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'auto_updatedb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\auto_updatedb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'auto_updatedb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\auto_updatedb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [auto_updatedb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [auto_updatedb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [auto_updatedb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [auto_updatedb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [auto_updatedb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [auto_updatedb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [auto_updatedb] SET ARITHABORT OFF 
GO
ALTER DATABASE [auto_updatedb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [auto_updatedb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [auto_updatedb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [auto_updatedb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [auto_updatedb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [auto_updatedb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [auto_updatedb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [auto_updatedb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [auto_updatedb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [auto_updatedb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [auto_updatedb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [auto_updatedb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [auto_updatedb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [auto_updatedb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [auto_updatedb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [auto_updatedb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [auto_updatedb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [auto_updatedb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [auto_updatedb] SET  MULTI_USER 
GO
ALTER DATABASE [auto_updatedb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [auto_updatedb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [auto_updatedb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [auto_updatedb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [auto_updatedb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [auto_updatedb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [auto_updatedb] SET QUERY_STORE = OFF
GO
USE [auto_updatedb]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/11/2021 3:23:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[email] [varchar](200) NULL,
	[home_address] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[users] ON 
GO
INSERT [dbo].[users] ([id], [first_name], [last_name], [email], [home_address]) VALUES (1, N'ahmed', N'khan', N'email@email.com', N'address test 111 to nothing')
GO
INSERT [dbo].[users] ([id], [first_name], [last_name], [email], [home_address]) VALUES (2, N'ahmed', N'ali', N'email1@email.com', N'address test  to nothing')
GO
INSERT [dbo].[users] ([id], [first_name], [last_name], [email], [home_address]) VALUES (3, N'friend', N'ali', N'email2@email.com', N'address 1 111 to nothing')
GO
INSERT [dbo].[users] ([id], [first_name], [last_name], [email], [home_address]) VALUES (4, N'good', N'khan', N'email11@email.com', N'address wer 111 to nothing')
GO
INSERT [dbo].[users] ([id], [first_name], [last_name], [email], [home_address]) VALUES (5, N'test  2', N'-', N'email22@email.com', N'address werr 111 to nothing')
GO
INSERT [dbo].[users] ([id], [first_name], [last_name], [email], [home_address]) VALUES (7, N'bbb', N'987', N'he@mail.com', N'999887')
GO
SET IDENTITY_INSERT [dbo].[users] OFF
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-0c966352-c6bb-4eb7-9eaa-25b74bd31714]    Script Date: 11/11/2021 3:23:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-0c966352-c6bb-4eb7-9eaa-25b74bd31714] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-0c966352-c6bb-4eb7-9eaa-25b74bd31714]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-0c966352-c6bb-4eb7-9eaa-25b74bd31714] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-0c966352-c6bb-4eb7-9eaa-25b74bd31714') > 0)   DROP SERVICE [SqlQueryNotificationService-0c966352-c6bb-4eb7-9eaa-25b74bd31714]; if (OBJECT_ID('SqlQueryNotificationService-0c966352-c6bb-4eb7-9eaa-25b74bd31714', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-0c966352-c6bb-4eb7-9eaa-25b74bd31714]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-0c966352-c6bb-4eb7-9eaa-25b74bd31714]; END COMMIT TRANSACTION; END
GO
USE [master]
GO
ALTER DATABASE [auto_updatedb] SET  READ_WRITE 
GO
