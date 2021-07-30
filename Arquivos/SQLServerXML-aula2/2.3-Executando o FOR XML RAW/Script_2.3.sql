
SELECT 
Product.Name
,Product.ProductNumber as Number
,Product.ListPrice as Price
FROM Production.Product Product
WHERE Product.ListPrice > 0
AND Product.SellEndDate IS NULL
FOR XML RAW;

SELECT 
SubCategory.Name as SubCategoryName
,Product.Name
,Product.ProductNumber as Number
,Product.ListPrice as Price
FROM Production.Product Product
INNER JOIN Production.ProductSubcategory SubCategory ON
Product.ProductSubcategoryID = SubCategory.ProductSubcategoryID
WHERE Product.ListPrice > 0
AND Product.SellEndDate IS NULL
FOR XML RAW;

SELECT 
Category.Name as CategoryName
,SubCategory.Name as SubCategoryName
,Product.Name
,Product.ProductNumber as Number
,Product.ListPrice as Price
FROM Production.Product Product
INNER JOIN Production.ProductSubcategory SubCategory ON
Product.ProductSubcategoryID = SubCategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory Category ON
Category.ProductCategoryID = SubCategory.ProductCategoryID
WHERE Product.ListPrice > 0
AND Product.SellEndDate IS NULL
FOR XML RAW;