
DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID ="1" ProductName ="Road Bike">
    <Features>
    </Features> � �
  </ProductDescription>
</Root>';
SET @XMLDoc.modify('insert 
                   <Maintenance> 3 anos de manuten��o ser�o estendidas ao produto </Maintenance> 
                   into (/Root/ProductDescription/Features)[1]');
SELECT @XMLDoc;

