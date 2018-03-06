SELECT 1 AS Tag, NULL AS Parent,
    Authors.au_id AS [Autor!1!au_id],
	Authors.au_fname AS [Autor!1!Nombre!element],
	Authors.au_lname AS [Autor!1!Apellido!element],
	NULL AS [Titleauthor!2!Royaltyper],
	NULL AS [Titles!3!Title!element]
FROM Authors
UNION ALL
SELECT 2 AS Tag, 1 AS Parent,
    Authors.au_id,
	au_fname,
	au_lname,
	royaltyper,
NULL
FROM Authors INNER JOIN Titleauthor
ON  Authors.au_id = Titleauthor.au_id
UNION ALL
SELECT 3 AS Tag, 2 AS Parent,
    Authors.au_id,
	au_fname,
	au_lname,
	royaltyper,
	title
FROM Authors INNER JOIN Titleauthor ON Authors.au_id = Titleauthor.au_id
           INNER JOIN Titles ON Titles.title_id = Titleauthor.title_id
ORDER BY [Autor!1!Nombre!element], [Autor!1!Apellido!element],
        [Titleauthor!2!royaltyper], Tag
FOR XML EXPLICIT
