IF DB_ID('db1264996') IS NULL
	CREATE DATABASE db1264996
USE Book_Information
GO
CREATE TABLE Publishers
(
   PublisherID INT PRIMARY KEY,
   PublisherName NVARCHAR(30) NOT NULL
)
GO
CREATE TABLE Genres
(
    GenreID INT PRIMARY KEY,
	GenreName NVARCHAR(30) NOT NULL
)
GO
CREATE TABLE Books
(
   bookID INT PRIMARY KEY,
   Title NVARCHAR(30) NOT NULL,
   GenreID INT NOT NULL REFERENCES Genres(GenreID),
   Price MONEY NOT NULL,
   PublishDate DATE NOT NULL,
   PublisherID INT NOT NULL REFERENCES Publishers(PublisherID)
)
GO
CREATE TABLE Authors
(
   AuthorID INT PRIMARY KEY,
   AuthorName NVARCHAR(40) NOT NULL,
   Aaddress NVARCHAR(70) NOT NULL
)
GO
CREATE TABLE BookAuthors
(
   AuthorID INT NOT NULL REFERENCES Authors(AuthorID),
   bookID INT NOT NULL REFERENCES Books(bookID),
   PRIMARY KEY(AuthorID, bookID)
)
GO
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
	CustomerName NVARCHAR(30) NOT NULL
)
GO
CREATE TABLE Sales 
(
   SaleID INT PRIMARY KEY,
   CustomerID INT NOT NULL REFERENCES Customers(CustomerID),
   SalesDate DATE NOT NULL
)
GO
CREATE TABLE SaleDetails
(
   SaleID INT NOT NULL REFERENCES Sales(SaleID),
   bookID INT NOT NULL REFERENCES Books(bookID),
   NumberOfBook INT NOT NULL,
   PRIMARY KEY(SaleID,bookID)
)
GO
SELECT * FROM Publishers
Go
-------DDL Statment-----
CREATE PROC spInsertPublishers @pn NVARCHAR(30)
AS
DECLARE @id INT
SELECT @id = ISNULL(MAX(PublisherID), 0)+1 FROM Publishers
BEGIN TRY INSERT INTO Publishers(PublisherID, PublisherName)
           VALUES(@id, @pn)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO

----insert Proc Generes----
CREATE PROC spInsertGenres @gn NVARCHAR(30)
AS
DECLARE @id INT
SELECT @id = ISNULL(MAX(GenreID), 0)+1 FROM Genres
BEGIN TRY INSERT INTO Genres(GenreID, GenreName)
           VALUES(@id, @gn)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM Genres
Go

----inser Proc books----

CREATE PROC spInsertBooks @id INT,
                          @t NVARCHAR(30),
						  @gid INT,
						  @p MONEY,
						  @Pd DATE,
						  @pid INT

AS
SELECT @id = ISNULL(MAX(bookID), 0)+1 FROM Books
BEGIN TRY INSERT INTO Books(bookID, Title, GenreID, Price, PublishDate, PublisherID)
           VALUES(@id,@t, @gid, @p, @Pd, @pid)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM Books
Go
 ----insert proc Athors---

CREATE PROC spInsertAuthors @id INT,
                            @an NVARCHAR(40),
						    @aad NVARCHAR(70)				    
AS
SELECT @id = ISNULL(MAX(AuthorID), 0)+1 FROM Authors
BEGIN TRY INSERT INTO Authors(AuthorID, AuthorName, Aaddress)
           VALUES(@id,@an,@aad)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM Authors
GO

----insert Proc BooksAuthors----

CREATE PROC spInsertBookAuthors @aid INT,
                                @bid INT				        				    
AS
SELECT @aid = ISNULL(MAX(AuthorID), 0)+1 FROM BookAuthors
BEGIN TRY INSERT INTO BookAuthors(AuthorID, bookID)
           VALUES(@aid, @bid)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM BookAuthors
GO

----insert Proc Customers----

CREATE PROC spInsertCustomers @id INT,
                              @cn NVARCHAR(30)					    			    
AS
SELECT @id = ISNULL(MAX(CustomerID), 0)+1 FROM Customers
BEGIN TRY INSERT INTO Customers(CustomerID, CustomerName)
           VALUES(@id, @cn)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM Customers
GO

----insert Proc Sales---

