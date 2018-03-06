-- Operaciones de generacion de XML
-- con la opcion EXPLICIT
USE PUBS
go

SELECT 1 AS Tag, NULL AS Parent,
au_id AS [Authors!1!au_id], au_lname as [Authors!1]
FROM authors 
FOR XML EXPLICIT

-- Posibilidad 2
SELECT 1 AS Tag, NULL AS Parent,
au_id AS [Autor!1!codAutor], au_lname as [Autor!1]
FROM authors 
FOR XML EXPLICIT

-- Posibilidad 3
SELECT 1 AS Tag, NULL AS Parent,
au_id AS [Autor!1!codAutor], au_lname as [Autor!1!Apellido]
FROM authors 
FOR XML EXPLICIT

-- Posibilidad 4
SELECT 1 AS Tag, NULL AS Parent,
au_id AS [Autor!1!codAutor], 
au_fname as [Autor!1!Nombre!element], 
au_lname as [Autor!1!Apellido!element]
FROM authors 
FOR XML EXPLICIT
