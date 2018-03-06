-- Generamos XML como ELEMENTOS
SELECT 1 AS Tag, NULL AS Parent,
  EmployeeID AS [empleados!1!codigo!element], 
  firstname as [empleados!1!nombre!element],
  city as [empleados!1!ciudad!element]
FROM employees 
FOR XML EXPLICIT

-- Generamos XML como ATRIBUTO para el código
-- del empleado y como ELEMENTOS para
-- el resto de datos
SELECT 1 AS Tag, NULL AS Parent,
  EmployeeID AS [empleados!1!codigo], 
  firstname as [empleados!1!nombre!element],
  city as [empleados!1!ciudad!element]
FROM employees as empleados
FOR XML EXPLICIT

-- Generamos XML como ATRIBUTO para el código
-- del empleado, como ELEMENTO para el nombre
-- y como contenido
SELECT 1 AS Tag, NULL AS Parent,
  EmployeeID AS [empleados!1!codigo], 
  firstname as [empleados!1!nombre!element],
  city as [empleados!1!]
FROM employees as empleados
FOR XML EXPLICIT