CREATE PROC spInsertSales @id INT,
                          @cid INT,
						  @sd DATE				    
AS
SELECT @id = ISNULL(MAX(SaleID), 0)+1 FROM Sales
BEGIN TRY INSERT INTO Sales(SaleID, CustomerID, SalesDate)
           VALUES(@id, @cid, @sd)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM Sales
GO

----insert Proc SaleDetails---

CREATE PROC spInsertSaleDetails @id INT,
                                @bid INT,
						        @nb INT			    
AS
SELECT @id = ISNULL(MAX(SaleID), 0)+1 FROM SaleDetails
BEGIN TRY INSERT INTO SaleDetails(SaleID, bookID, NumberOfBook)
           VALUES(@id, @bid, @nb)
END TRY
BEGIN CATCH
     DECLARE @msg NVARCHAR(1000)
	 SELECT @msg = ERROR_MESSAGE()
	 ;
	 THROW 50001, @msg, 1
END CATCH
GO
SELECT * FROM SaleDetails
GO

-----Update Procidure---
CREATE PROC spUdateBooks @id INT,
						 @p MONEY,
						 @Pd DATE
AS
BEGIN TRY 
      UPDATE Books 
	  SET   Price = @p, PublishDate = @Pd
	  WHERE bookID = @id
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO

-----Update Proc Publishers----

CREATE PROC spUdatePublishers @id INT,
                              @pn NVARCHAR(30)
AS
BEGIN TRY 
      UPDATE Publishers 
	  SET  PublisherName = @pn
	  WHERE PublisherID = @id
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO

-----Update Proc Genres----

CREATE PROC spUdateGenres @id INT,
                          @gn NVARCHAR(30)
AS
BEGIN TRY 
      UPDATE Genres 
	  SET  GenreName = @gn
	  WHERE GenreID = @id
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO


-----Update Proc Publishers----


CREATE PROC spUdatePublishers @id INT,
                              @pn NVARCHAR(30)
AS
BEGIN TRY 
      UPDATE Publishers 
	  SET  PublisherName = @pn
	  WHERE PublisherID = @id
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO

-----Update Proc Authors----


CREATE PROC spUdateAuthors @aid INT,
                           @an NVARCHAR(40),
						   @aAdd NVARCHAR(70)
AS
BEGIN TRY 
      UPDATE Authors 
	  SET  AuthorName = @an, Aaddress = @aAdd
	  WHERE AuthorID = @aid
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO


-----Update Proc BookAuthors----

CREATE PROC spUdateBookAuthors @aid INT,
                               @bid INT
AS
BEGIN TRY 
      UPDATE BookAuthors 
	  SET  bookID = @bid
	  WHERE AuthorID = @aid
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO

-----Update Proc Customers----

CREATE PROC spUdateCustomers @id INT,
                             @cn NVARCHAR(30)
AS
BEGIN TRY 
      UPDATE Customers 
	  SET  CustomerName = @cn
	  WHERE CustomerID = @id
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO

-----Update Proc Sales----

CREATE PROC spUdateSales @sid INT,
                         @cid INT,
						 @sdate DATE
AS
BEGIN TRY 
      UPDATE Sales 
	  SET  CustomerID = @cid, SalesDate = @sdate
	  WHERE SaleID = @sid
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO


-----Update Proc SaleDetails----

CREATE PROC spUdateSaleDetails @sid INT,
							   @nob INT
AS
BEGIN TRY 
      UPDATE SaleDetails 
	  SET NumberOfBook = @nob
	  WHERE SaleID = @sid
END TRY
BEGIN CATCH
	 ;
	 THROW 50002, 'Update Faild', 1
END CATCH
GO
SELECT * FROM SaleDetails
GO

----Delete Procidure-----
CREATE PROC spDeletePublishers @id INT
AS
BEGIN TRY
      DELETE Publishers
	  WHERE PublisherID = @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO

----Delete proc Genres----

CREATE PROC spDeleteGenres @id INT                         
AS
BEGIN TRY
      DELETE Genres
	  WHERE GenreID = @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO


---Delete Proc Books---

CREATE PROC spDeleteBooks @id INT
AS
BEGIN TRY
      DELETE Books
	  WHERE bookID = @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO

----Delete Proc Authors----

