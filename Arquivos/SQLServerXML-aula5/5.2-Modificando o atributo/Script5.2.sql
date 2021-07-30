
DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID="1" ProductName="Road Bike">
    <Features>
      <Warranty> Garantia de 3 anos </Warranty>
      <Material> Alumínio </Material>
      <Color> Prata </Color>
      <BikeFrame> Reforçado </BikeFrame>
    </Features>    
  </ProductDescription>
</Root>';

SET @XMLDoc.modify('replace value of (/Root/ProductDescription/@ProductName)[1]
                    with "Mountain Bike"');

SELECT @XMLDoc;