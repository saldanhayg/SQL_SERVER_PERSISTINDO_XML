DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID="1" ProductName="Road Bike">
    <Features>
      <Maintenance> 3 anos de manutenção serão estendidas ao produto </Maintenance>
    </Features>    
  </ProductDescription>
</Root>';

SET @XMLDoc.modify('insert 
                    (attribute ProductModel {"Mountain-100"}, attribute LaborType {"Manual"})
                   into (/Root/ProductDescription/Features/Maintenance)[1]');

SELECT @XMLDoc;