CREATE PROC spDeleteAuthors @id INT
AS
BEGIN TRY
      DELETE Authors
	  WHERE  AuthorID= @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO

----Delete Proc BookAuthors----

CREATE PROC spDeleteBookAuthors @id INT
AS
BEGIN TRY
      DELETE BookAuthors
	  WHERE  AuthorID= @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO

----Delete Proc Customers----

CREATE PROC spDeleteCustomers @id INT
AS
BEGIN TRY
      DELETE Customers
	  WHERE  CustomerID= @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO

----Delete Proc Sales---

CREATE PROC spDeleteSales @id INT
AS
BEGIN TRY
      DELETE Sales
	  WHERE  SaleID= @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO

----Delete Proc SalesDetails----

CREATE PROC spDeleteSaleDetails @id INT
AS
BEGIN TRY
      DELETE SaleDetails
	  WHERE SaleID= @id
END TRY
BEGIN CATCH
         ;
		 THROW 50001, 'Can''t deleted', 1
END CATCH
GO


----Create Function---

--Scalar UDF
 --Books published in a particular year
CREATE FUNCTION fnBooksPublished(@year INT) RETURNS INT
AS
BEGIN
    DECLARE @c INT 
	SELECT @c = COUNT(*) FROM Books
	WHERE YEAR(PublishDate) = @year
	RETURN @c
END
GO

------DataType Return Function----

CREATE FUNCTION fnSalesInfo(@sid INT) RETURNS INT
AS
BEGIN
    DECLARE @c INT 
	SELECT @c = COUNT(*) FROM Sales
	WHERE SaleID = @sid
	RETURN @c
END
GO

------DataType Return Function----

CREATE FUNCTION fnCustomerInfo(@cid INT) RETURNS INT
AS
BEGIN
    DECLARE @c INT 
	SELECT @c = COUNT(*) FROM Customers
	WHERE CustomerID = @cid
	RETURN @c
END
GO
------DataType Return Function----

CREATE FUNCTION fnAuthorsInfo(@aid INT) RETURNS INT
AS
BEGIN
    DECLARE @c INT 
	SELECT @c = COUNT(*) FROM Authors
	WHERE AuthorID = @aid
	RETURN @c
END
GO
------Table Function----

CREATE FUNCTION fnBooksInfo(@bk NVARCHAR(30)) RETURNS TABLE
AS
RETURN
(
 SELECT b.bookID,ba.AuthorID,a.AuthorName, b.Title, b.PublishDate, b.Price,
       s.SalesDate, sd.NumberOfBook,a.Aaddress
 FROM Sales s 
 INNER JOIN SaleDetails sd ON s.SaleID=sd.SaleID
 INNER JOIN  Books b ON sd.bookID =b.bookID
 INNER JOIN BookAuthors ba ON b.bookID=ba.bookID
 INNER JOIN Authors a ON ba.AuthorID = a.AuthorID
)
GO
CREATE FUNCTION fnSalesDetailsInfo(@gn NVARCHAR(30)) RETURNS TABLE
AS
RETURN
(
 SELECT g.GenreID,g.GenreName, p.PublisherName, b.PublishDate, b.Price
 FROM Genres g
 INNER JOIN Books b ON g.GenreID=b.GenreID
 INNER JOIN Publishers p ON b.PublisherID=p.PublisherID
)
GO


--*********-Create Insert Tigger---**************

CREATE TRIGGER trInsertBook
ON Books
FOR INSERT 
AS
BEGIN
    DECLARE @pd DATE
	SELECT @pd = PublishDate FROM inserted
	IF CAST(@pd AS DATE)< CAST(GETDATE() AS DATE)
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

---Create InsertTrigger Publishers----

CREATE TRIGGER trInsertPublisher
ON Publishers
FOR INSERT 
AS
BEGIN
    DECLARE @pn NVARCHAR(30)
	SELECT @pn = PublisherName FROM inserted
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

---Create InsertTrigger Sales----

CREATE TRIGGER trInsertSale
ON Sales
FOR INSERT 
AS
BEGIN
    DECLARE @sd DATE
	SELECT @sd = SalesDate FROM inserted
	IF CAST(@sd AS DATE)> CAST(GETDATE() AS DATE)
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

---Create InsertTrigger Authors----

