DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID="2" ProductName="Road Bike">
    <Features>
      <Maintenance> 3 anos de manutenção serão estendidas ao produto </Maintenance>
    </Features>    
  </ProductDescription>
</Root>';

SET @XMLDoc.modify ('insert
                    if (/Root/ProductDescription[@ProductID="1"]) then (attribute ProducModel{"Mountain-100"})
					else (attribute ProducModel{"Road-150"})
					into (/Root/ProductDescription/Features/Maintenance)[1]');

SELECT @XMLDoc;