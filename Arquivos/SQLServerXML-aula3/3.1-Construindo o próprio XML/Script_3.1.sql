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
FOR XML AUTO, ELEMENTS;

SELECT 
Category.Name as "Caregory/CategoryName"
,SubCategory.Name as "Caregory/SubCategory/SubCategoryName"
,Product.ProductNumber as "Caregory/SubCategory/Product/@ProductNumber"
,Product.ListPrice as "Caregory/SubCategory/Product/@Price"
,Product.Name as "Caregory/SubCategory/Product/ProductName"
FROM Production.Product Product
INNER JOIN Production.ProductSubcategory SubCategory ON
Product.ProductSubcategoryID = SubCategory.ProductSubcategoryID
INNER JOIN Production.ProductCategory Category ON
Category.ProductCategoryID = SubCategory.ProductCategoryID
WHERE Product.ListPrice > 0
AND Product.SellEndDate IS NULL
FOR XML PATH, ELEMENTS;

