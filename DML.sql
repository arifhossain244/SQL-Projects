USE Book_Information
GO

     --*********---Insert Procidure---***********

---------insert proc Publishers---
EXEC spInsertPublishers 201, 'AB Prokasoni'
GO 
EXEC spInsertPublishers 202, 'Alarafa Prokasoni'
GO
EXEC spInsertPublishers 203, 'Popy Publication'
GO
EXEC spInsertPublishers 204, 'Lacture Publication'
GO

SELECT * FROM Publishers
GO

----insert proc Genres---
EXEC spInsertGenres 301, 'Genre1'
GO
EXEC spInsertGenres 302, 'Genre2'
GO
EXEC spInsertGenres 303, 'Genre6'
GO
EXEC spInsertGenres 304, 'Genre3'
GO
EXEC spInsertGenres 305, 'Genre2'
GO

SELECT * FROM Genres
GO

----insert proc Books---
EXEC spInsertBooks 401, 'Concepts Of IT', 301, 270.00, '2021-01-22',201
GO
EXEC spInsertBooks 402, 'SQL developer', 305, 470.00, '2018-01-22',204
GO
EXEC spInsertBooks 403, 'Visual C#', 302, 524.00, '2018-01-22',202
GO
EXEC spInsertBooks 404, 'Discredite Mathmatics', 304, 204.00, '2018-01-22',203
GO
EXEC spInsertBooks 405, 'Java', 305, 369.50, '2019-05-02',204
GO

SELECT * FROM Books
GO

----insert proc Authors---
EXEC spInsertAuthors 501, 'Angel-Merin', 'Canada in city'
GO
EXEC spInsertAuthors 502, 'Brayan Syverson', 'USA'
GO
EXEC spInsertAuthors 503, 'John Sharp', 'UK'
GO
EXEC spInsertAuthors 504, 'Jewlan Akowz', 'Canada'
GO
EXEC spInsertAuthors 505, 'Saif Akowz', 'Canada in city'
GO

SELECT * FROM Authors 
GO

----insert proc BookAuthors---
EXEC spInsertBookAuthors 501, 401 
GO
EXEC spInsertBookAuthors 501, 404 
GO
EXEC spInsertBookAuthors 502, 402 
GO
EXEC spInsertBookAuthors 503, 403 
GO
EXEC spInsertBookAuthors 504, 401 
GO
EXEC spInsertBookAuthors 504, 405 
GO
EXEC spInsertBookAuthors 502, 403 
GO
EXEC spInsertBookAuthors 505, 404 
GO

SELECT * FROM BookAuthors
GO

----insert proc Customers---
EXEC spInsertCustomers 6601, 'Arif Hossain' 
GO
EXEC spInsertCustomers 6602, 'Shuvo' 
GO
EXEC spInsertCustomers 6603, 'Ekhtekhar Alam' 
GO
EXEC spInsertCustomers 6604, 'Ajjaj Ahmed' 
GO
EXEC spInsertCustomers 6605, 'Abdullah' 
GO

SELECT * FROM Customers
GO

----insert proc Sale---
EXEC spInsertSales 711, 6605, '2021-06-26'
GO
EXEC spInsertSales 712, 6601, '2021-06-22'
GO
EXEC spInsertSales 713, 6602, '2021-06-23'
GO
EXEC spInsertSales 714, 6603, '2021-06-18'
GO
EXEC spInsertSales 715, 6604, '2021-06-17'
GO

SELECT * FROM Sales
GO

----insert proc SaleDetails---

EXEC spInsertSaleDetails 711, 401, 120
GO
EXEC spInsertSaleDetails 712, 403, 420
GO
EXEC spInsertSaleDetails 713, 402, 205
GO
EXEC spInsertSaleDetails 714, 405, 150
GO
EXEC spInsertSaleDetails 715, 404, 310
GO

SELECT * FROM SaleDetails
GO

------ update Book using spUdateBooks--

EXEC spUdateBooks @id=401, @p=270.00, @pd='2021-01-21'
EXEC spUdateBooks @id=405, @p=469.00, @pd='2019-05-05'

SELECT * FROM Books

---update Authors usign spUdateAuthors---

EXEC spUdateAuthors @aid = 501, @an = 'Angel-Merin', @aAdd ='Canada'
EXEC spUdateAuthors @aid = 504, @an = 'Jewlan Akowz', @aAdd ='USA'

SELECT * FROM Authors

---update Publishers usign spUdateBookAuthors---

EXEC spUdatePublishers 201, 'AB Publication'
EXEC spUdatePublishers 202, 'Alarafa Publication'

SELECT * FROM Publishers


---update Genres usign spUdateGenres---
EXEC spUdateGenres @id=304, @gn=Genre4
EXEC spUdateGenres @id=305, @gn=Genre5

SELECT * FROM Genres

---update Customers usign spUdateCustomers---

EXEC spUdateCustomers 6605, [Abdullah Bin Mamun]
EXEC spUdateCustomers 6602, [Arif Hasan Shuvo]

SELECT * FROM Customers

---update SaleDetails usign spUdateSaleDetails---
EXEC spUdateSaleDetails 711, 125
EXEC spUdateSaleDetails 712, 433
EXEC spUdateSaleDetails 715, 317

SELECT * FROM SaleDetails 


                   ---Delete Procidure---

-----Publishers using spDeletePublishers---
EXEC spDeletePublishers 201 

SELECT * FROM Publishers

-----Genres using spDeleteGenres---
EXEC spDeleteGenres 301, Genre1

SELECT * FROM Genres

EXEC spDeleteBooks 404

SELECT * FROM Books


-----Books  using spDeleteBooks---
EXEC spDeleteBooks 401
  
SELECT * FROM Books 

-----Authors  using spDeleteAuthors---

EXEC spDeleteAuthors 505
 
 SELECT * FROM Authors

-----BookAuthors  using spDeleteBookAuthors---

EXEC spDeleteBookAuthors 

-----Customers  using spDeleteCustomers---
EXEC spDeleteCustomers 6604


SELECT * FROM Customers


-----Sales   using spDeleteSales---

EXEC spDeleteSales 715

SELECT * FROM Sales 

-----SaleDetails using spDeleteSaleDetails---
EXEC spDeleteSaleDetails 715

SELECT * FROM SaleDetails

--------------FUNCTIONS-----------------
--fnBooksPublished for a year 
SELECT  dbo.fnBooksPublished (2018)
GO
SELECT  dbo.fntrInsertGenre ('Genre7')
GO
SELECT * FROM Genres
--Test Tigger


     --View
SELECT * FROM vBooksBypublisher
GO

SELECT * FROM vBooksBySaleDetails
GO

SELECT * FROM vBooksByBookAuthors
GO

SELECT * FROM vBooksByGenres
GO

SELECT * FROM vCustomerBysaleInfo
GO

