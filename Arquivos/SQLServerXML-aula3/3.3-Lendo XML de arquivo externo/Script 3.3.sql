
DECLARE @x XML;
	SET @x = (SELECT 
Product.Name
,Product.ProductNumber as Number
,Product.ListPrice as Price
FROM Production.Product Product
WHERE Product.ListPrice > 0
AND Product.SellEndDate IS NULL
FOR XML RAW);

exec [dbo].[usp_WriteXMLFile] @x, 'C:\TEMP\Curso', 'Product';

DECLARE @x XML;
	SET @x = (SELECT 
SubCategory.Name as SubCategoryName
,Product.Name
,Product.ProductNumber as Number
,Product.ListPrice as Price
FROM Production.Product Product
INNER JOIN Production.ProductSubcategory SubCategory ON
Product.ProductSubcategoryID = SubCategory.ProductSubcategoryID
WHERE Product.ListPrice > 0
AND Product.SellEndDate IS NULL
FOR XML RAW);

exec [dbo].[usp_WriteXMLFile] @x, 'C:\TEMP\Curso', 'SubCategory';

CREATE PROCEDURE dbo.usp_LoadXMLFromFile @FilePath NVARCHAR(100)
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @cmd TABLE
        (name         NVARCHAR(35), 
         minimum      INT, 
         maximum      INT, 
         config_value INT, 
         run_value    INT
        );
        DECLARE @run_value INT;               
        -- Save original configuration set                 
        INSERT INTO @cmd
        (name, 
         minimum, 
         maximum, 
         config_value, 
         run_value
        )
        EXEC sp_configure 
             'xp_cmdshell';
        SELECT @run_value = run_value
        FROM @cmd;
        IF @run_value = 0
            BEGIN
                EXEC sp_configure 
                     'xp_cmdshell', 
                     1;
                RECONFIGURE;
            END;
        IF NOT EXISTS
        (
            SELECT *
            FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[_XML]')
                  AND type IN(N'U')
        )
            CREATE TABLE dbo._XML
            (ID          INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, 
             XMLFileName NVARCHAR(300), 
             XML_LOAD    XML, 
             Created     DATETIME
            );
            ELSE
            TRUNCATE TABLE dbo._XML;
        DECLARE @DOS NVARCHAR(300)= N'', @DirBaseLocation NVARCHAR(500), @FileName NVARCHAR(300), @SQL NVARCHAR(1000)= N'';
        DECLARE @files TABLE
        (tID     INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
         XMLFile NVARCHAR(300)
        );
        SET @DirBaseLocation = IIF(RIGHT(@FilePath, 1) = '\', @FilePath, @FilePath + '\');
        SET @DOS = 'dir /B /O:-D ' + @DirBaseLocation;
        INSERT INTO @files(XMLFile)
        EXEC master..xp_cmdshell 
             @DOS;
        IF @run_value = 0
            BEGIN
                EXECUTE sp_configure 
                        'xp_cmdshell', 
                        0;
                RECONFIGURE;
            END;
        DECLARE cur CURSOR
        FOR SELECT XMLFile
            FROM @files
            WHERE XMLFile LIKE '%.xml';
        OPEN cur;
        FETCH NEXT FROM cur INTO @FileName;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                BEGIN TRY
                    SET @SQL = 'INSERT INTO _XML SELECT ''' + @DirBaseLocation + @FileName + ''', X, GETDATE() FROM OPENROWSET(BULK N''' + @DirBaseLocation + @FileName + ''', SINGLE_BLOB) as tempXML(X)';
                    EXECUTE sp_executesql 
                            @SQL;
                    FETCH NEXT FROM cur INTO @FileName;
                END TRY
                BEGIN CATCH
                    SELECT @SQL, 
                           ERROR_MESSAGE();
                END CATCH;
            END;
        CLOSE cur;
        DEALLOCATE cur;
        SET NOCOUNT OFF;
    END; 
	GO


	exec usp_LoadXMLFromFile 'C:\Temp\Curso';

	SELECT * FROM _XML;













