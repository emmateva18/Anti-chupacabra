USE [master]
GO
/****** Object:  Database [AntiChupacabra]    Script Date: 6/27/2021 10:21:56 AM ******/
CREATE DATABASE [AntiChupacabra]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Anti-Chupacabra', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Anti-Chupacabra.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Anti-Chupacabra_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Anti-Chupacabra_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AntiChupacabra].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AntiChupacabra] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AntiChupacabra] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AntiChupacabra] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AntiChupacabra] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AntiChupacabra] SET ARITHABORT OFF 
GO
ALTER DATABASE [AntiChupacabra] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AntiChupacabra] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AntiChupacabra] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AntiChupacabra] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AntiChupacabra] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AntiChupacabra] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AntiChupacabra] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AntiChupacabra] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AntiChupacabra] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AntiChupacabra] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AntiChupacabra] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AntiChupacabra] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AntiChupacabra] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AntiChupacabra] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AntiChupacabra] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AntiChupacabra] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AntiChupacabra] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AntiChupacabra] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AntiChupacabra] SET  MULTI_USER 
GO
ALTER DATABASE [AntiChupacabra] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AntiChupacabra] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AntiChupacabra] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AntiChupacabra] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AntiChupacabra] SET DELAYED_DURABILITY = DISABLED 
GO
USE [AntiChupacabra]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 6/27/2021 10:21:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AnimalRecords]    Script Date: 6/27/2021 10:21:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AnimalRecords](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AnimalId] [int] NOT NULL,
	[AcceptedOn] [date] NOT NULL,
	[Town] [nvarchar](50) NOT NULL,
	[Place] [nvarchar](50) NOT NULL,
	[DonatorName] [nvarchar](50) NOT NULL,
	[DonatorPhone] [nvarchar](10) NOT NULL,
	[ReleasedOn] [date] NULL,
	[IsInjured] [bit] NULL,
	[InjurySeverity] [smallint] NULL,
	[CreatedById] [int] NULL,
	[Duration]  AS (datediff(day,[AcceptedOn],[ReleasedOn])),
 CONSTRAINT [PK_AnimalRecords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Animals]    Script Date: 6/27/2021 10:21:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Breed] [nvarchar](50) NOT NULL,
	[Sex] [bit] NOT NULL,
	[Age] [smallint] NOT NULL,
 CONSTRAINT [PK_Animal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vAnimalRecords]    Script Date: 6/27/2021 10:21:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAnimalRecords]
AS
SELECT        dbo.AnimalRecords.Id, dbo.AnimalRecords.AcceptedOn, dbo.AnimalRecords.Town, dbo.AnimalRecords.Place, dbo.AnimalRecords.ReleasedOn, dbo.AnimalRecords.IsInjured, dbo.AnimalRecords.InjurySeverity, 
                         dbo.AnimalRecords.Duration, dbo.Donaters.Name AS DonatorName, dbo.Animals.Breed, dbo.Animals.Sex, dbo.Animals.Age, dbo.Donaters.Gender, dbo.Donaters.Phone
FROM            dbo.AnimalRecords INNER JOIN
                         dbo.Animals ON dbo.AnimalRecords.AnimalId = dbo.Animals.Id INNER JOIN
                         dbo.Donaters ON dbo.AnimalRecords.DonatedById = dbo.Donaters.Id
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([Id], [Username], [Email], [PasswordHash]) VALUES (1, N'Admin', N'a@a.a', N'd82494f05d6917ba02f7aaa29689ccb444bb73f20380876cb05d1f37537b7892')
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
ALTER TABLE [dbo].[AnimalRecords]  WITH CHECK ADD  CONSTRAINT [FK_AnimalRecords_Animals] FOREIGN KEY([AnimalId])
REFERENCES [dbo].[Animals] ([Id])
GO
ALTER TABLE [dbo].[AnimalRecords] CHECK CONSTRAINT [FK_AnimalRecords_Animals]
GO
ALTER TABLE [dbo].[AnimalRecords]  WITH CHECK ADD  CONSTRAINT [FK_AnimalRecords_Users] FOREIGN KEY([CreatedById])
REFERENCES [dbo].[Admins] ([Id])
GO
ALTER TABLE [dbo].[AnimalRecords] CHECK CONSTRAINT [FK_AnimalRecords_Users]
GO
ALTER TABLE [dbo].[AnimalRecords]  WITH CHECK ADD  CONSTRAINT [CK_AnimalRecords_ReleasedOn] CHECK  (([ReleasedOn]>=[AcceptedOn]))
GO
ALTER TABLE [dbo].[AnimalRecords] CHECK CONSTRAINT [CK_AnimalRecords_ReleasedOn]
GO
ALTER TABLE [dbo].[Animals]  WITH CHECK ADD  CONSTRAINT [CK_Animals_Age] CHECK  (([Age]>(0)))
GO
ALTER TABLE [dbo].[Animals] CHECK CONSTRAINT [CK_Animals_Age]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[32] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AnimalRecords"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 134
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Animals"
            Begin Extent = 
               Top = 15
               Left = 463
               Bottom = 145
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Donaters"
            Begin Extent = 
               Top = 110
               Left = 263
               Bottom = 240
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 2310
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAnimalRecords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAnimalRecords'
GO
USE [master]
GO
ALTER DATABASE [AntiChupacabra] SET  READ_WRITE 
GO
