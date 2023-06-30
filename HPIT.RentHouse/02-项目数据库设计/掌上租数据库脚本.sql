USE [master]
GO
/****** Object:  Database [RentHouse]    Script Date: 2022/7/27 15:02:32 ******/
CREATE DATABASE [RentHouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'zsz', FILENAME = N'D:\Program Files (x86)\MSSQL15.MSSQLSERVER\MSSQL\DATA\RentHouse.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'zsz_log', FILENAME = N'D:\Program Files (x86)\MSSQL15.MSSQLSERVER\MSSQL\DATA\RentHouse_log.ldf' , SIZE = 48384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [RentHouse] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RentHouse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RentHouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RentHouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RentHouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RentHouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RentHouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [RentHouse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RentHouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RentHouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RentHouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RentHouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RentHouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RentHouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RentHouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RentHouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RentHouse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RentHouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RentHouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RentHouse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RentHouse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RentHouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RentHouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RentHouse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RentHouse] SET RECOVERY FULL 
GO
ALTER DATABASE [RentHouse] SET  MULTI_USER 
GO
ALTER DATABASE [RentHouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RentHouse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RentHouse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RentHouse] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [RentHouse] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RentHouse] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RentHouse', N'ON'
GO
ALTER DATABASE [RentHouse] SET QUERY_STORE = OFF
GO
USE [RentHouse]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 2022/7/27 15:02:33 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  Table [dbo].[T_AdminLogs]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_AdminLogs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AdminUserId] [bigint] NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_AdminLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_AdminUserRoles]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_AdminUserRoles](
	[AdminUserId] [bigint] NOT NULL,
	[RoleId] [bigint] NOT NULL,
 CONSTRAINT [PK_dbo.T_AdminUserRoles] PRIMARY KEY CLUSTERED 
(
	[AdminUserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_AdminUsers]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_AdminUsers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PhoneNum] [varchar](20) NOT NULL,
	[PasswordHash] [varchar](100) NOT NULL,
	[PasswordSalt] [varchar](20) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[CityId] [bigint] NULL,
	[LoginErrorTimes] [int] NOT NULL,
	[LastLoginErrorDateTime] [datetime] NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_AdminUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Attachments]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Attachments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IconName] [varchar](50) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Attachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Cities]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Cities](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Communities]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Communities](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[RegionId] [bigint] NOT NULL,
	[Location] [nvarchar](1024) NOT NULL,
	[Traffic] [nvarchar](max) NULL,
	[BuiltYear] [int] NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Communities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_HouseAppointments]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_HouseAppointments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[Name] [nvarchar](20) NOT NULL,
	[PhoneNum] [varchar](20) NOT NULL,
	[VisitDate] [datetime] NOT NULL,
	[HouseId] [bigint] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[FollowAdminUserId] [bigint] NULL,
	[FollowDateTime] [datetime] NULL,
	[RowVersion] [timestamp] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_HouseAppointments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_HouseAttachments]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_HouseAttachments](
	[AttachmentId] [bigint] NOT NULL,
	[HouseId] [bigint] NOT NULL,
 CONSTRAINT [PK_dbo.T_HouseAttachments] PRIMARY KEY CLUSTERED 
(
	[AttachmentId] ASC,
	[HouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_HousePics]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_HousePics](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[HouseId] [bigint] NOT NULL,
	[Url] [nvarchar](1024) NOT NULL,
	[ThumbUrl] [nvarchar](1024) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_HousePics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Houses]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Houses](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CommunityId] [bigint] NOT NULL,
	[RoomTypeId] [bigint] NOT NULL,
	[Address] [nvarchar](128) NOT NULL,
	[MonthRent] [int] NOT NULL,
	[StatusId] [bigint] NOT NULL,
	[Area] [decimal](18, 2) NOT NULL,
	[DecorateStatusId] [bigint] NOT NULL,
	[TotalFloorCount] [int] NOT NULL,
	[FloorIndex] [int] NOT NULL,
	[TypeId] [bigint] NOT NULL,
	[Direction] [nvarchar](20) NOT NULL,
	[LookableDateTime] [datetime] NOT NULL,
	[CheckInDateTime] [datetime] NOT NULL,
	[OwnerName] [nvarchar](20) NOT NULL,
	[OwnerPhoneNum] [varchar](20) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Houses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_IdNames]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_IdNames](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](1024) NOT NULL,
	[Name] [nvarchar](1024) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_IdNames] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Permissions]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Permissions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Permissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Regions]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Regions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CityId] [bigint] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Regions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_RolePermissions]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_RolePermissions](
	[RoleId] [bigint] NOT NULL,
	[PermissionId] [bigint] NOT NULL,
 CONSTRAINT [PK_dbo.T_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Roles]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Roles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Settings]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Settings](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](1024) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Settings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Users]    Script Date: 2022/7/27 15:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PhoneNum] [varchar](20) NOT NULL,
	[PasswordHash] [nvarchar](100) NOT NULL,
	[PasswordSalt] [nvarchar](20) NOT NULL,
	[LoginErrorTimes] [int] NOT NULL,
	[LastLoginErrorDateTime] [datetime] NULL,
	[CityId] [bigint] NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.T_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[T_AdminLogs] ON 
