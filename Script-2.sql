SELECT title_id || ' precio: ' || price FROM titles t 

SELECT fname, job_desc, pub_name, state, country
	FROM employee e, jobs j, publishers p 
	WHERE e.job_id = j.job_id 
		AND e.pub_id = p.pub_id
		AND state = 'CA'
		
		
	/*La información de publicaciones vendidas reside en la tabla Sales. Liste las filas de
		ventas correspondientes al mes de Junio de cualquier año. */
		
SELECT * FROM sales s 
		
SELECT EXTRACT ('year' FROM ord_date) "year", sum(qty) FROM sales s
	WHERE EXTRACT('MONTH' FROM ord_date) = '09'
	GROUP BY EXTRACT ('year' FROM ord_date)
	
INSERT INTO sales 
	VALUES ('7067', 'D4422', '18/09/1989', 150, 'Net 60','PS2091')
	
SELECT title, pub_name FROM titles t , publishers p
	WHERE t.pub_id = p.pub_id 
	
	
SELECT T.title, P.pub_name
 FROM Titles T INNER JOIN Publishers P
 ON T.pub_id = P.pub_id

 SELECT job_id, count(*) FROM employee
 	GROUP BY job_id
 	
 	
 SELECT j.job_desc, count(*) 
 	FROM employee e INNER JOIN jobs j
 		ON e.job_id = j.job_id
 	GROUP BY j.job_desc 
 	
 	
 SELECT t."type", avg(t.price) "precio_prom" FROM titles t
 GROUP BY t."type" 
 HAVING avg(t.price)>12 
 
 SELECT e.fname, e.lname FROM employee e
 	WHERE e.hire_date >= ALL (SELECT hire_date FROM employee)
 
 
 SELECT fname, hire_date FROM employee
 ORDER BY hire_date desc
 
 
 SELECT p.pub_name FROM publishers p 
 	WHERE p.pub_id IN (SELECT t.pub_id FROM titles t
 						WHERE t.TYPE='business')
 						
 SELECT DISTINCT p.pub_name FROM publishers p INNER JOIN	titles t ON p.pub_id = t.pub_id 
 	WHERE t.type = 'business'
 	
 SELECT t.title FROM titles t 
 	WHERE t.title_id NOT IN (SELECT s.title_id FROM sales s WHERE s.ord_date NOT BETWEEN '1993-01-01' and '1994-12-31')
 	
 SELECT titles.title_id, title
 FROM titles INNER JOIN sales
 ON titles.title_id = sales.title_id
 WHERE YEAR(sales.ord_date) NOT IN (1993, 1994) 
	
 SELECT * FROM sales s 
 
 SELECT t.title, p.pub_name, t.price FROM titles t INNER JOIN publishers p ON t.pub_id = p.pub_id
 	WHERE t.price < (SELECT avg(price) FROM titles t1 where t1.pub_id = p.pub_id)
  	ORDER BY p.pub_name DESC
 	
 	
 	SELECT avg(price) FROM titles t INNER JOIN publishers p ON t.pub_id = p.pub_id
 		GROUP BY p.pub_id
 		
 SELECT * FROM publishers p2 
 
 
 
 SELECT a.au_fname, a.au_lname, 
 	CASE a.contract 
 		WHEN 1 THEN 'Si'
 		ELSE 'No'
 		END	"Posee contrato?"
 FROM authors a 
 WHERE a.state = 'CA' AND a.contract = 1
 ORDER BY a.au_fname DESC 
 
 
 SELECT e.lname, CASE
 	WHEN e.job_lvl > 200 THEN '>200'
 	WHEN e.job_lvl > 100 THEN '>100>'
 	ELSE '<100'
 	END puntaje
 		
 FROM employee e 
 
 
 CREATE OR REPLACE FUNCTION obPrecio
 	(
 		codPub Varchar(6)
 	)
 	RETURNS float
 	AS 
 	$$
 		DECLARE 
 			precio float;
 		BEGIN 
	 		precio := (SELECT price FROM titles
	 			WHERE title_id = codPub);
	 		RAISE NOTICE 'this %', precio;
 			RETURN precio;
 		END;
 		
 	$$
 	LANGUAGE plpgsql
 
 	SELECT obPrecio	('PS1372')
 	
 	
 	
 	CREATE OR REPLACE FUNCTION fechVenta
 		(
 			idStor char(4),
 			ordNum varchar(20)
 		)
 		
 		RETURNS date
 		
 		AS
 		
 		$$
 		DECLARE	
 			fech date;
 			BEGIN
 				fech := (SELECT DISTINCT  s.ord_date FROM sales s
 							WHERE s.stor_id =idStor AND s.ord_num = ordNum );
 				RETURN fech;
 			END;
 			
 		$$
 		
 		LANGUAGE plpgsql
