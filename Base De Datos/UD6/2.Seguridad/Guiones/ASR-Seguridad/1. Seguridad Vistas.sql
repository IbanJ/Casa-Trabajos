-- Creación de una vista para poder visualizar los datos de los empleados de 
-- bajo nivel en la jerarquía.
-- Ejemplo de encapsulamiento de la seguridad (filtrar por filas)
CREATE VIEW V_VerDatosEmpleados_NoJefes
AS
   SELECT BusinessEntityID, 
          OrganizationLevel, JobTitle, Gender
   FROM [HumanResources].[Employee]
   WHERE OrganizationLevel > 2

-- Denegamos el permiso SELECT sobre la tabla de empleados
-- (es la tabla subyacente)
use [AdventureWorks2012]
GO
DENY SELECT ON [HumanResources].[Employee] TO [UsuarioASIR2]
GO

-- Consultamos la vista y tenemos éxito
SELECT * FROM V_VerDatosEmpleados_NoJefes