GO
INSERT [dbo].[T_AdminLogs] ([Id], [AdminUserId], [Message], [CreateDateTime], [IsDeleted]) VALUES (2, 22, N'添加了管理员2', CAST(N'2021-09-18T00:00:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_AdminLogs] OFF
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (22, 9)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (56, 5)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (57, 10082)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (59, 1)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (60, 1)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (60, 2)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (60, 3)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (60, 5)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (62, 10083)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (62, 10084)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (62, 10085)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (63, 10084)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (63, 10085)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (64, 1)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (64, 2)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (64, 3)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (64, 5)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (65, 10089)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (66, 10088)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (67, 1)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (67, 2)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (67, 3)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (68, 1)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (68, 2)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (68, 3)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (69, 10098)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (70, 10101)
GO
INSERT [dbo].[T_AdminUserRoles] ([AdminUserId], [RoleId]) VALUES (71, 10099)
GO
SET IDENTITY_INSERT [dbo].[T_AdminUsers] ON 
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (22, N'李四', N'13608668687', N'A6AD83B6489ABE28102C98A22A6FEEED', N'mfmmn', N'362520246@qq.com', NULL, 0, NULL, CAST(N'2019-05-05T15:20:22.027' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (56, N'阿杜', N'15538558736', N'9B09EE8CDEA64A5F8EB9440CA04F1AED', N'ftddh', N'362828234@qq.com', 1, 0, NULL, CAST(N'2019-09-09T10:42:09.450' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (57, N'张三', N'15538568732', N'C53CF7B264292905CE5EDF14FB7D21D3', N'nyawa', N'362829204@qq.com', 1, 0, NULL, CAST(N'2019-09-24T16:25:37.433' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (59, N'田果', N'15538568110', N'A4312A22FB0F426F7475E02194BCC5DD', N'ftxaf', N'362520246@qq.com', 1, 0, NULL, CAST(N'2019-10-23T22:15:45.573' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (60, N'周杰伦', N'15538568732', N'0E16075472A4EFBA34C66201986AAE54', N'axsrk', N'123@qq.com', 2, 0, NULL, CAST(N'2020-09-13T23:43:37.320' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (61, N'周杰伦', N'15538568732', N'F5C0364A4D203B89B8E6873854B6A977', N'fywye', N'123@qq.com', NULL, 0, NULL, CAST(N'2020-09-15T16:28:42.547' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (62, N'张学友', N'18768857719', N'48BB2E5B1CB91814C6FAE3007C5FBBD2', N'ffeax', N'123@qq.com', 2, 0, NULL, CAST(N'2020-09-18T00:08:10.213' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (63, N'杨昆', N'18768857720', N'1FAA07F7D5CF34DDA7C938AAF6DE86A3', N'swwff', N'123@qq.com', 1, 0, NULL, CAST(N'2020-09-18T10:59:41.957' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (64, N'琴女', N'13212334567', N'EE7248101BAEAAA0783C035BFC9A270D', N'rsfyt', N'95029947@qq.com', 2, 0, NULL, CAST(N'2021-08-31T10:47:43.443' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (65, N'樊晓朕', N'13211111111', N'E07040B592559145074C3AAEC058FD3E', N'steyn', N'95029947@qq.com', 2, 0, NULL, CAST(N'2021-08-31T11:07:45.113' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (66, N'朱亚鹏', N'13222222222', N'DEFFFB2CBEDBD069F5F9BA9DC73B0F03', N'twsrs', N'95029947@qq.com', 2, 0, NULL, CAST(N'2021-08-31T11:08:07.303' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (67, N'新加管理员', N'13212334567', N'077E8DB631963049D88775B8279EDB2B', N'mkdfs', N'95029947@qq.com', 2, 0, NULL, CAST(N'2022-01-14T15:47:08.867' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (68, N'莫甘娜', N'18712345678', N'AA1EA1408B00EEE67A3084318F07BD6D', N'wxshy', N'95029947@qq.com', 1, 0, NULL, CAST(N'2022-01-18T16:34:45.387' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (69, N'查看权限管理员', N'18712345678', N'59C03109E32455B8B0D698E19DB2A089', N'xydwd', N'95029947@qq.com', 2, 0, NULL, CAST(N'2022-01-19T11:13:35.137' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (70, N'角色修改', N'18711111111', N'7B9ABF6AAD5F6E8AEC30102ADE95DB12', N'fwshm', N'95029947@qq.com', 2, 0, NULL, CAST(N'2022-01-19T11:14:46.317' AS DateTime), 0)
GO
INSERT [dbo].[T_AdminUsers] ([Id], [Name], [PhoneNum], [PasswordHash], [PasswordSalt], [Email], [CityId], [LoginErrorTimes], [LastLoginErrorDateTime], [CreateDateTime], [IsDeleted]) VALUES (71, N'角色添加查看', N'18722222222', N'1D8E44A1947C1135027FC539F870719A', N'swyka', N'12123123133@qq.com', 2, 0, NULL, CAST(N'2022-01-19T11:15:36.467' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_AdminUsers] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Attachments] ON 
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (1, N'床', N'icon-chuangdian', CAST(N'2019-05-07T15:05:24.367' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (2, N'衣柜', N'icon-dpc', CAST(N'2019-05-07T15:05:41.800' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (3, N'沙发', N'icon-shafa', CAST(N'2019-05-07T15:06:00.710' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (4, N'燃气', N'icon-7', CAST(N'2019-05-07T15:06:35.750' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (5, N'洗衣机', N'icon-xiyiji', CAST(N'2019-05-07T15:06:55.370' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (6, N'网络', N'icon-wifi', CAST(N'2019-05-07T15:07:17.073' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (7, N'冰箱', N'icon-bingxiang', CAST(N'2019-05-07T15:07:36.633' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (8, N'书桌', N'icon-bangongzhuo', CAST(N'2019-05-07T15:08:01.560' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (9, N'空调', N'icon-kongtiao', CAST(N'2019-05-07T15:08:21.770' AS DateTime), 0)
GO
INSERT [dbo].[T_Attachments] ([Id], [Name], [IconName], [CreateDateTime], [IsDeleted]) VALUES (10, N'餐桌', N'icon-zhuozi', CAST(N'2019-05-07T15:08:39.630' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Attachments] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Cities] ON 
GO
INSERT [dbo].[T_Cities] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (1, N'郑州', CAST(N'2019-03-30T20:41:40.707' AS DateTime), 0)
GO
INSERT [dbo].[T_Cities] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (2, N'洛阳', CAST(N'2019-04-14T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Cities] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (5, N'南阳', CAST(N'2019-04-13T00:00:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Communities] ON 
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (1, N'保利海德公园', 2, N'中州大道贾鲁河桥南', N'263路; s161路', 2013, CAST(N'2019-05-07T09:22:09.207' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (2, N'锦艺金水湾', 2, N'文化贾鲁河与东风渠交汇处', N'29路; s161路', 2013, CAST(N'2019-05-07T09:39:49.213' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (3, N'阳光城', 3, N'阳光城处于中心城区、郑东新区、航空港经济区、龙湖宜居区四区交汇处，隶属管城区', N'263路; s161路', 2013, CAST(N'2019-05-07T09:54:29.490' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (4, N'龙源世纪龙城', 3, N'石化路9号', N'双地铁，地铁4、5号线', 2017, CAST(N'2019-05-07T09:55:56.300' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (5, N'保利永威西溪花园', 4, N'保利永威西溪花园－白杨路12号，隶属高新区', N'263路; s161路', 2013, CAST(N'2019-05-17T18:05:57.950' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (6, N'东原阅城', 4, N'东原阅城－白杨路12号，隶属高新区', N'263路; s161路', 2013, CAST(N'2019-05-17T18:06:46.433' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (7, N'招商天地华府', 5, N'招商天地华府，二七-嵩山路-嵩山南路,近南四环', N'263路; s161路', 2015, CAST(N'2019-05-17T18:07:51.423' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (8, N'万科大都会', 5, N'二七-大学南路-大学南路,近南四环', N'263路; s161路', 2015, CAST(N'2019-05-17T18:08:32.400' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (9, N'万科城紫兰苑', 6, N'中原-科学大道-科学大道', N'263路; s161路', 2017, CAST(N'2019-05-17T18:09:47.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (10, N'东原阅城', 6, N'中原-航海西路-西三环', N'263路; s161路', 2017, CAST(N'2019-05-17T18:10:15.853' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (11, N'建业森林半岛', 7, N'上街-上街周边-许昌路', N'263路; s161路', 2017, CAST(N'2019-05-17T18:11:18.110' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (12, N'明珠公馆', 7, N'上街-上街周边-许昌路', N'263路; s161路', 2017, CAST(N'2019-05-17T18:11:37.697' AS DateTime), 1)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (13, N'华润悦府', 5, N'华润万象城位于郑州市二七区民主路以西、解放路以北、铭功路以东、西太康路以南，与二七广场相邻', N'从各区乘坐2路、K6路、6路、9路、K9路、B17路、21路、22路、26路、28路、32路、33路、34路、35路、57路、60路、65路、82路、85路快线 、85路、93路、95路、T101路、105路、256路、305路、517路、603路、729路、K815路、K903路、K906路、K909路、909路等公交到二七广场下车，就可到华润万象城项目处。', 2016, CAST(N'2019-09-10T11:22:13.500' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (14, N'富田太阳城', 5, N'富田太阳城，是河南振兴房地产（集团）有限公司沿袭16年诚信名企、国家一级开发资质的精工品质、全力打造的中原纯欧式大型居住风尚社区', N'218路 59路 323路 46路 262路 35路 129路 215路 86路 215路 25路 86路 33路 38路快线 307路 323路 518路 727路 B15路 B16路 B17路 Y812路', 2005, CAST(N'2019-09-10T11:22:13.500' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (15, N'磨李社区', 2, N'小夏街博学路东', N'公交37路、111、112、136、156', 2, CAST(N'1905-07-09T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (16, N'时埂社区', 2, N'小夏街博学路东南', N'公交37路、111、112、136、156', 5, CAST(N'1905-07-09T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (17, N'前牛岗社区', 2, N'小夏街博学路东', N'公交37路、111、112、136、156', 6, CAST(N'1905-07-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (18, N'姚桥社区', 2, N'小夏街博学路西', N'公交37路、111、112、136、156', 10, CAST(N'1905-07-08T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (19, N'陈三桥社区', 2, N'小夏街博学路东北', N'公交37路、111、112、136、156', 3, CAST(N'1905-07-09T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (20, N'陈兑桥社区', 2, N'小夏街博学路南', N'公交37路、111、112、136、156', 5, CAST(N'1905-07-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (21, N'夏庄社区', 2, N'小夏街薛夏北街', N'公交37路、136、156', 10, CAST(N'1905-07-09T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (22, N'薛岗社区', 2, N'小夏街姚夏路东北', N'公交37路、111、136、', 3, CAST(N'1905-07-11T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (23, N'汇泉西悦城', 2, N'汇泉西悦城，小区占地1500亩，有76两房、88平108平128平三房、112平四房。', N'121路 302路 112路 565路 地铁一号线', 2019, CAST(N'2019-09-10T11:22:13.503' AS DateTime), 0)
GO
INSERT [dbo].[T_Communities] ([Id], [Name], [RegionId], [Location], [Traffic], [BuiltYear], [CreateDateTime], [IsDeleted]) VALUES (24, N'金水区', 2, N'姚桥社区，小区占地2500亩，有76两房、88平108平128平三房、112平四房。', N'48路 137路 107路  地铁一号线', 2019, CAST(N'2019-09-10T11:22:13.503' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Communities] OFF
GO
SET IDENTITY_INSERT [dbo].[T_HouseAppointments] ON 
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (8, NULL, N'李四', N'15538798987', CAST(N'2019-09-23T00:00:00.000' AS DateTime), 10333, N'已处理', 63, CAST(N'2021-01-15T10:27:12.387' AS DateTime), CAST(N'2019-09-23T20:09:48.080' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (9, NULL, N'张安', N'15538798987', CAST(N'2019-08-23T00:00:00.000' AS DateTime), 10352, N'已处理', 57, NULL, CAST(N'2019-09-23T20:10:16.453' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (10, NULL, N'宇达', N'18976778654', CAST(N'2019-09-23T00:00:00.000' AS DateTime), 10351, N'已处理', 57, NULL, CAST(N'2019-09-23T20:11:20.563' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (11, NULL, N'王浩', N'18911765643', CAST(N'2019-10-23T00:00:00.000' AS DateTime), 10349, N'已处理', 22, NULL, CAST(N'2019-09-23T20:11:48.333' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (12, NULL, N'李琼', N'18978238745', CAST(N'2019-10-23T00:00:00.000' AS DateTime), 10341, N'已处理', 56, NULL, CAST(N'2019-09-23T20:13:55.347' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (13, NULL, N'李四', N'13698778346', CAST(N'2019-10-25T00:00:00.000' AS DateTime), 10366, N'已处理', 57, NULL, CAST(N'2019-09-25T17:10:21.507' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (14, 7, N'测试', N'16867783986', CAST(N'2019-10-27T00:00:00.000' AS DateTime), 10366, N'已处理', 57, NULL, CAST(N'2019-09-27T17:24:37.920' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (15, 8, N'王五', N'13808668755', CAST(N'2019-10-24T00:00:00.000' AS DateTime), 10341, N'已处理', 57, NULL, CAST(N'2019-10-23T22:35:08.870' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (16, NULL, N'5555号', N'15538568732', CAST(N'2019-12-23T00:00:00.000' AS DateTime), 10356, N'已处理', 57, CAST(N'2020-03-21T11:03:09.190' AS DateTime), CAST(N'2019-12-23T16:40:17.683' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (17, NULL, N'田果果', N'15538568732', CAST(N'2020-03-21T00:00:00.000' AS DateTime), 10345, N'已处理', 57, CAST(N'2020-09-06T21:44:12.630' AS DateTime), CAST(N'2020-03-21T11:06:35.643' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (18, NULL, N'123', N'18768857720', CAST(N'2021-01-15T00:00:00.000' AS DateTime), 10375, N'已处理', 63, CAST(N'2021-01-15T10:41:42.750' AS DateTime), CAST(N'2021-01-15T10:41:34.650' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (19, NULL, N'333', N'18768857720', CAST(N'2021-01-15T00:00:00.000' AS DateTime), 10358, N'已处理', 63, CAST(N'2021-01-15T14:31:57.927' AS DateTime), CAST(N'2021-01-15T14:31:41.530' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (20, NULL, N'王琦', N'13211111111', CAST(N'2021-09-14T00:00:00.000' AS DateTime), 10381, N'已处理', 64, CAST(N'2021-09-15T10:43:12.350' AS DateTime), CAST(N'2021-09-14T12:13:26.173' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (21, NULL, N'莫甘娜', N'18712345678', CAST(N'2022-02-24T00:00:00.000' AS DateTime), 10380, N'已处理', 63, CAST(N'2022-02-24T12:09:14.053' AS DateTime), CAST(N'2022-02-24T10:12:08.850' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (22, NULL, N'泽丽', N'187123455555', CAST(N'2022-02-24T00:00:00.000' AS DateTime), 10380, N'已处理', 63, CAST(N'2022-02-24T12:09:10.123' AS DateTime), CAST(N'2022-02-24T10:16:08.500' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (23, NULL, N'列娜塔', N'18712346666', CAST(N'2022-02-24T00:00:00.000' AS DateTime), 10380, N'已处理', 63, CAST(N'2022-02-24T12:08:54.200' AS DateTime), CAST(N'2022-02-24T10:16:23.457' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (24, NULL, N'希尔克', N'123121231233', CAST(N'2022-02-24T00:00:00.000' AS DateTime), 10380, N'已处理', 63, CAST(N'2022-02-24T10:18:16.903' AS DateTime), CAST(N'2022-02-24T10:16:33.350' AS DateTime), 0)
GO
INSERT [dbo].[T_HouseAppointments] ([Id], [UserId], [Name], [PhoneNum], [VisitDate], [HouseId], [Status], [FollowAdminUserId], [FollowDateTime], [CreateDateTime], [IsDeleted]) VALUES (25, NULL, N'莫甘娜', N'18712345678', CAST(N'2022-03-04T00:00:00.000' AS DateTime), 10323, N'已处理', 63, CAST(N'2022-03-04T10:37:32.900' AS DateTime), CAST(N'2022-03-04T09:29:21.760' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_HouseAppointments] OFF
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 7)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 9)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 323)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 324)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10340)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10357)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10359)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10362)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10363)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10364)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10365)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10367)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10368)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10370)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10371)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10373)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (1, 10382)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 323)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 324)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10340)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10357)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10359)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10362)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10363)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10364)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10365)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10368)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10375)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10380)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10382)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10383)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (2, 10384)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10357)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10368)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10371)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10373)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10380)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10381)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10382)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10383)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (3, 10384)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10351)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10357)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10360)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10367)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10368)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10370)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10374)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10381)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (4, 10384)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10341)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10351)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10360)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10364)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10368)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10372)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (5, 10381)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 322)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10341)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10350)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10351)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10360)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10361)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10364)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10368)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10370)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10371)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10372)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10375)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (6, 10381)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 322)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10341)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10350)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10351)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10361)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10367)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10372)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10374)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (7, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 9)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 10333)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 10341)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 10350)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 10361)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (8, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 9)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 11)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 10356)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 10359)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 10367)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 10370)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 10374)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (9, 10378)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 6)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 9)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 11)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 10356)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 10359)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 10366)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 10370)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 10375)
GO
INSERT [dbo].[T_HouseAttachments] ([AttachmentId], [HouseId]) VALUES (10, 10378)
GO
SET IDENTITY_INSERT [dbo].[T_HousePics] ON 
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (30, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:28.400' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (31, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:28.677' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (32, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:28.837' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (33, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:29.373' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (34, 2, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:50.253' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (35, 2, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:50.367' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (36, 2, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:50.823' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (37, 2, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T17:56:51.313' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (38, 7, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T18:04:31.477' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (39, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T18:25:38.773' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (40, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T18:25:39.093' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (41, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T18:25:39.153' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (42, 9, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-05-19T18:25:39.387' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (43, 11, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-05T14:42:23.500' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (44, 6, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-07T16:46:23.143' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (45, 6, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-07T16:47:12.613' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (46, 6, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-07T16:47:13.260' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (47, 6, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-07T16:48:16.713' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (48, 324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-18T20:00:16.883' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (49, 324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-18T20:00:48.820' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (50, 324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-19T16:14:00.573' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (51, 324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-07-19T16:14:01.370' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (52, 324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-08-07T16:07:33.093' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (53, 324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-08-07T16:07:33.697' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (54, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T13:59:00.223' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (55, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T13:59:00.387' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (56, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T13:59:00.440' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (57, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T13:59:00.907' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (58, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T14:12:41.157' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (59, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T14:12:41.357' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (60, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T14:12:41.650' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (61, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-17T14:12:42.173' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (62, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:01.557' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (63, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:01.697' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (64, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:01.807' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (65, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:01.883' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (66, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:01.983' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (67, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:02.097' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (68, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:02.520' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (69, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T16:35:03.037' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (70, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:27.877' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (71, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:28.100' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (72, 10366, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:28.647' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (73, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:40.690' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (74, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:40.867' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (75, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:41.030' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (76, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:41.170' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (77, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:41.257' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (78, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:41.373' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (79, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:41.743' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (80, 10359, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:42.310' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (81, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:57.030' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (82, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:57.170' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (83, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:57.350' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (84, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:57.530' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (85, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:57.637' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (86, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:58.080' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (87, 10360, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:09:58.587' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (88, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:13.350' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (89, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:13.483' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (90, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:13.620' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (91, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:13.723' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (92, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:13.830' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (93, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:13.930' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (94, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:14.397' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (95, 10361, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:14.910' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (96, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:28.853' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (97, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:29.027' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (98, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:29.170' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (99, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:29.267' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (100, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:29.377' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (101, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:29.830' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (102, 10349, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:29.937' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (103, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:43.650' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (104, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:43.793' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (105, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:43.947' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (106, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:44.060' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (107, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:44.177' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (108, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:44.300' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (109, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:44.703' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (110, 10350, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:45.193' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (111, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:57.623' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (112, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:57.757' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (113, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:57.913' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (114, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:58.047' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (115, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:58.163' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (116, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:58.267' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (117, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:58.377' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (118, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:58.670' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (119, 10351, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:10:59.163' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (120, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:17.667' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (121, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:17.830' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (122, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:17.983' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (123, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:18.093' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (124, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:18.200' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (125, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:18.313' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (126, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:18.470' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (127, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:18.693' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (128, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:19.270' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (129, 10341, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:37.790' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (130, 10341, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:37.910' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (131, 10341, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:38.050' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (132, 10341, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:38.333' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (133, 10341, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T17:11:38.837' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (134, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:04.767' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (135, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:05.013' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (136, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:05.473' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (137, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:05.987' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (139, 10344, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:25.927' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (140, 10344, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:26.090' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (141, 10344, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:26.433' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (142, 10344, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:26.990' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (143, 10345, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:39.587' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (144, 10345, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:40.110' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (145, 10346, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:52:52.157' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (146, 10347, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:00.647' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (147, 10347, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:04.790' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (148, 10347, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:05.330' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (149, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:18.620' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (150, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:18.813' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (151, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:18.957' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (152, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.080' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (153, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.193' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (154, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.313' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (155, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.397' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (156, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.507' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (157, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.713' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (158, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:19.867' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (159, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.030' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (160, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.160' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (161, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.293' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (162, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.460' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (163, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.593' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (164, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.690' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (165, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.797' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (166, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:20.933' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (167, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.060' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (168, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.177' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (169, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.290' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (170, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.423' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (171, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.540' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (172, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.670' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (173, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.787' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (174, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:21.910' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (175, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:22.193' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (176, 10348, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:22.763' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (177, 10352, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:41.767' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (178, 10352, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:42.267' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (179, 10353, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:53:53.910' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (180, 10354, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:02.780' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (181, 10354, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:03.313' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (182, 10355, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:13.653' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (183, 10355, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:14.203' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (184, 10332, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:22.673' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (185, 10332, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:23.233' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (186, 10333, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:34.737' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (187, 10333, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:35.303' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (188, 10334, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:45.757' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (189, 10334, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:46.287' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (190, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:55.353' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (191, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:55.480' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (192, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:55.640' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (193, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:55.780' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (194, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:55.893' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (195, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:56.017' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (196, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:56.443' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (197, 10335, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:54:56.937' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (198, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:07.547' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (199, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:07.720' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (200, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:07.890' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (201, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:07.997' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (202, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:08.103' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (203, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:08.660' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (204, 10336, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:55:09.153' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (205, 10337, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:08.953' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (206, 10338, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:16.707' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (207, 10339, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:25.063' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (208, 10339, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:25.573' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (209, 10343, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:36.253' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (210, 10327, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:49.617' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (211, 10327, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:50.133' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (212, 10327, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:56:50.680' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (213, 10328, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:00.617' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (214, 10330, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:14.093' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (215, 10330, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:14.210' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (216, 10330, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:14.417' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (217, 10330, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:14.613' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (218, 10330, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:15.123' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (219, 10325, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:51.123' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (220, 10325, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:51.693' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (221, 10325, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:57:52.207' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (222, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:58:01.413' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (223, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:58:01.537' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (224, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:58:01.927' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (225, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:58:02.453' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (226, 10365, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:19.523' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (227, 10365, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:19.877' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (228, 10365, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:20.107' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (229, 10365, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:20.727' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (230, 10364, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:29.763' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (231, 10364, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:30.017' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (232, 10364, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:30.350' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (233, 10363, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:40.263' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (234, 10363, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:40.513' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (235, 10363, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:40.870' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (236, 10363, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:41.107' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (237, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:52.697' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (238, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:53.323' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (239, 10356, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T18:59:53.897' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (240, 10329, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:04.443' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (241, 10329, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:04.707' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (242, 10329, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:05.120' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (243, 10329, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:05.400' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (244, 10329, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:06.087' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (245, 10331, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:20.040' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (246, 10331, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:20.237' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (247, 10331, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:20.510' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (248, 10331, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:20.567' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (249, 10326, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:32.047' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (250, 10326, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:32.300' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (251, 10326, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:32.597' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (252, 10326, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:32.937' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (253, 10326, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:33.317' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (254, 10326, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:33.933' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (255, 10324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:49.467' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (256, 10324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:50.017' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (257, 10324, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:00:50.610' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (258, 10342, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:04:06.433' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (259, 10342, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-23T19:04:06.883' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (260, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-27T17:14:10.550' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (261, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-27T17:14:10.760' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (262, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-27T17:14:10.843' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (263, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-27T17:14:10.943' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (264, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-27T17:14:11.380' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (265, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-09-27T17:14:11.900' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (266, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:22.250' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (267, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:22.360' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (268, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:22.460' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (269, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:22.570' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (270, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:22.670' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (271, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:22.793' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (272, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:23.130' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (273, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-23T22:23:23.200' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (282, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-24T15:30:56.527' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (283, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-24T15:30:56.937' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (284, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-10-24T15:30:57.473' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10282, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-01T14:27:57.343' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10283, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-01T14:27:57.697' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10284, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-01T14:27:57.787' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10285, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-01T14:27:58.307' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10286, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-01T14:27:58.817' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10287, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-02T12:20:29.577' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10288, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-02T12:20:29.943' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10289, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-02T12:20:30.470' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10290, 10357, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-02T12:20:31.003' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10291, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:47:46.967' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10292, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:47:47.383' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10293, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:47:47.920' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10294, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:50:27.740' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10295, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:50:28.187' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10296, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:50:28.720' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10297, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:56:51.810' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10298, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:56:52.097' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10299, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:56:52.227' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10300, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:56:52.817' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10301, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T12:56:53.297' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10302, 10367, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T15:37:09.143' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10303, 10367, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T15:37:09.537' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10304, 10367, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T15:37:10.063' AS DateTime), 1)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10305, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:39:59.627' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10306, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:39:59.877' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10307, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:40:00.050' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10308, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:40:00.237' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10309, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:40:00.347' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10310, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:40:00.517' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10311, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:40:00.860' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10312, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-03T21:40:01.377' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10313, 10364, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-05T22:45:17.693' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10314, 10364, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-05T22:45:18.337' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10315, 10364, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-11-05T22:45:18.850' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10316, 10333, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-12-23T16:44:13.700' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10317, 10333, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-12-23T16:44:14.013' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10318, 10333, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-12-23T16:44:14.607' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10319, 10333, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2019-12-23T16:44:15.123' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10328, 10374, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-20T17:25:45.767' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10329, 10374, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-20T17:25:45.763' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10330, 10358, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-22T12:16:03.907' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10331, 10358, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-22T12:16:03.950' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10332, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-22T16:44:31.670' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10333, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-22T16:44:31.667' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10334, 10358, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2020-09-24T10:20:14.133' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10335, 10358, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-01-15T10:08:25.050' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10336, 10358, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-01-15T10:08:25.567' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10337, 10358, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-01-15T14:24:52.213' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10338, 10380, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-07T11:29:07.300' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10339, 10380, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-07T11:29:33.177' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10340, 10380, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-07T11:29:33.223' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10341, 10380, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-07T14:35:37.607' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10342, 10380, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-07T14:35:37.817' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10343, 10380, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-07T15:30:19.797' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10344, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-14T12:01:55.510' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10345, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-09-14T12:01:56.177' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10346, 10378, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-10-21T17:23:07.607' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10347, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-12-27T17:13:05.913' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10348, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-12-27T17:13:06.397' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10349, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-12-27T17:13:06.933' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10350, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-12-30T11:58:56.100' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10351, 10381, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2021-12-30T11:58:56.587' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10352, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T09:14:42.457' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10353, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T09:14:42.457' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10354, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T09:14:42.443' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10355, 10323, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T10:10:42.797' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10356, 10384, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T11:24:12.100' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10357, 10384, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T11:24:12.100' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10358, 10368, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T14:04:50.610' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10359, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T15:22:39.407' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10360, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T15:22:39.407' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10361, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T15:22:39.407' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10362, 10340, N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', N'/upload/2022/02/17/52B80A7F52DE0F6A6E7D353128C35A29.jpg', CAST(N'2022-02-17T15:22:39.697' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10363, 10384, N'/upload/2022/07/25/D5EC26018860F2062F317F1F0A51DE30.jpg', N'/upload/2022/07/25/D5EC26018860F2062F317F1F0A51DE30_thumb.jpg', CAST(N'2022-07-25T11:55:18.517' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10364, 10384, N'/upload/2022/07/25/57A51EA8E779DE8B345AD0A5904C683D.jpg', N'/upload/2022/07/25/57A51EA8E779DE8B345AD0A5904C683D_thumb.jpg', CAST(N'2022-07-25T11:55:18.990' AS DateTime), 0)
GO
INSERT [dbo].[T_HousePics] ([Id], [HouseId], [Url], [ThumbUrl], [CreateDateTime], [IsDeleted]) VALUES (10365, 10384, N'/upload/2022/07/25/9637EFE8E957DD720FA32481E846AEF1.jpg', N'/upload/2022/07/25/9637EFE8E957DD720FA32481E846AEF1_thumb.jpg', CAST(N'2022-07-25T11:55:19.540' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_HousePics] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Houses] ON 
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (1, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (2, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (3, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (4, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (5, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (6, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (7, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (9, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (11, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (12, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (13, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (14, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (15, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (16, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (17, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (18, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (19, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (20, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (21, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (22, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (23, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (24, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (25, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (26, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (27, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (28, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (29, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (30, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (31, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (32, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (33, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (34, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (35, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (36, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (37, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (38, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (39, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (40, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (41, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (42, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (43, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (44, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (45, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (46, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (47, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (48, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (49, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (50, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (51, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (52, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (53, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (54, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (55, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (56, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (57, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (58, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (59, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (60, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (61, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (62, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (63, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (64, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (65, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (66, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (67, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (68, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (69, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (70, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (71, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (72, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (73, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (74, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (75, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (76, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (77, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (78, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (79, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (80, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (81, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (82, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (83, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (84, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (85, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (86, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (87, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (88, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (89, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (90, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (91, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (92, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (93, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (94, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (95, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (96, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (97, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (98, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (99, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (100, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (101, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (102, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (103, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (104, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (105, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (106, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (107, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (108, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (109, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (110, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (111, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (112, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (113, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (114, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (115, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (116, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (117, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (118, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (119, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (120, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (121, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (122, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (123, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (124, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (125, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (126, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (127, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (128, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (129, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (130, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (131, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (132, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (133, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (134, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (135, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (136, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (137, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (138, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (139, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (140, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (141, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (142, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (143, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (144, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (145, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (146, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (147, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (148, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (149, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (150, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (151, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (152, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (153, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (154, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (155, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (156, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (157, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (158, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (159, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (160, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (161, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (162, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (163, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (164, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (165, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (166, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (167, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (168, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (169, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (170, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (171, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (172, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (173, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (174, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (175, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (176, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (177, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (178, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (179, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (180, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (181, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (182, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (183, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (184, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (185, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (186, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (187, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (188, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (189, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (190, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (191, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (192, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (193, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (194, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (195, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (196, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (197, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (198, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (199, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (200, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (201, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (202, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (203, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (204, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (205, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (206, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (207, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (208, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (209, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (210, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (211, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (212, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (213, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (214, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (215, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (216, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (217, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (218, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (219, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (220, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (221, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (222, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (223, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (224, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (225, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (226, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (227, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (228, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (229, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (230, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (231, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (232, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (233, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (234, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (235, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (236, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (237, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (238, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (239, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (240, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (241, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (242, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (243, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (244, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (245, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (246, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (247, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (248, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (249, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (250, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (251, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (252, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (253, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (254, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (255, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (256, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (257, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (258, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (259, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (260, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (261, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (262, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (263, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (264, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (265, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (266, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (267, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (268, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (269, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (270, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (271, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (272, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (273, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (274, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (275, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (276, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (277, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (278, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (279, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (280, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (281, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (282, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (283, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (284, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (285, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (286, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (287, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (288, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (289, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (290, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (291, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (292, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (293, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (294, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (295, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (296, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (297, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (298, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (299, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (300, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (301, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (302, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (303, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (304, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (305, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (306, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (307, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (308, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (309, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (310, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (311, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (312, 1, 3, N'保利海德公园2号楼502', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:33:30.963' AS DateTime), CAST(N'2019-05-07T15:33:30.963' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:33:30.963' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (313, 1, 5, N'保利海德公园3号楼503', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:36:55.060' AS DateTime), CAST(N'2019-05-07T15:36:55.060' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:36:55.060' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (314, 1, 5, N'锦艺金水湾3号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 12, N'朝南', CAST(N'2019-05-07T15:38:00.177' AS DateTime), CAST(N'2019-05-07T15:38:00.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:00.177' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (315, 1, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:38:24.617' AS DateTime), CAST(N'2019-05-07T15:38:24.617' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:38:24.617' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (316, 2, 5, N'阳光城4号楼509', 2000, 7, CAST(102.00 AS Decimal(18, 2)), 14, 20, 11, 11, N'朝南', CAST(N'2019-05-07T15:39:56.380' AS DateTime), CAST(N'2019-05-07T15:39:56.380' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-05-07T15:39:56.380' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (317, 11, 3, N'小区1号楼26楼', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 14, 24, 12, 11, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'客厅宽敞舒适、客厅与落地阳台精致一体,自在心情无阻碍穿行,悠然自得。让充足的阳光不留余地的闯进来。', CAST(N'2019-05-18T11:15:44.133' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (318, 3, 6, N'管城区房源测试更新', 1800, 9, CAST(200.00 AS Decimal(18, 2)), 16, 120, 10, 12, N'南', CAST(N'2019-05-01T00:00:00.000' AS DateTime), CAST(N'2019-05-31T00:00:00.000' AS DateTime), N'曾志伟', N'13608668533', N'我的老班长', CAST(N'2019-05-18T11:46:27.633' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (319, 11, 6, N'上街区测试小区A栋502', 2000, 7, CAST(123.00 AS Decimal(18, 2)), 14, 12, 6, 12, N'朝南', CAST(N'2019-05-19T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'admin', N'13345623456', N'saaaaaaaaaaaaaaaa', CAST(N'2019-05-19T14:12:58.610' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (320, 1, 1, N'测试1', 1234, 7, CAST(100.00 AS Decimal(18, 2)), 14, 23, 12, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-16T00:00:00.000' AS DateTime), N'吴大伟', N'13345623456', N'测试1测试1测试1', CAST(N'2019-05-20T11:13:02.080' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (321, 3, 1, N'测试222222', 1500, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 12, N'朝南', CAST(N'2019-05-14T00:00:00.000' AS DateTime), CAST(N'2019-05-22T00:00:00.000' AS DateTime), N'曾志伟', N'15678923456', N'2121212', CAST(N'2019-05-20T11:13:35.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (322, 1, 1, N'1111111', 11, 7, CAST(12.00 AS Decimal(18, 2)), 14, 12, 1, 18, N'1', CAST(N'2019-05-20T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'短租', N'15678923456', N'短租测试', CAST(N'2019-05-20T13:50:57.723' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (323, 8, 3, N'二其纪念塔', 1200, 7, CAST(123.00 AS Decimal(18, 2)), 15, 12, 1, 11, N'南', CAST(N'2019-07-02T00:00:00.000' AS DateTime), CAST(N'2019-07-31T00:00:00.000' AS DateTime), N'田果', N'15678923456', N'<p><strong>随时看房,</strong><span style="color: rgb(79, 129, 189);"><strong><em>赶紧</em></strong></span><strong>来吧</strong></p>', CAST(N'2019-07-14T17:15:18.253' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (324, 8, 3, N'1111111111', 1200, 7, CAST(111.00 AS Decimal(18, 2)), 14, 12, 1, 12, N'朝南', CAST(N'2019-05-18T00:00:00.000' AS DateTime), CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'吴大伟', N'15678923456', N'<p><strong>122222222222</strong><span style="color: rgb(198, 217, 240);"><strong><em>22</em></strong></span></p>', CAST(N'2019-07-14T17:19:48.730' AS DateTime), 1)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10323, 1, 3, N'华润悦府2号楼402', 2200, 7, CAST(50.00 AS Decimal(18, 2)), 14, 22, 11, 12, N'朝南', CAST(N'2019-09-10T11:30:20.163' AS DateTime), CAST(N'2019-09-10T11:30:20.163' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.163' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10324, 1, 5, N'华润悦府1号楼502', 2300, 6, CAST(80.00 AS Decimal(18, 2)), 14, 32, 12, 11, N'朝南', CAST(N'2019-09-10T11:30:20.170' AS DateTime), CAST(N'2019-09-10T11:30:20.170' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.170' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10325, 1, 3, N'华润悦府2号楼202', 2200, 9, CAST(60.00 AS Decimal(18, 2)), 13, 21, 22, 12, N'朝南', CAST(N'2019-09-10T11:30:20.173' AS DateTime), CAST(N'2019-09-10T11:30:20.173' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.173' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10326, 1, 3, N'华润悦府2号楼201', 3300, 6, CAST(80.00 AS Decimal(18, 2)), 15, 15, 12, 11, N'朝南', CAST(N'2019-09-10T11:30:20.173' AS DateTime), CAST(N'2019-09-10T11:30:20.173' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.173' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10327, 1, 5, N'华润悦府2号楼407', 2300, 7, CAST(88.00 AS Decimal(18, 2)), 14, 22, 22, 12, N'朝南', CAST(N'2019-09-10T11:30:20.177' AS DateTime), CAST(N'2019-09-10T11:30:20.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.177' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10328, 1, 5, N'华润悦府3号楼206', 3200, 9, CAST(70.00 AS Decimal(18, 2)), 13, 24, 1, 12, N'朝南', CAST(N'2019-09-10T11:30:20.177' AS DateTime), CAST(N'2019-09-10T11:30:20.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.177' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10329, 1, 5, N'华润悦府2号楼501', 2200, 6, CAST(70.00 AS Decimal(18, 2)), 14, 22, 4, 11, N'朝南', CAST(N'2019-09-10T11:30:20.177' AS DateTime), CAST(N'2019-09-10T11:30:20.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.177' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10330, 1, 3, N'华润悦府4号楼403', 1200, 7, CAST(78.00 AS Decimal(18, 2)), 15, 24, 7, 12, N'朝南', CAST(N'2019-09-10T11:30:20.177' AS DateTime), CAST(N'2019-09-10T11:30:20.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.177' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10331, 1, 3, N'华润悦府2号楼302', 2200, 7, CAST(80.00 AS Decimal(18, 2)), 14, 22, 1, 11, N'朝南', CAST(N'2019-09-10T11:30:20.177' AS DateTime), CAST(N'2019-09-10T11:30:20.177' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.177' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10332, 1, 3, N'华润悦府1号楼103', 2300, 9, CAST(52.00 AS Decimal(18, 2)), 14, 22, 8, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'田果', N'15538568732', N'个人房源，无中介，课领包注入', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10333, 3, 5, N'郑州市管城回族区德风街36号', 450, 8, CAST(25.00 AS Decimal(18, 2)), 15, 30, 5, 12, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'巴帅', N'15538568732', N'<p>&nbsp;个人直租 房间干净 无 <span style="color: rgb(255, 192, 0);"><strong>押一付一&nbsp; ,详细页面采用</strong></span><span style="text-decoration: underline; color: rgb(84, 141, 212);"><strong><em>静态页技术,</em></strong></span><span style="color: rgb(255, 192, 0);"><strong>图片存储的<span style="border: 1px solid rgb(0, 0, 0); color: rgb(149, 55, 52);">云端</span>,分流减压&nbsp;&nbsp;</strong></span>&nbsp;&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p><p><img src="http://q2ndzpaag.bkt.clouddn.com/upload/2019/12/23/64C6C4298E5877863B4FA3456A798F0B.jpg" title="240x180c (9).jpg" alt="240x180c (9).jpg"/><span style="color: rgb(149, 55, 52);"></span></p>', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10334, 3, 3, N'管城-富田太阳城 映月路51号', 550, 8, CAST(22.00 AS Decimal(18, 2)), 15, 7, 7, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'巴帅', N'15538568732', N'中州大道 富田太陽城 一站式购物广场 精装修', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10335, 3, 5, N'管城-富田太阳城 航海东路20号', 500, 8, CAST(23.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'王彦飞', N'15538568732', N'未来路 宝景花园 航海广场地铁口 精装修 全女生', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10336, 4, 5, N'管城-富田太阳城 石化路69号', 550, 8, CAST(20.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'邱龄威', N'17093692995', N'中州大道石化路 美景天城 实木家具家电齐全 阳台 飘窗 空调', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10337, 4, 5, N'管城-富田太阳城 映月路51号', 660, 8, CAST(23.00 AS Decimal(18, 2)), 15, 7, 4, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'邱龄威', N'17093692995', N'中州大道 富田太.阳城 一站式购物广场 真.实房源 无杂费', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10338, 4, 6, N'管城-富田太阳城 映月路51号', 650, 8, CAST(26.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'杨望', N'17079457981', N'富田广场 富田太阳 城 地铁口旁边 精装次卧可做饭 拎包入住', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10339, 4, 5, N'郑州市管城回族区德风街36号', 750, 8, CAST(40.00 AS Decimal(18, 2)), 15, 32, 30, 12, N'朝南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'谢燕丽', N'17183663239', N'实拍图 一口价 未来路航海路 电梯房 全女生 家电齐全随时看', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10340, 3, 1, N'管城-富田太阳城 映月路51号1----1', 8000, 8, CAST(300.00 AS Decimal(18, 2)), 15, 11, 3, 18, N'南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'李刚', N'17104461671', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src="http://img.baidu.com/hi/jx2/j_0013.gif"/>地铁口500米 精装三房带50平露台 拎包入住 随时<strong>看房
 &nbsp; &nbsp;</strong> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2022-02-18T15:15:29.013' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10341, 4, 3, N'管城-富田太阳城 映月路51号', 1800, 8, CAST(88.00 AS Decimal(18, 2)), 15, 27, 12, 18, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'高露露', N'17079452768', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;航海路 地铁口閏号线 精装双气两房 家具家电齐全 拎包入住
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10342, 9, 5, N'郑州市中原区陇海路18号', 450, 8, CAST(25.00 AS Decimal(18, 2)), 15, 30, 5, 12, N'南', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'巴帅', N'15538568732', N'成熟大盘、紧凑小三房，精装修，业主诚售', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10343, 9, 7, N'汇泉西悦城 [中原-西流湖]', 550, 8, CAST(22.00 AS Decimal(18, 2)), 15, 7, 7, 12, N'西北', CAST(N'2019-09-10T11:30:20.180' AS DateTime), CAST(N'2019-09-10T11:30:20.180' AS DateTime), N'谢璐璐', N'17079452768', N'新毛胚房 三室两厅 位置好 交通便利', CAST(N'2019-09-10T11:30:20.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10344, 10, 5, N'中原陇海路与西四环交汇处', 500, 8, CAST(23.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'南北', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'毋亚军', N'15538568732', N'南北.通透小三房 毛坯 适宜楼层 采光充足', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10345, 10, 5, N'汇泉西悦城 [中原-西流湖]', 550, 8, CAST(20.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'朝南', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'邱龄威', N'17093692995', N'汇泉西悦城，不限购不限贷，买一层送一层，不限购不限贷', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10346, 10, 5, N'汇泉西悦城 [中原-西流湖]', 660, 8, CAST(23.00 AS Decimal(18, 2)), 15, 7, 4, 12, N'朝南', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'毋亚军', N'15538568732', N'个人直租 房间干净 无 押一付一', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10347, 10, 6, N'汇泉西悦城 映月路51号', 650, 8, CAST(26.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'南北', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'毋亚军', N'15538568732', N'噢林匹克中心的附近，特价房，8000多双气小户型，首付两万', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10348, 10, 5, N'郑州市植物园南36号', 750, 8, CAST(40.00 AS Decimal(18, 2)), 15, 32, 30, 12, N'朝南', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'毋亚军', N'15538568732', N'汇泉西悦城 3室2厅 精装修', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10349, 10, 5, N'汇泉西悦城 [中原-西流湖]', 3300, 8, CAST(160.00 AS Decimal(18, 2)), 15, 11, 3, 18, N'西北', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'李克宁', N'17104461671', N'四大心中 植物园旁汇泉西悦城现房', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10350, 10, 3, N'汇泉西悦城 [中原-西流湖]', 1800, 8, CAST(88.00 AS Decimal(18, 2)), 15, 27, 12, 18, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'高凯', N'17079452768', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;郑州鸟巢旁边,108平125万 车位另算,随时看房
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10351, 10, 3, N'汇泉西悦城 [中原-西流湖]', 1800, 8, CAST(88.00 AS Decimal(18, 2)), 15, 27, 12, 18, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'毋亚军', N'15538568732', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;郑州鸟巢旁边,108平125万 车位另算,随时看房
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10352, 18, 5, N'姚桥社区南1号楼', 450, 8, CAST(25.00 AS Decimal(18, 2)), 15, 30, 5, 12, N'南', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'一号', N'15538568732', N'成熟大盘、紧凑小三房，精装修，业主诚售', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10353, 18, 6, N'姚桥社区南2号楼', 550, 8, CAST(22.00 AS Decimal(18, 2)), 15, 7, 7, 12, N'西北', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'二号', N'17079452768', N'新毛胚房 三室两厅 位置好 交通便利', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10354, 18, 5, N'姚桥社区南3号楼', 500, 8, CAST(23.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'南北', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'三号', N'15538568732', N'南北.通透小三房 毛坯 适宜楼层 采光充足', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10355, 18, 5, N'姚桥社区南4号楼', 550, 8, CAST(20.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'朝南', CAST(N'2019-09-10T11:30:20.183' AS DateTime), CAST(N'2019-09-10T11:30:20.183' AS DateTime), N'四号', N'17093692995', N'汇泉西悦城，不限购不限贷，买一层送一层，不限购不限贷', CAST(N'2019-09-10T11:30:20.183' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10356, 15, 1, N'姚桥社区南6号楼', 990, 7, CAST(28.00 AS Decimal(18, 2)), 14, 88, 8, 11, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'lianjia', N'15538568732', N'<p><span style="text-decoration: underline;">整租</span>变为<strong>合租</strong><br/></p>', CAST(N'2019-09-10T11:30:20.187' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10357, 18, 1, N'姚桥社区南6号楼', 650, 8, CAST(26.00 AS Decimal(18, 2)), 15, 7, 6, 12, N'南北', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'六号', N'15538568732', N'<p><strong>&nbsp;超市附近</strong>,特价房,8000多双气小户型,首付两万
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.187' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10358, 18, 5, N'姚桥社区南7号楼', 750, 8, CAST(40.00 AS Decimal(18, 2)), 15, 32, 30, 12, N'朝南', CAST(N'2019-09-10T11:30:20.187' AS DateTime), CAST(N'2019-09-10T11:30:20.187' AS DateTime), N'七号', N'15538568732', N'姚桥 3室2厅 精装修', CAST(N'2019-09-10T11:30:20.187' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10359, 18, 5, N'姚桥社区南8号楼', 3300, 8, CAST(160.00 AS Decimal(18, 2)), 15, 11, 3, 18, N'西北', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'八号', N'17104461671', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;四大心中 植物园旁汇泉西悦城现房
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.187' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10360, 18, 3, N'姚桥社区南9号楼', 1800, 8, CAST(88.00 AS Decimal(18, 2)), 15, 27, 12, 18, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'九号', N'17079452768', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;楼下网吧附近,108平125万 车位另算,随时看房
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.187' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10361, 18, 3, N'姚桥社区南10号楼', 1800, 8, CAST(88.00 AS Decimal(18, 2)), 15, 27, 12, 18, N'朝南', CAST(N'2019-09-10T11:30:20.000' AS DateTime), CAST(N'2019-09-10T11:30:20.000' AS DateTime), N'十号', N'15538568732', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;楼下网吧楼上,采光充足 车位另算,随时看房
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>', CAST(N'2019-09-10T11:30:20.187' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10362, 3, 3, N'管城区阳光城32号楼', 1000, 7, CAST(34.00 AS Decimal(18, 2)), 15, 12, 1, 11, N'南', CAST(N'2019-09-12T00:00:00.000' AS DateTime), CAST(N'2019-09-19T00:00:00.000' AS DateTime), N'链家地产', N'15538568732', N'<p>拎包入住拎包入住拎包入住</p>', CAST(N'2019-09-17T10:51:50.007' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10363, 15, 3, N'博学路磨李社区', 1000, 7, CAST(45.00 AS Decimal(18, 2)), 14, 16, 12, 11, N'北', CAST(N'2019-09-04T00:00:00.000' AS DateTime), CAST(N'2019-09-19T00:00:00.000' AS DateTime), N'我爱我家', N'15538678732', N'<p>押一付一,直接入住<br/></p>', CAST(N'2019-09-17T16:26:48.427' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10364, 15, 5, N'测试', 2000, 7, CAST(46.00 AS Decimal(18, 2)), 15, 12, 2, 11, N'南', CAST(N'2019-09-05T14:42:10.000' AS DateTime), CAST(N'2019-09-18T00:00:00.000' AS DateTime), N'链家', N'18838787845', N'<p>测试数据测试数据测<em>试数</em>据测试数据<span style="color: rgb(247, 150, 70);">测试</span><span style="color: rgb(255, 255, 0);"><strong>数据</strong></span></p>', CAST(N'2019-09-18T14:49:33.450' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10365, 10, 3, N'中原区建业之家', 1000, 7, CAST(23.00 AS Decimal(18, 2)), 15, 6, 2, 11, N'南', CAST(N'2019-09-13T00:00:00.000' AS DateTime), CAST(N'2019-09-27T00:00:00.000' AS DateTime), N'王健林', N'15538568712', N'<p><strong>添加</strong>房源<span style="color: rgb(196, 189, 151);">信息</span></p>', CAST(N'2019-09-23T16:13:11.263' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10366, 1, 5, N'555555', 222, 7, CAST(12.00 AS Decimal(18, 2)), 15, 23, 1, 18, N'北', CAST(N'2019-09-21T00:00:00.000' AS DateTime), CAST(N'2019-09-27T00:00:00.000' AS DateTime), N'驱蚊器我去', N'15538976392', N'<p>ssssssssss44444444</p>', CAST(N'2019-09-23T16:17:43.060' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10367, 4, 5, N'管城区2013测试', 2000, 7, CAST(100.00 AS Decimal(18, 2)), 14, 10, 3, 18, N'南', CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2019-10-23T00:00:00.000' AS DateTime), N'李四', N'15538568732', N'<p>20191023 2231测试<em><strong>录视频</strong></em></p>', CAST(N'2019-10-23T22:22:18.770' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10368, 10, 3, N'科学大道中国移动附近', 1000, 7, CAST(76.00 AS Decimal(18, 2)), 15, 6, 2, 18, N'南', CAST(N'2019-11-03T00:00:00.000' AS DateTime), CAST(N'2019-11-13T00:00:00.000' AS DateTime), N'我爱我家', N'15538568712', N'<p>房子<span style="text-decoration: underline;">坐南朝北</span>,<em>采</em><em>光很好</em>,拎包<font color="#974806"><b>入住<img src="http://img.baidu.com/hi/jx2/j_0011.gif"/></b></font></p>', CAST(N'2019-11-03T12:52:42.663' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10370, 1, 1, N'大平层', 100, 7, CAST(130.00 AS Decimal(18, 2)), 14, 23, 12, 11, N'南', CAST(N'2020-05-05T00:00:00.000' AS DateTime), CAST(N'2020-05-06T00:00:00.000' AS DateTime), N'何先生', N'15738890332', N'<p><img src="http://q9u5l1deq.bkt.clouddn.com/upload/2020/05/05/587294139ED6E0FBAAC99FA1BF4CE474.jpg" title="豪宅.jpg" alt="豪宅.jpg"/></p>', CAST(N'2020-05-05T17:00:45.580' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10371, 19, 1, N'中兴新业港', 1000, 7, CAST(120.00 AS Decimal(18, 2)), 16, 23, 11, 11, N'东', CAST(N'2020-05-05T00:00:00.000' AS DateTime), CAST(N'2020-05-05T00:00:00.000' AS DateTime), N'何先生', N'15738890332', N'<p><img src="http://q9u5l1deq.bkt.clouddn.com/upload/2020/05/05/587294139ED6E0FBAAC99FA1BF4CE474.jpg" title="豪宅.jpg" alt="豪宅.jpg"/></p><p>1232323</p>', CAST(N'2020-05-05T17:11:28.217' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10372, 1, 1, N'大平层', 100, 7, CAST(120.00 AS Decimal(18, 2)), 16, 13, 1, 13, N'东', CAST(N'2020-05-12T00:00:00.000' AS DateTime), CAST(N'2020-05-12T00:00:00.000' AS DateTime), N'马总', N'15738890332', N'<p><img src="http://q9u5l1deq.bkt.clouddn.com/upload/2020/05/12/587294139ED6E0FBAAC99FA1BF4CE474.jpg" title="豪宅.jpg" alt="豪宅.jpg"/></p><p>距离圣诞节拉飞机了多少</p>', CAST(N'2020-05-12T13:41:33.127' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10373, 4, 1, N'老师的', 66, 7, CAST(24.00 AS Decimal(18, 2)), 15, 33, 13, 11, N'南', CAST(N'2020-05-12T00:00:00.000' AS DateTime), CAST(N'2020-05-12T00:00:00.000' AS DateTime), N'任先生', N'15738890332', N'<p>收到</p>', CAST(N'2020-05-12T13:46:39.887' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10374, 1, 1, N'12栋5楼7室', 2000, 8, CAST(123.00 AS Decimal(18, 2)), 14, 5, 20, 11, N'南', CAST(N'2020-09-15T00:00:00.000' AS DateTime), CAST(N'2020-09-29T00:00:00.000' AS DateTime), N'王大锤', N'13212345678', N'<p><strong>豪华装修&nbsp;阳台视野开阔</strong><strong><em><span style="text-decoration: underline;"><img src="http://img.baidu.com/hi/jx2/j_0013.gif"/><img src="http://qblklxluo.bkt.clouddn.com/upload/2020/09/20/9126E75717C81AB00C05FEEB2CACBD3E.jpg" title="room.jpg" alt="room.jpg"/></span></em></strong><strong><span style="text-decoration: underline;"></span></strong></p>', CAST(N'2020-09-20T14:00:37.317' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10375, 20, 1, N'18楼东户9层2室', 4000, 7, CAST(200.00 AS Decimal(18, 2)), 14, 9, 30, 13, N'北', CAST(N'2020-09-08T00:00:00.000' AS DateTime), CAST(N'2020-09-30T00:00:00.000' AS DateTime), N'林俊杰', N'13212345678', N'<p>小区安保较好，整体设施较新。</p><p><img src="http://qgrddyqll.hb-bkt.clouddn.com/upload/2020/09/20/7C813BDFEC1BE601F5F46EC633E4CC26.jpg" style="width: 250px; height: 159px;" title="roomlist.jpg" width="250" height="159"/></p><p><img src="http://qgrddyqll.hb-bkt.clouddn.com/upload/2020/09/20/71017D817DF7B63435FD57927252E4E1.jpg" style="width: 246px; height: 154px;" title="list-img.jpg" width="246" height="154"/></p><p><br/></p>', CAST(N'2020-09-20T14:52:17.810' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10378, 17, 3, N'123', 400, 8, CAST(24.00 AS Decimal(18, 2)), 14, 12, 2, 11, N'南', CAST(N'2021-09-01T00:00:00.000' AS DateTime), CAST(N'2021-09-03T00:00:00.000' AS DateTime), N'琴女1111', N'13212334567', N'<p><img src="http://img.baidu.com/hi/jx2/j_0003.gif"/>真好看</p>', CAST(N'2021-09-02T11:39:01.633' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10380, 1, 1, N'123', 100, 7, CAST(100.00 AS Decimal(18, 2)), 14, 12, 1, 12, N'南', CAST(N'2021-09-01T00:00:00.000' AS DateTime), CAST(N'2021-09-03T00:00:00.000' AS DateTime), N'琴女1111', N'13212334567', N'<p>12</p>', CAST(N'2021-09-03T12:25:28.427' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10381, 1, 1, N'123123', 6000, 7, CAST(1000.00 AS Decimal(18, 2)), 14, 50, 20, 12, N'南', CAST(N'2021-09-06T00:00:00.000' AS DateTime), CAST(N'2021-09-15T00:00:00.000' AS DateTime), N'琴女', N'13211111111', N'<p>描述信息啦啦啦啦啦</p>', CAST(N'2021-09-14T12:01:29.160' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10382, 1, 1, N'123', 3000, 7, CAST(100.00 AS Decimal(18, 2)), 14, 20, 1, 11, N'南', CAST(N'2022-02-15T00:00:00.000' AS DateTime), CAST(N'2022-02-18T00:00:00.000' AS DateTime), N'琴女', N'13211111111', N'<p><img src="http://img.baidu.com/hi/jx2/j_0013.gif"/>1231233123</p>', CAST(N'2022-02-16T10:37:57.507' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10383, 15, 1, N'123', 2000, 7, CAST(200.00 AS Decimal(18, 2)), 14, 20, 1, 13, N'南', CAST(N'2022-02-08T00:00:00.000' AS DateTime), CAST(N'2022-02-17T00:00:00.000' AS DateTime), N'琴女1111', N'13212334567', N'<p><img src="http://img.baidu.com/hi/jx2/j_0025.gif"/>干净整洁</p>', CAST(N'2022-02-16T15:24:43.027' AS DateTime), 0)
GO
INSERT [dbo].[T_Houses] ([Id], [CommunityId], [RoomTypeId], [Address], [MonthRent], [StatusId], [Area], [DecorateStatusId], [TotalFloorCount], [FloorIndex], [TypeId], [Direction], [LookableDateTime], [CheckInDateTime], [OwnerName], [OwnerPhoneNum], [Description], [CreateDateTime], [IsDeleted]) VALUES (10384, 4, 1, N'龙子湖', 2000, 8, CAST(400.00 AS Decimal(18, 2)), 14, 2, 1, 18, N'南', CAST(N'2022-02-08T00:00:00.000' AS DateTime), CAST(N'2022-02-25T00:00:00.000' AS DateTime), N'琴女1111', N'13212334567', N'<p><img src="http://img.baidu.com/hi/jx2/j_0027.gif"/>222222222222</p>', CAST(N'2022-02-18T10:28:17.797' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Houses] OFF
GO
SET IDENTITY_INSERT [dbo].[T_IdNames] ON 
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (1, N'户型', N'四室', CAST(N'2019-05-06T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (3, N'户型', N'一室', CAST(N'2019-05-07T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (5, N'户型', N'两室', CAST(N'2019-05-03T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (6, N'户型', N'三室', CAST(N'2019-05-01T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (7, N'房屋状态', N'出租中', CAST(N'2019-05-01T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (8, N'房屋状态', N'已出租', CAST(N'2019-05-07T14:59:46.767' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (9, N'房屋状态', N'锁定中', CAST(N'2019-05-07T15:00:03.867' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (11, N'房屋类型', N'合租', CAST(N'2019-05-07T15:01:00.130' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (12, N'房屋类型', N'整租', CAST(N'2019-05-07T15:01:17.730' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (13, N'房屋类型', N'品牌公寓', CAST(N'2019-05-07T15:01:26.650' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (14, N'装修状态', N'精装修', CAST(N'2019-05-07T15:02:23.333' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (15, N'装修状态', N'简单装修', CAST(N'2019-05-07T15:02:39.780' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (16, N'装修状态', N'毛坯', CAST(N'2019-05-07T15:02:46.443' AS DateTime), 0)
GO
INSERT [dbo].[T_IdNames] ([Id], [TypeName], [Name], [CreateDateTime], [IsDeleted]) VALUES (18, N'房屋类型', N'短租', CAST(N'2019-05-20T00:00:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_IdNames] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Permissions] ON 
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (2, N'添加房源', N'addfy', CAST(N'2019-04-02T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (6, N'上传图片', N'uploadTp', CAST(N'2019-04-02T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (7, N'增加管理员', N'addAdmin', CAST(N'2019-04-02T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (12, N'删除管理员', N'deleteAdmin', CAST(N'2019-04-10T15:04:14.330' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10017, N'增加权限', N'addPermission', CAST(N'2019-08-26T19:29:27.837' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10019, N'删除权限', N'deletPermission', CAST(N'2019-08-26T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10030, N'展示权限', N'lookPers', CAST(N'2019-09-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10031, N'查看管理员信息', N'lookAdmin', CAST(N'2019-09-11T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10032, N'查看房源', N'lookHouse', CAST(N'2019-09-16T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10036, N'用户管理', N'user-gl', CAST(N'2019-11-03T13:54:40.007' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10037, N'角色添加视图', N'addRoleview', CAST(N'2019-11-03T13:55:11.293' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10038, N'角色添加提交', N'addRolePost', CAST(N'2019-11-03T13:55:48.427' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (10039, N'角色修改', N'updateRole', CAST(N'2020-05-25T14:36:52.877' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (20039, N'角色查看', N'lookRole', CAST(N'2020-05-26T21:09:29.833' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30039, N'我的权限007', N'my-permission007', CAST(N'2020-05-26T22:34:46.277' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30041, N'123', N'123', CAST(N'2020-09-06T23:39:09.680' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30042, N'123', N'123', CAST(N'2020-09-07T00:09:26.130' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30043, N'1231', N'3211', CAST(N'2020-09-07T00:19:59.610' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30044, N'12', N'12', CAST(N'2020-09-07T23:19:56.353' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30045, N'123', N'123', CAST(N'2020-09-07T23:20:03.570' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30046, N'456', N'456', CAST(N'2020-09-07T23:20:08.527' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30047, N'123123', N'123ad', CAST(N'2020-09-08T19:29:30.157' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30048, N'312123123', N'管理员12312', CAST(N'2020-09-08T19:30:09.180' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30049, N'123123', N'3421', CAST(N'2020-09-08T19:32:36.913' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30050, N'描述信息', N'qwer', CAST(N'2020-09-09T11:30:02.707' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30051, N'123123', N'456789', CAST(N'2020-12-30T12:21:00.627' AS DateTime), 0)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30052, N'123', N'456789', CAST(N'2020-12-30T12:21:12.603' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30053, N'哈哈', N'查看用户信息', CAST(N'2021-08-20T10:48:02.977' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30054, N'哈哈哈哈', N'查看用户信息哈哈', CAST(N'2021-08-20T17:47:53.247' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30055, N'哈哈', N'查看用户信息', CAST(N'2021-08-20T17:51:27.580' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30056, N'添加用户权限', N'AddUsers123', CAST(N'2021-08-23T10:04:18.170' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30057, N'哈哈111', N'琴女33333', CAST(N'2022-01-04T12:18:14.070' AS DateTime), 1)
GO
INSERT [dbo].[T_Permissions] ([Id], [Description], [Name], [CreateDateTime], [IsDeleted]) VALUES (30058, N'哈哈1231', N'会员3455', CAST(N'2022-01-05T15:23:15.260' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[T_Permissions] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Regions] ON 
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (2, N'金水区', 1, CAST(N'2019-05-07T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (3, N'管城区', 1, CAST(N'2019-05-07T09:12:19.857' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (4, N'高新区', 1, CAST(N'2019-05-07T09:12:53.150' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (5, N'二七区', 1, CAST(N'2019-05-07T09:13:07.233' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (6, N'中原区', 1, CAST(N'2019-05-07T09:13:52.933' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (7, N'上街区', 1, CAST(N'2019-05-07T09:14:01.597' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (8, N'涧西区', 2, CAST(N'2019-05-07T09:14:51.620' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (9, N'洛龙区', 2, CAST(N'2019-05-07T09:15:00.037' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (10, N'老城区', 2, CAST(N'2019-05-07T09:15:07.363' AS DateTime), 0)
GO
INSERT [dbo].[T_Regions] ([Id], [Name], [CityId], [CreateDateTime], [IsDeleted]) VALUES (11, N'西工区', 2, CAST(N'2019-05-07T09:15:44.240' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Regions] OFF
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (1, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (1, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (1, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (1, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (1, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (3, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (8, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (9, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10012, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10013, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10013, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10017, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10017, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10017, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10017, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10017, 30047)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10017, 30048)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10053, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10053, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10055, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10055, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10055, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10055, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10062, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10062, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10062, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10063, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10063, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10063, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10064, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10064, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10064, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10064, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10064, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10064, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10065, 30044)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10066, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10066, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10067, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10067, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10067, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10067, 30044)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10068, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10068, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10068, 30044)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10069, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10069, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10069, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10069, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10069, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10069, 30044)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10070, 30044)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10071, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10071, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10071, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10071, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10071, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10071, 30044)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10072, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10072, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10072, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10072, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10072, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10073, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10073, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10073, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10073, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10073, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10074, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10074, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10074, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10075, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10076, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10076, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10076, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10077, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10077, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10077, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10077, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10077, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10077, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10078, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10078, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10078, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10078, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10078, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10078, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10079, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10079, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10079, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10079, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10079, 10032)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10080, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10081, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10081, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10082, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10082, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10083, 10017)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10084, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10085, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10088, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10089, 7)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10089, 12)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10089, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10089, 10031)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10089, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10089, 10039)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10092, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10092, 10036)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10092, 30051)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10092, 30052)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10096, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10096, 6)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10096, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10096, 10030)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10096, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10097, 2)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10097, 10019)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10098, 20039)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10099, 10037)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10100, 10038)
GO
INSERT [dbo].[T_RolePermissions] ([RoleId], [PermissionId]) VALUES (10101, 10039)
GO
SET IDENTITY_INSERT [dbo].[T_Roles] ON 
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (1, N'后台管理员', CAST(N'2019-04-11T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (2, N'实习编辑', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (3, N'房源管理员', CAST(N'2019-04-08T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (5, N'客服', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (8, N'分配房源', CAST(N'2019-04-11T16:42:03.053' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (9, N'测试角色', CAST(N'2019-04-14T14:30:39.113' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10012, N'超级管理员', CAST(N'2019-11-03T13:56:29.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10013, N'测试角色11', CAST(N'2020-05-27T19:26:14.637' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10015, N'12123123', CAST(N'2020-08-30T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10016, N'后台管理员', CAST(N'2019-04-11T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10017, N'实习编辑', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10018, N'房源管理员', CAST(N'2019-04-08T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10019, N'客服', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10020, N'分配房源', CAST(N'2019-04-11T16:42:03.053' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10021, N'测试角色', CAST(N'2019-04-14T14:30:39.113' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10022, N'超级管理员', CAST(N'2019-11-03T13:56:29.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10023, N'测试角色11', CAST(N'2020-05-27T19:26:14.637' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10024, N'12123123', CAST(N'2020-08-30T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10025, N'后台管理员', CAST(N'2019-04-11T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10026, N'实习编辑', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10027, N'房源管理员', CAST(N'2019-04-08T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10028, N'客服', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10029, N'分配房源', CAST(N'2019-04-11T16:42:03.053' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10030, N'测试角色', CAST(N'2019-04-14T14:30:39.113' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10031, N'超级管理员', CAST(N'2019-11-03T13:56:29.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10032, N'测试角色11', CAST(N'2020-05-27T19:26:14.637' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10033, N'12123123', CAST(N'2020-08-30T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10034, N'后台管理员', CAST(N'2019-04-11T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10035, N'实习编辑', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10036, N'房源管理员', CAST(N'2019-04-08T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10037, N'客服', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10038, N'分配房源', CAST(N'2019-04-11T16:42:03.053' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10039, N'测试角色', CAST(N'2019-04-14T14:30:39.113' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10040, N'超级管理员', CAST(N'2019-11-03T13:56:29.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10044, N'123123123123', CAST(N'2020-08-30T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10045, N'3', CAST(N'2020-09-03T00:47:11.037' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10046, N'3', CAST(N'2020-09-03T00:47:11.037' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10047, N'1', CAST(N'2020-09-03T00:47:16.770' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10048, N'1', CAST(N'2020-09-03T00:47:16.777' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10049, N'3', CAST(N'2020-09-03T00:48:45.497' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10050, N'3', CAST(N'2020-09-03T00:48:45.500' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10051, N'管理员', CAST(N'2020-09-03T00:50:10.020' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10052, N'管理员', CAST(N'2020-09-03T00:50:10.023' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10053, N'管理员', CAST(N'2020-09-03T00:51:01.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10054, N'3', CAST(N'2020-09-03T00:54:35.717' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10055, N'角色名333', CAST(N'2020-09-03T00:54:35.720' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10056, N'管理员123123', CAST(N'2020-09-03T00:56:46.673' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10057, N'管理员123123', CAST(N'2020-09-03T00:56:46.677' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10060, N'13212312312', CAST(N'2020-08-30T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10061, N'管理员123123', CAST(N'2020-09-08T00:37:09.790' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10062, N'qwer', CAST(N'2020-09-10T16:08:36.683' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10063, N'管理员qwer', CAST(N'2020-09-10T16:12:02.743' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10064, N'qwerqwer', CAST(N'2020-09-10T16:46:59.623' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10065, N'qwerqwer', CAST(N'2020-09-10T17:25:40.617' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10066, N'角色123321', CAST(N'2020-09-11T11:11:32.420' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10067, N'管理员qwer', CAST(N'2020-09-11T11:13:39.500' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10068, N'管理员321123', CAST(N'2020-09-11T11:17:20.613' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10069, N'管理员qwer', CAST(N'2020-09-11T16:49:08.743' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10070, N'管理员321123', CAST(N'2020-09-14T16:24:21.270' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10071, N'管理员qwer', CAST(N'2020-09-14T16:26:50.807' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10072, N'管理员321123', CAST(N'2020-09-14T16:27:44.243' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10073, N'管理员321', CAST(N'2020-09-14T16:28:09.630' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10074, N'后台管理员', CAST(N'2020-09-16T00:04:19.170' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10075, N'实习编辑', CAST(N'2020-09-16T00:04:29.807' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10076, N'客服客服', CAST(N'2020-09-16T00:04:47.327' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10077, N'后台管理员', CAST(N'2020-09-16T00:22:38.733' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10078, N'后台管理员', CAST(N'2020-09-16T00:22:56.327' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10079, N'后台管理员', CAST(N'2020-09-16T00:23:19.643' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10080, N'测试角色', CAST(N'2020-09-16T00:24:34.547' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10081, N'测试角色', CAST(N'2020-09-16T00:24:41.787' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10082, N'测试角色测试', CAST(N'2020-09-16T00:25:16.703' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10083, N'添加权限角色', CAST(N'2020-09-18T00:07:01.753' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10084, N'删除权限角色', CAST(N'2020-09-18T00:07:16.570' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10085, N'展示权限角色', CAST(N'2020-09-18T00:07:28.090' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10088, N'安妮安妮123', CAST(N'2021-08-23T11:12:14.943' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10089, N'战士', CAST(N'2021-08-23T16:36:20.930' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10092, N'琴女1111', CAST(N'2021-12-30T12:01:21.977' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10093, N'销售实习生', CAST(N'2022-01-11T17:09:50.243' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10094, N'角色111', CAST(N'2022-01-12T14:38:55.703' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10095, N'角色2222', CAST(N'2022-01-12T15:01:20.757' AS DateTime), 1)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10096, N'新修改的角色', CAST(N'2022-01-12T16:37:01.040' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10097, N'琴女', CAST(N'2022-01-13T17:00:02.657' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10098, N'1角色查看', CAST(N'2022-01-19T11:11:46.550' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10099, N'2角色添加', CAST(N'2022-01-19T11:12:05.997' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10100, N'2角色添加提交', CAST(N'2022-01-19T11:12:22.473' AS DateTime), 0)
GO
INSERT [dbo].[T_Roles] ([Id], [Name], [CreateDateTime], [IsDeleted]) VALUES (10101, N'3角色修改', CAST(N'2022-01-19T11:12:33.257' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Settings] ON 
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (1, N'短信平台AppKey', N'fdsafasdf@adfasdfa', CAST(N'2019-05-20T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (3, N'短信平台UserName', N'rupengtest1 ', CAST(N'2019-05-20T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (5, N'短信平台注册短信模板Id', N'11', CAST(N'2019-05-20T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (7, N'老板邮箱', N'362520246@qq.com', CAST(N'2019-07-14T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (9, N'SmtpServer', N'smtp.163.com', CAST(N'2019-07-14T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (14, N'SmtpUserName', N'15538568732@163.com', CAST(N'2019-07-14T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (15, N'SmtpPassword', N'mvc666', CAST(N'2019-07-14T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[T_Settings] ([Id], [Name], [Value], [CreateDateTime], [IsDeleted]) VALUES (17, N'SmtpEmail', N'15538568732@163.com', CAST(N'2019-07-14T00:00:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Settings] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Users] ON 
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (1, N'15538568732', N'B5D4BAA2069A3B298DF35A1A884FF9DA', N'nfxkk', 0, NULL, NULL, CAST(N'2019-05-21T17:16:19.547' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (2, N'15538568711', N'69C0195DE4842FD1E37E6BC5688FA435', N'tecxt', 0, NULL, NULL, CAST(N'2019-06-11T16:27:42.397' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (3, N'13608668833', N'0DDE6A968FEF2C2342AF56D33B651FBA', N'feshr', 0, NULL, NULL, CAST(N'2019-07-04T16:42:50.207' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (4, N'15538568722', N'05D0ED089DAA271BB885C8C937DDDAF5', N'meyyf', 0, NULL, NULL, CAST(N'2019-07-22T20:22:18.267' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (5, N'15538568733', N'86BEFE6537080FE5502E0DA1DC14A4BD', N'dcnfs', 0, NULL, NULL, CAST(N'2019-09-23T16:47:34.680' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (6, N'15838808712', N'ADDBCB1A47754F55D70A6D57379B995E', N'chkxd', 0, NULL, NULL, CAST(N'2019-09-25T08:41:33.250' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (7, N'13838878365', N'FF0B9FDD850FE9BAF24553B1DAB2AA78', N'ryhrt', 0, NULL, NULL, CAST(N'2019-09-27T17:22:50.497' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (8, N'13839912876', N'D5CD783058B92714300C30F71863A781', N'tdwts', 0, NULL, NULL, CAST(N'2019-10-23T22:28:48.067' AS DateTime), 0)
GO
INSERT [dbo].[T_Users] ([Id], [PhoneNum], [PasswordHash], [PasswordSalt], [LoginErrorTimes], [LastLoginErrorDateTime], [CityId], [CreateDateTime], [IsDeleted]) VALUES (9, N'16823683662', N'57AC4E2C5A52C6A2962CA46292EF4C29', N'tmdhs', 0, NULL, NULL, CAST(N'2020-03-21T11:00:02.690' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[T_Users] OFF
GO
ALTER TABLE [dbo].[T_AdminLogs]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_AdminLogs_dbo.T_AdminUsers_AdminUserId] FOREIGN KEY([AdminUserId])
REFERENCES [dbo].[T_AdminUsers] ([Id])
GO
ALTER TABLE [dbo].[T_AdminLogs] CHECK CONSTRAINT [FK_dbo.T_AdminLogs_dbo.T_AdminUsers_AdminUserId]
GO
ALTER TABLE [dbo].[T_AdminUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_AdminUserRoles_dbo.T_AdminUsers_AdminUserId] FOREIGN KEY([AdminUserId])
REFERENCES [dbo].[T_AdminUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_AdminUserRoles] CHECK CONSTRAINT [FK_dbo.T_AdminUserRoles_dbo.T_AdminUsers_AdminUserId]
GO
ALTER TABLE [dbo].[T_AdminUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_AdminUserRoles_dbo.T_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[T_Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_AdminUserRoles] CHECK CONSTRAINT [FK_dbo.T_AdminUserRoles_dbo.T_Roles_RoleId]
GO
ALTER TABLE [dbo].[T_AdminUsers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_AdminUsers_dbo.T_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[T_Cities] ([Id])
GO
ALTER TABLE [dbo].[T_AdminUsers] CHECK CONSTRAINT [FK_dbo.T_AdminUsers_dbo.T_Cities_CityId]
GO
ALTER TABLE [dbo].[T_Communities]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Communities_dbo.T_Regions_RegionId] FOREIGN KEY([RegionId])
REFERENCES [dbo].[T_Regions] ([Id])
GO
ALTER TABLE [dbo].[T_Communities] CHECK CONSTRAINT [FK_dbo.T_Communities_dbo.T_Regions_RegionId]
GO
ALTER TABLE [dbo].[T_HouseAppointments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_HouseAppointments_dbo.T_AdminUsers_FollowAdminUserId] FOREIGN KEY([FollowAdminUserId])
REFERENCES [dbo].[T_AdminUsers] ([Id])
GO
ALTER TABLE [dbo].[T_HouseAppointments] CHECK CONSTRAINT [FK_dbo.T_HouseAppointments_dbo.T_AdminUsers_FollowAdminUserId]
GO
ALTER TABLE [dbo].[T_HouseAppointments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_HouseAppointments_dbo.T_Houses_HouseId] FOREIGN KEY([HouseId])
REFERENCES [dbo].[T_Houses] ([Id])
GO
ALTER TABLE [dbo].[T_HouseAppointments] CHECK CONSTRAINT [FK_dbo.T_HouseAppointments_dbo.T_Houses_HouseId]
GO
ALTER TABLE [dbo].[T_HouseAppointments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_HouseAppointments_dbo.T_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[T_Users] ([Id])
GO
ALTER TABLE [dbo].[T_HouseAppointments] CHECK CONSTRAINT [FK_dbo.T_HouseAppointments_dbo.T_Users_UserId]
GO
ALTER TABLE [dbo].[T_HouseAttachments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_HouseAttachments_dbo.T_Attachments_AttachmentId] FOREIGN KEY([AttachmentId])
REFERENCES [dbo].[T_Attachments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_HouseAttachments] CHECK CONSTRAINT [FK_dbo.T_HouseAttachments_dbo.T_Attachments_AttachmentId]
GO
ALTER TABLE [dbo].[T_HouseAttachments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_HouseAttachments_dbo.T_Houses_HouseId] FOREIGN KEY([HouseId])
REFERENCES [dbo].[T_Houses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_HouseAttachments] CHECK CONSTRAINT [FK_dbo.T_HouseAttachments_dbo.T_Houses_HouseId]
GO
ALTER TABLE [dbo].[T_HousePics]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_HousePics_dbo.T_Houses_HouseId] FOREIGN KEY([HouseId])
REFERENCES [dbo].[T_Houses] ([Id])
GO
ALTER TABLE [dbo].[T_HousePics] CHECK CONSTRAINT [FK_dbo.T_HousePics_dbo.T_Houses_HouseId]
GO
ALTER TABLE [dbo].[T_Houses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Houses_dbo.T_Communities_CommunityId] FOREIGN KEY([CommunityId])
REFERENCES [dbo].[T_Communities] ([Id])
GO
ALTER TABLE [dbo].[T_Houses] CHECK CONSTRAINT [FK_dbo.T_Houses_dbo.T_Communities_CommunityId]
GO
ALTER TABLE [dbo].[T_Houses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_DecorateStatusId] FOREIGN KEY([DecorateStatusId])
REFERENCES [dbo].[T_IdNames] ([Id])
GO
ALTER TABLE [dbo].[T_Houses] CHECK CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_DecorateStatusId]
GO
ALTER TABLE [dbo].[T_Houses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_RoomTypeId] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[T_IdNames] ([Id])
GO
ALTER TABLE [dbo].[T_Houses] CHECK CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_RoomTypeId]
GO
ALTER TABLE [dbo].[T_Houses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_StatusId] FOREIGN KEY([StatusId])
REFERENCES [dbo].[T_IdNames] ([Id])
GO
ALTER TABLE [dbo].[T_Houses] CHECK CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_StatusId]
GO
ALTER TABLE [dbo].[T_Houses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_TypeId] FOREIGN KEY([TypeId])
REFERENCES [dbo].[T_IdNames] ([Id])
GO
ALTER TABLE [dbo].[T_Houses] CHECK CONSTRAINT [FK_dbo.T_Houses_dbo.T_IdNames_TypeId]
GO
ALTER TABLE [dbo].[T_Regions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Regions_dbo.T_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[T_Cities] ([Id])
GO
ALTER TABLE [dbo].[T_Regions] CHECK CONSTRAINT [FK_dbo.T_Regions_dbo.T_Cities_CityId]
GO
ALTER TABLE [dbo].[T_RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_RolePermissions_dbo.T_Permissions_PermissionId] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[T_Permissions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_RolePermissions] CHECK CONSTRAINT [FK_dbo.T_RolePermissions_dbo.T_Permissions_PermissionId]
GO
ALTER TABLE [dbo].[T_RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_RolePermissions_dbo.T_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[T_Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_RolePermissions] CHECK CONSTRAINT [FK_dbo.T_RolePermissions_dbo.T_Roles_RoleId]
GO
ALTER TABLE [dbo].[T_Users]  WITH CHECK ADD  CONSTRAINT [FK_dbo.T_Users_dbo.T_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[T_Cities] ([Id])
GO
ALTER TABLE [dbo].[T_Users] CHECK CONSTRAINT [FK_dbo.T_Users_dbo.T_Cities_CityId]
GO
USE [master]
GO
ALTER DATABASE [RentHouse] SET  READ_WRITE 
GO
