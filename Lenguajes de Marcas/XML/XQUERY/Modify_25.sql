CREATE TABLE xml.T (i int, x xml)
go
INSERT INTO xml.T VALUES(1,'<Root>
<ProductDescription ProductID="1" ProductName="Road Bike">
<Features>
  <Warranty>1 year parts and labor</Warranty>
  <Maintenance>3 year parts and labor extended maintenance is available</Maintenance>
</Features>
</ProductDescription>
</Root>')
go
-- verify the contents before delete
SELECT x.query(' //ProductDescription/Features')
FROM xml.T
-- delete the second feature
UPDATE xml.T
SET x.modify('delete /Root/ProductDescription/Features/*[2]')

-- verify the deletion
SELECT x.query(' //ProductDescription/Features')
FROM xml.T