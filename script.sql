USE [master]
GO
/****** Object:  Database [LibraryManagementSystem]    Script Date: 19.01.2021 22:35:51 ******/
CREATE DATABASE [LibraryManagementSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LibraryManagementSystem', FILENAME = N'C:\Users\ASUS\LibraryManagementSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LibraryManagementSystem_log', FILENAME = N'C:\Users\ASUS\LibraryManagementSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LibraryManagementSystem] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryManagementSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryManagementSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryManagementSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryManagementSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LibraryManagementSystem] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryManagementSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryManagementSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryManagementSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryManagementSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LibraryManagementSystem] SET QUERY_STORE = OFF
GO
USE [LibraryManagementSystem]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [LibraryManagementSystem]
GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK](
	[Book_ID] [int] IDENTITY(1,1) NOT NULL,
	[Book_Name] [varchar](50) NULL,
	[Book_Category] [tinyint] NULL,
	[Book_Author] [int] NULL,
	[Book_Year] [char](4) NULL,
	[Book_Publisher] [varchar](50) NULL,
	[Book_Page] [char](4) NULL,
	[Book_Price] [int] NULL,
	[Book_Stocks] [bit] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Book_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PURCHASE]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PURCHASE](
	[Pr_ID] [int] IDENTITY(1,1) NOT NULL,
	[Pr_Book] [int] NULL,
	[Pr_User] [int] NULL,
	[Pr_Date] [smalldatetime] NULL,
	[Pr_Price] [int] NULL,
 CONSTRAINT [PK_Purchase] PRIMARY KEY CLUSTERED 
(
	[Pr_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[HowManyBooksSold]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[HowManyBooksSold] AS
Select Book_Name, count(Pr_Book) as Count
From BOOK, PURCHASE
where BOOK.Book_ID=PURCHASE.Pr_Book
group by Book_Name
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_Name] [varchar](20) NULL,
	[User_Lastname] [varchar](25) NULL,
	[User_Nickname] [varchar](20) NULL,
	[User_Mail] [varchar](50) NULL,
	[User_Password] [varchar](20) NULL,
	[User_Phone] [varchar](25) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[HowManyBooksBought]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[HowManyBooksBought] AS
Select User_Name, User_Lastname, count(Pr_Book) as BoughtBooks
From USERS, PURCHASE
where USERS.User_ID=PURCHASE.Pr_User
group by User_Name, User_Lastname 
GO
/****** Object:  View [dbo].[HowMuchEarned]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[HowMuchEarned] AS

Select Book_Name,sum(Pr_Price) as TotalPrice
from PURCHASE, BOOK
Where PURCHASE.Pr_Book=BOOK.Book_ID
group by Book_Name
GO
/****** Object:  Table [dbo].[ADMIN]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADMIN](
	[Admin_ID] [int] IDENTITY(1,1) NOT NULL,
	[Admin_Name] [varchar](20) NULL,
	[Admin_Lastname] [varchar](20) NULL,
	[Admin_Mail] [varchar](50) NULL,
	[Admin_Pass] [varchar](25) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[Admin_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AUTHORS]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUTHORS](
	[Author_ID] [int] IDENTITY(1,1) NOT NULL,
	[Author_Name] [varchar](20) NULL,
	[Author_Lastname] [varchar](20) NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[Author_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 19.01.2021 22:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[Category_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Category_Name] [varchar](25) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Category_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_AUTHORS] FOREIGN KEY([Book_Author])
REFERENCES [dbo].[AUTHORS] ([Author_ID])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_BOOK_AUTHORS]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_CATEGORY] FOREIGN KEY([Book_Category])
REFERENCES [dbo].[CATEGORY] ([Category_ID])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_BOOK_CATEGORY]
GO
ALTER TABLE [dbo].[PURCHASE]  WITH CHECK ADD  CONSTRAINT [FK_PURCHASE_BOOK] FOREIGN KEY([Pr_Book])
REFERENCES [dbo].[BOOK] ([Book_ID])
GO
ALTER TABLE [dbo].[PURCHASE] CHECK CONSTRAINT [FK_PURCHASE_BOOK]
GO
ALTER TABLE [dbo].[PURCHASE]  WITH CHECK ADD  CONSTRAINT [FK_PURCHASE_USERS] FOREIGN KEY([Pr_User])
REFERENCES [dbo].[USERS] ([User_ID])
GO
ALTER TABLE [dbo].[PURCHASE] CHECK CONSTRAINT [FK_PURCHASE_USERS]
GO
USE [master]
GO
ALTER DATABASE [LibraryManagementSystem] SET  READ_WRITE 
GO
