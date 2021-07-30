CREATE PROCEDURE dbo.usp_WriteXMLFile @XML      XML, 
                                      @FilePath NVARCHAR(200),
									  @NameFile NVARCHAR(100)
AS
    BEGIN
        SET NOCOUNT ON;
        IF(OBJECT_ID('tempdb..##XML') IS NOT NULL)
            DROP TABLE ##XML;
        CREATE TABLE ##XML(XMLHolder XML);
        INSERT INTO ##XML(XMLHolder)
               SELECT @XML;
        DECLARE @cmd TABLE
        (name         NVARCHAR(35), 
         minimum      INT, 
         maximum      INT, 
         config_value INT, 
         run_value    INT
        );
        DECLARE @run_value INT;
        EXECUTE master.dbo.sp_configure 'show advanced options', 1;
        RECONFIGURE;
        INSERT INTO @cmd (name, minimum, maximum, config_value, run_value)
        EXECUTE sp_configure 'xp_cmdshell';
        SELECT @run_value = run_value
        FROM @cmd;
        IF @run_value = 0
            BEGIN
                EXEC sp_configure 
                     'xp_cmdshell', 
                     1;
                RECONFIGURE;
            END;
        DECLARE @SQL NVARCHAR(300)= '';
        SET @SQL = 'bcp ##XML out "' + @FilePath + '\' + @NameFile + '_' + FORMAT(GETDATE(), N'yyyyMMdd_hhmmss') + '.xml" -S "' + @@SERVERNAME + '" -T -c';                 
        EXECUTE master..xp_cmdshell @SQL;
        IF @run_value = 0
            BEGIN                               
                EXECUTE sp_configure 'xp_cmdshell', 0;
                RECONFIGURE;
            END;
        IF(OBJECT_ID('tempdb..##XML') IS NOT NULL)
            DROP TABLE ##XML;
        SET NOCOUNT OFF;
    END;
	GO


	DECLARE @x XML;
	SET @x = (SELECT 
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
FOR XML PATH, ELEMENTS)

exec usp_WriteXMLFile @x, 'C:\TEMP\Curso', 'Category';
