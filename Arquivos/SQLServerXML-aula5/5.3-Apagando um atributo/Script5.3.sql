DECLARE @XMLDoc xml;
SET @XMLDoc = '<Root>
  <ProductDescription ProductID="1" ProductName="Road Bike">
    <Features>
      <Warranty> Garantia de 3 anos </Warranty>
      <Material> Alum�nio </Material>
      <Color> Prata </Color>
      <BikeFrame> Refor�ado </BikeFrame>
    </Features> � �
  </ProductDescription>
</Root>';

SET @XMLDoc.modify('delete (/Root/ProductDescription/@ProductName)[1]');

SELECT @XMLDoc;