INSERT INTO productos
	VALUES (20, 'Articulo 2', 70, 40) 
	
	 	
	
	CREATE  OR REPLACE FUNCTION buscarPrecio
	(
		cod int,
		OUT precio float
	)
	RETURNS float
	
	AS
	
	$$
		DECLARE	
		BEGIN
			precio := (SELECT p.precunit FROM productos p WHERE p.codprod = cod);
			RETURN;
		END;
		
	$$
	LANGUAGE plpgsql

	
	DROP FUNCTION insertardetalle(int4, int4, int4, int4) 
	
	
	CREATE OR REPLACE FUNCTION insertarDetalle
 		(
 			codDetalle int,
 			numPed int,
 			codProducto int,
 			cant int
 		)
 		
 		RETURNS void
 		
 		AS
 		
 		$$
 		DECLARE	
 			preciotot float;
 			BEGIN
	 			IF NOT EXISTS (SELECT codprod FROM productos WHERE codprod = codProducto) THEN
	 				RAISE NOTICE 'No existe producto';
	 			END IF;
	 				RETURN;
	 			SELECT buscarPrecio (codprod) INTO preciotot;
 				INSERT INTO detalle
 				values(codDetalle, numPed, codProducto, cant, preciotot*cant);
 			END;
 			
 		$$
 		
 		LANGUAGE plpgsql
 		
	SELECT insertarDetalle (1,1,11,10)
 	SELECT * FROM detalle 
 	
 	
 	
 	CREATE OR REPLACE FUNCTION ajustarPrecio()
 		RETURNS void
 		AS 
 		$$
 			DECLARE 
 				rTitle RECORD;
 			BEGIN
 				FOR rTitle IN SELECT title_id, pub_id, price FROM Titles LOOP
	 				IF rTitle.pub_id = '0736' THEN
	 					IF rTitle.price <= 10 THEN
	 						UPDATE titles SET price = price*1.25
	 							WHERE title_id = rTitle.title_id;
	 						ELSE
	 							UPDATE titles SET price = price*0.75
	 							WHERE title_id = rTitle.title_id;
	 					END IF;
	 				END IF;
 				END LOOP;
 			RETURN;
 			END
 			
 		$$
 		LANGUAGE plpgsql
 		
 		
 		SELECT title, price FROM titles
		WHERE pub_id = '0736'
		
	 SELECT ajustarPrecio()
 	
	 
	 ------------------------------
 	
	 CREATE TYPE Mensaje
 		AS (
 			columna1 VARCHAR(255)
 		); 

	 
	 CREATE OR REPLACE FUNCTION mismaCiudad()
	 	RETURNS SETOF Mensaje
	 	AS
	 	$$
	 		
	 		DECLARE 
	 			cadena Mensaje%ROWTYPE;
	 			autor RECORD;
	 			editorial RECORD;
	 		
	 		BEGIN 
		 		cadena.columna1 := ' ';
	 			FOR autor IN SELECT DISTINCT a.au_lname, ta.title_id, a.city
	 							FROM authors a, titleauthor ta
	 							WHERE a.au_id = ta.au_id LOOP
		 							
		 			-----
		 				FOR editorial IN SELECT p.city 
		 						FROM titles t, publishers p
		 						WHERE t.pub_id = p.pub_id 
		 						AND t.title_id = autor.title_id LOOP 
		 							
			 						IF autor.city = editorial.city THEN
			 							cadena.columna1 := 'El autor: ' || autor.au_lname || ' reside en la misma ciudad que la editorial que lo edita';
			 							RETURN NEXT cadena;
			 						END IF;
			 						
		 						END LOOP;
		 						
		 			
	 				-----
	 			END LOOP;
	 			RETURN ;
	 		
	 		END;
	 		
	 	
	 	$$
	 	LANGUAGE plpgsql
	 	
	 
 	SELECT mismaCiudad()	
 	
 	SELECT * FROM authors a 
 	SELECT * FROM titleauthor t 
 		ORDER BY au_id 

 	SELECT * FROM employee WHERE job_id = 5
 	
 	CREATE TABLE titles2(
 		id int2,
 		price float
 	)
 	
 	
 	CREATE OR REPLACE FUNCTION aTriggerProcedure()
 		RETURNS TRIGGER 
 		AS 
 		$$
 		DECLARE 
 		BEGIN 
	 		IF NEW.price > 500 THEN 
	 			RETURN NULL;
	 		ELSE IF NEW.price > 250 THEN
	 			NEW.price = 525;
	 			END IF;
	 		END IF;
	 		RETURN new;
 		END
 		
 		$$
 		LANGUAGE plpgsql
 	
 	
 	CREATE OR REPLACE TRIGGER aTrigger
 		BEFORE 
 		UPDATE OF price ON titles2
 		FOR EACH ROW 
 		EXECUTE PROCEDURE aTriggerProcedure();
	 	

 	
 	INSERT INTO titles2 values(23, 221)
 	UPDATE titles2 SET price = 520 WHERE id = 23
 	
 	SELECT * FROM titles2
 	
 	
 	