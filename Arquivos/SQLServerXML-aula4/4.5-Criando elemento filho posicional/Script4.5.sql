DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID ="1" ProductName ="Road Bike">
    <Features>
    </Features>    
  </ProductDescription>
</Root>';

SET @XMLDoc.modify('insert <Warranty> Garantia de 3 anos </Warranty> as first
                    into (/Root/ProductDescription/Features)[1]');

SET @XMLDoc.modify('insert <Material> Alumínio </Material> as last
                    into (/Root/ProductDescription/Features)[1]');

SET @XMLDoc.modify('insert <Color> Prata </Color> after
                    (/Root/ProductDescription/Features/Material)[1]');

SET @XMLDoc.modify('insert <BikeFrame> Reforçado </BikeFrame> before
                    (/Root/ProductDescription/Features/Warranty)[1]');

SELECT @XMLDoc;