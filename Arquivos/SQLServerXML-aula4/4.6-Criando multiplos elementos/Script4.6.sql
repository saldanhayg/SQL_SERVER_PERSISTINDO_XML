DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID ="1" ProductName ="Road Bike">
    <Features>
    </Features> � �
  </ProductDescription>
</Root>';

DECLARE @NewElements xml;
SET @NewElements = '<Warranty> Garantia de 3 anos </Warranty>
                    <Material> Alum�nio </Material>
					<Color> Prata </Color>
					<BikeFrame> Refor�ado </BikeFrame>';

SET @XMLDoc.modify('insert sql:variable("@NewElements")
                    into (/Root/ProductDescription/Features)[1]');


SELECT @XMLDoc;