CREATE TRIGGER trInsertAuthore
ON Authors
FOR INSERT 
AS
BEGIN
    DECLARE @ad NVARCHAR(70)
	SELECT @ad = Aaddress FROM inserted
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

---Create InsertTrigger Genres----

CREATE TRIGGER trInsertGenre
ON Genres
FOR INSERT 
AS
BEGIN
    DECLARE @gn NVARCHAR(30)
	SELECT @gn = GenreName FROM inserted
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

---Create InsertTrigger BookAuthors----

CREATE TRIGGER trInsertBookAuthore
ON BookAuthors
FOR INSERT 
AS
BEGIN
    DECLARE @bid INT
	SELECT @bid = bookID FROM inserted
	IF(@bid>450)
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

---Create InsertTrigger SaleDetails----

CREATE TRIGGER trInsertSaleDetails
ON SaleDetails
FOR INSERT 
AS
BEGIN
    DECLARE @nob INT
	SELECT @nob = NumberOfBook FROM inserted
	IF(@nob>1000)
	BEGIN
	    RAISERROR('Invalid data', 11, 1)
		ROLLBACK Transaction
	END
END
GO

--**********---CREATE Delete Trigger---**************--

CREATE TRIGGER trDeleteBooks
ON Books
AFTER DELETE
AS
BEGIN
    IF @@ROWCOUNT > 1
	BEGIN
	    PRINT 'Can''t delete more then 1 at a time'
		ROLLBACK Transaction 
	END 
END
GO

-----Dlete Trigger Authors------

CREATE TRIGGER trAuthorDelete
ON Authors
AFTER DELETE 
AS
BEGIN 
    DECLARE @id INT 
	SELECT @id =AuthorID  FROM deleted 
	IF EXISTS (SELECT 1 FROM BookAuthors WHERE AuthorID=@id)
	BEGIN
	    ROLLBACK Transaction 
		RAISERROR ('Author has dependedent book. Delete them frist', 16, 1)
		RETURN
	END
END
GO

-----Dlete Trigger Sales------

CREATE TRIGGER teDeleteSales
ON Sales 
FOR DELETE
AS
BEGIN
    DECLARE @sd DATE
	SELECT @sd = SalesDate FROM deleted
	IF @sd IS NOT NULL
	BEGIN 
	    ROLLBACK Transaction
		RAISERROR ('Already delivered order, action cencelled.', 11, 1)
	END
END
GO

-----Dlete Trigger Publishers------

CREATE TRIGGER teDeletePublishers
ON Publishers 
FOR DELETE
AS
BEGIN
    DECLARE @pn NVARCHAR(30)
	SELECT  @pn = PublisherName FROM deleted
	IF @pn IS NOT NULL
	BEGIN 
	    ROLLBACK Transaction
		RAISERROR ('Already delivered order, action cencelled.', 11, 1)
	END
END
GO

-----Dlete Trigger Genres------

CREATE TRIGGER teDeleteGenres
ON Genres 
FOR DELETE
AS
BEGIN
    DECLARE @gid INT
	SELECT  @gid = GenreID FROM deleted
	IF @gid IS NOT NULL
	BEGIN 
	    ROLLBACK Transaction
		RAISERROR ('Already delivered order, action cencelled.', 11, 1)
	END
END
GO

-----Dlete Trigger SaleDetails------

CREATE TRIGGER teDeleteSaleDetails
ON SaleDetails 
FOR DELETE
AS
BEGIN
    DECLARE @sid INT
	SELECT  @sid = SaleID FROM deleted
	IF @sid IS NOT NULL
	BEGIN 
	    ROLLBACK Transaction
		RAISERROR ('Already delivered order, action cencelled.', 11, 1)
	END
END
GO

-----Dlete Trigger BookAuthors------

CREATE TRIGGER teDeleteBookAuthors
ON BookAuthors
FOR DELETE
AS
BEGIN
    DECLARE @aid INT
	SELECT  @aid = AuthorID FROM deleted
	IF @aid IS NOT NULL
	BEGIN 
	    ROLLBACK Transaction
		RAISERROR ('Already delivered order, action cencelled.', 11, 1)
	END
END
GO


-----Dlete Trigger Customers------
CREATE TRIGGER teDeleteCustomers
ON Customers
FOR DELETE
AS
BEGIN
    DECLARE @cid INT
	SELECT  @cid = CustomerID FROM deleted
	IF @cid IS NOT NULL
	BEGIN 
	    ROLLBACK Transaction
		RAISERROR ('Already delivered order, action cencelled.', 11, 1)
	END
