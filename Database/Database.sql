USE [master]
GO
/****** Object:  Database [AntiChupacabra]    Script Date: 30.6.2021 г. 0:51:25 ******/
CREATE DATABASE [AntiChupacabra]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AntiChupacabra', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AntiChupacabra.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AntiChupacabra_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AntiChupacabra_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Admins]    Script Date: 30.6.2021 г. 0:51:25 ******/
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
/****** Object:  Table [dbo].[AnimalRecords]    Script Date: 30.6.2021 г. 0:51:25 ******/
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
/****** Object:  Table [dbo].[Animals]    Script Date: 30.6.2021 г. 0:51:25 ******/
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
/****** Object:  View [dbo].[vAnimalRecords]    Script Date: 30.6.2021 г. 0:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAnimalRecords]
AS
SELECT        dbo.AnimalRecords.Id, dbo.Animals.Breed, dbo.Animals.Sex, dbo.Animals.Age, dbo.AnimalRecords.AcceptedOn, dbo.AnimalRecords.Town, dbo.AnimalRecords.Place, dbo.AnimalRecords.DonatorName, 
                         dbo.AnimalRecords.DonatorPhone, dbo.AnimalRecords.ReleasedOn, dbo.AnimalRecords.IsInjured, dbo.AnimalRecords.InjurySeverity, dbo.AnimalRecords.Duration
FROM            dbo.AnimalRecords INNER JOIN
                         dbo.Animals ON dbo.AnimalRecords.AnimalId = dbo.Animals.Id
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 
GO
INSERT [dbo].[Admins] ([Id], [Username], [Email], [PasswordHash]) VALUES (1, N'Admin', N'a@a.a', N'd82494f05d6917ba02f7aaa29689ccb444bb73f20380876cb05d1f37537b7892')
GO
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[AnimalRecords] ON 
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (13, 76, CAST(N'2020-01-13' AS Date), N'Sofia', N'Borisova gradina', N'Misho', N'089123456', CAST(N'2020-01-16' AS Date), 0, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (14, 76, CAST(N'2019-01-13' AS Date), N'Burgas', N'Izgrev', N'Misho', N'089123456', CAST(N'2019-05-19' AS Date), 0, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (15, 77, CAST(N'2018-01-13' AS Date), N'Varna', N'Asparuhovo', N'Misho', N'089123456', CAST(N'2018-01-16' AS Date), 0, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (16, 78, CAST(N'2017-01-13' AS Date), N'Burgas', N'Na Plaja', N'Petur', N'089123456', CAST(N'2017-03-12' AS Date), 0, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (24, 87, CAST(N'2020-01-13' AS Date), N'Sofia', N'Borisova gradina', N'Misho', N'089123456', CAST(N'2020-02-12' AS Date), 1, 7, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (25, 88, CAST(N'2020-01-13' AS Date), N'Burgas', N'Meden Rudnik', N'Misho', N'089123456', CAST(N'2020-01-18' AS Date), 1, 2, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (26, 89, CAST(N'2019-01-17' AS Date), N'Sofia', N'Borisova gradina', N'Misho', N'089123456', CAST(N'2019-02-01' AS Date), 1, 5, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (27, 89, CAST(N'2020-01-13' AS Date), N'Plovdiv', N'Tepetata', N'Ivan', N'089123456', CAST(N'2020-01-21' AS Date), 1, 4, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (28, 90, CAST(N'2017-01-13' AS Date), N'Burgas', N'Morska Gradina', N'Ivan', N'089123456', CAST(N'2017-03-20' AS Date), 1, 6, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (29, 93, CAST(N'2021-03-10' AS Date), N'Ruse', N'Dunav', N'Ivan', N'0891234667', CAST(N'2021-04-10' AS Date), 0, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (33, 94, CAST(N'2018-02-01' AS Date), N'Sofia', N'Borisova gradina', N'Petya', N'0871212021', CAST(N'2018-02-19' AS Date), NULL, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (34, 95, CAST(N'2018-02-28' AS Date), N'Plovdiv', N'Kapana', N'Milena', N'0881225321', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (35, 96, CAST(N'2017-06-15' AS Date), N'Ruse', N'Dunav', N'Rostislav', N'0982145268', CAST(N'2017-08-15' AS Date), NULL, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (36, 97, CAST(N'2021-05-09' AS Date), N'Varna', N'Centur', N'Marislava', N'0872685165', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[AnimalRecords] ([Id], [AnimalId], [AcceptedOn], [Town], [Place], [DonatorName], [DonatorPhone], [ReleasedOn], [IsInjured], [InjurySeverity], [CreatedById]) VALUES (37, 98, CAST(N'2021-02-01' AS Date), N'Varna', N'Asparuhovo', N'Vladimir', N'0875265324', CAST(N'2021-03-09' AS Date), NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[AnimalRecords] OFF
GO
SET IDENTITY_INSERT [dbo].[Animals] ON 
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (75, N'blatna', 1, 1)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (76, N'blatna', 0, 2)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (77, N'blatna', 1, 3)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (78, N'blatna', 0, 4)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (79, N'blatna', 1, 20)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (87, N'blatna', 1, 13)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (88, N'blatna', 1, 19)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (89, N'blatna', 0, 47)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (90, N'blatna', 1, 56)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (91, N'blatna', 1, 1)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (92, N'Pond', 0, 9)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (93, N'Pond', 0, 40)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (94, N'Pond', 1, 12)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (95, N'Water', 0, 23)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (96, N'Pond', 1, 12)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (97, N'Water', 1, 13)
GO
INSERT [dbo].[Animals] ([Id], [Breed], [Sex], [Age]) VALUES (98, N'Water', 0, 52)
GO
SET IDENTITY_INSERT [dbo].[Animals] OFF
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
