


CREATE DATABASE [LibraryManagementSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 

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



CREATE TABLE [dbo].[AUTHORS](
	[Author_ID] [int] IDENTITY(1,1) NOT NULL,
	[Author_Name] [varchar](20) NULL,
	[Author_Lastname] [varchar](20) NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[Author_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

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

CREATE TABLE [dbo].[CATEGORY](
	[Category_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Category_Name] [varchar](25) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Category_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



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


INSERT INTO dbo.AUTHORS(Author_Name, Author_Lastname)
VALUES ('Jules','Verne');
INSERT INTO dbo.AUTHORS(Author_Name, Author_Lastname)
VALUES ('Charles','Dickens');
INSERT INTO dbo.AUTHORS(Author_Name, Author_Lastname)
VALUES ('Halide Edip','Adývar');
INSERT INTO dbo.AUTHORS(Author_Name, Author_Lastname)
VALUES ('Ömer','Seyfettin');

INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Adventure');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Science Fiction');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Fantastic');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Poem');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Theatre');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Child Books');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Action');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Story');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Comedy');
INSERT INTO dbo.CATEGORY(Category_Name)
VALUES ('Academic');



INSERT INTO dbo.BOOK(Book_Name,Book_Category,Book_Author,Book_Year,Book_Publisher,Book_Page,Book_Price)
VALUES ('Tuna Klavuzu',1,1,2015,'Yildiz',250,25);
INSERT INTO dbo.BOOK(Book_Name,Book_Category,Book_Author,Book_Year,Book_Publisher,Book_Page,Book_Price)
VALUES ('Ýki Sehrin Hikayesi',1,2,2018,'Günes',350,20);
INSERT INTO dbo.BOOK(Book_Name,Book_Category,Book_Author,Book_Year,Book_Publisher,Book_Page,Book_Price)
VALUES ('Kaþaðý',8,4,2012,'Yildiz',65,15);


-- /// Kitaplardan Kazanýlan Ücret

update PURCHASE 
set Pr_Price=(select BOOK.Book_Price from BOOK where PURCHASE.Pr_Book=BOOK.Book_ID)



-- Hangi Kitaptan Kaç Para Kazanýldý
Create View [HowMuchEarned] AS

Select Book_Name,sum(Pr_Price) as TotalPrice
from PURCHASE, BOOK
Where PURCHASE.Pr_Book=BOOK.Book_ID
group by Book_Name



-- Hangi Kullanýcý Kaç Kitap Aldý
Create View [HowManyBooksBought] AS
Select User_Name, User_Lastname, count(Pr_Book) as BoughtBooks
From USERS, PURCHASE
where USERS.User_ID=PURCHASE.Pr_User
group by User_Name, User_Lastname 



-- Hangi Kitap Kaç Kere Satýldý
Create View [HowManyBooksSold] AS
Select Book_Name, count(Pr_Book) as Count
From BOOK, PURCHASE
where BOOK.Book_ID=PURCHASE.Pr_Book
group by Book_Name




