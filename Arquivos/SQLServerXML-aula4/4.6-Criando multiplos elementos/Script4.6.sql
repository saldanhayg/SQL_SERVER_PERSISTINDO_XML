DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID ="1" ProductName ="Road Bike">
    <Features>
    </Features>    
  </ProductDescription>
</Root>';

DECLARE @NewElements xml;
SET @NewElements = '<Warranty> Garantia de 3 anos </Warranty>
                    <Material> Alumínio </Material>
					<Color> Prata </Color>
					<BikeFrame> Reforçado </BikeFrame>';

SET @XMLDoc.modify('insert sql:variable("@NewElements")
                    into (/Root/ProductDescription/Features)[1]');


SELECT @XMLDoc;