END
GO



--****---Create View---******

CREATE VIEW vBooksBypublisher 
AS 
 (SELECT b.bookID, b.Title, b.Price, p.PublisherName, b.PublishDate
  FROM Books b
  INNER JOIN Publishers p ON b.PublisherID = p.PublisherID
 )
GO

----Create View BooksBySaleDetails----

CREATE VIEW vBooksBySaleDetails 
AS 
 (SELECT b.Title, b.Price, b.PublishDate, s.NumberOfBook
  FROM Books b
  INNER JOIN SaleDetails s ON b.bookID= s.bookID
 )
GO

-----Create View BooksByBookAuthors-----

CREATE VIEW vBooksByBookAuthors
AS
  SELECT bk.bookID, bk.AuthorID, b.Title, b.Price
  FROM Books b
  INNER JOIN BookAuthors bk ON b.bookID = bk.bookID
GO



----Create View BooksByGenres------

CREATE VIEW vBooksByGenres
AS
  SELECT b.GenreID, g.GenreName, b.Price
  FROM Books b
  INNER JOIN Genres g ON b.GenreID = g.GenreID
GO
SELECT * FROM vBooksByGenres
GO

CREATE VIEW vCustomerBysaleInfo
AS
  (SELECT c.CustomerID, s.SaleID, c.CustomerName, sd.NumberOfBook, s.SalesDate 
  FROM Customers c
  INNER JOIN Sales s ON c.CustomerID= s.CustomerID
  INNER JOIN SaleDetails sd ON s.SaleID = sd.SaleID)
GO



----CREATE CTE---

WITH CTE AS
(
  SELECT bookID, Title, Price, PublishDate
  FROM Books 
)
SELECT CTE.bookID, sd.SaleID, CTE.Title, CTE.Price, CTE.PublishDate, sd.NumberOfBook
FROM SaleDetails sd
INNER JOIN CTE ON sd.bookID= CTE.bookID
GO

-----Create CTE as bi----
WITH bi AS
(
  SELECT bookID, Title, GenreID, Price, PublishDate, PublisherID
  FROM  Books b
)
SELECT a.AuthorID, ba.bookID, a.AuthorName, bi.PublishDate, bi.Price
FROM Authors a
INNER JOIN BookAuthors ba ON a.AuthorID = ba.AuthorID
INNER JOIN bi ON ba.bookID=bi.bookID
GO


---Create CTE as Cus-----
WITH Cus AS
 (
   SELECT CustomerID, CustomerName
   FROM Customers
 )
SELECT * 
FROM SaleDetails sd 
INNER JOIN Sales s ON sd.SaleID = s.SaleID
INNER JOIN Cus ON s.CustomerID = Cus.CustomerID
GO

-----Create CTE as Au----
WITH Au AS
 (
   SELECT AuthorID, AuthorName, Aaddress
   FROM Authors 
 )
SELECT Au.AuthorID, ba.bookID, Au.AuthorName, Au.Aaddress 
FROM BookAuthors ba
INNER JOIN Au ON ba.AuthorID = Au.AuthorID
GO


----Create CTE As CTE----
WITH CTE AS
(
   SELECT bookID, Title, Price, PublishDate, GenreID
   FROM Books
)
SELECT g.GenreID, g.GenreName, CTE.Title, CTE.PublishDate
FROM Genres g
INNER JOIN CTE ON g.GenreID = CTE.GenreID
GO

---Create Sub-query---
SELECT sub.*
FROM (SELECT b.bookID,a.AuthorID, b.Title, a.AuthorName, s.SalesDate, 
                  Count(s.SaleID) 'Total sale'
      FROM Authors a
	  INNER JOIN BookAuthors ba ON a.AuthorID= ba.AuthorID
	  INNER JOIN Books b ON ba.bookID= b.bookID
	  INNER JOIN SaleDetails sd ON b.bookID=sd.bookID
	  INNER JOIN Sales s ON sd.SaleID= s.SaleID
	  GROUP BY b.bookID,a.AuthorID, b.Title, a.AuthorName, s.SalesDate
	  ) as sub
WHERE sub.[Total sale] > 1

GO


