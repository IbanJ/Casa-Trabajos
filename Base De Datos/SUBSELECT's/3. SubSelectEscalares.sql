SELECT title, price,
       (SELECT AVG(price) FROM titles) as media,
	   price-(SELECT AVG(price) FROM titles)
FROM titles