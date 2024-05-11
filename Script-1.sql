
CREATE TABLE Ventas (
	codVent INT IDENTITY(1,1) NOT NULL,
	fechaVent DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	usuarioDB VARCHAR(30) NOT NULL DEFAULT USER,
	monto FLOAT NULL
	)
	
	INSERT INTO Ventas (monto)
	VALUES	(21.2)
	
	
	SELECT TOP 5 * FROM titles 
	
	
	SELECT title_id + ' precio: $' + CONVERT (varchar ,price) FROM titles
		WHERE pubdate BETWEEN '01/01/1990' AND '12/31/1991'
		
	SELECT title_id, title  FROM titles WHERE title LIKE '%valley'
	
	SELECT T.title, P.pub_name
 FROM Titles T INNER JOIN Publishers P
 ON T.pub_id = P.pub_id

 SELECT *
 FROM publishers RIGHT JOIN titles
 ON publishers.pub_id = titles.pub_id
 
 SELECT a.au_lname, a.au_fname, t.title 
 	FROM authors a INNER JOIN titleauthor ta
 		ON a.au_id = ta.au_id
 	INNER JOIN titles t
 		ON ta.title_id = t.title_id 
 	ORDER BY a.au_lname 
 		
 SELECT p.pub_name, e.fname +' '+e.lname 'Empleado', job_lvl  FROM publishers p INNER JOIN employee e 
 	ON p.pub_id = e.pub_id 
 	WHERE job_lvl > 200
 		
 	
 SELECT a.au_lname, a.au_fname, sum(s.qty)*t.price 'ingresos' FROM authors a  INNER JOIN titleauthor ta 
 	ON a.au_id = ta.au_id INNER JOIN  titles t
 	ON ta.title_id = t.title_id INNER JOIN sales s 
 	ON t.title_id = s.title_id 
 	GROUP BY a.au_lname, a.au_fname, t.price 
 	ORDER BY 'ingresos' DESC
 	
 	
 	 SELECT a.au_lname, a.au_fname, sum(s.qty*t.price) 'ingresos' FROM authors a  INNER JOIN titleauthor ta 
 	ON a.au_id = ta.au_id INNER JOIN  titles t
 	ON ta.title_id = t.title_id INNER JOIN sales s 
 	ON t.title_id = s.title_id 
 	GROUP BY a.au_lname, a.au_fname 
 	ORDER BY 'ingresos' DESC
 	
  SELECT a.au_lname, a.au_fname, sum(s.qty), t.price  FROM authors a  INNER JOIN titleauthor ta 
 	ON a.au_id = ta.au_id INNER JOIN  titles t
 	ON ta.title_id = t.title_id INNER JOIN sales s 
 	ON t.title_id = s.title_id 
 	GROUP BY a.au_lname, a.au_fname, t.price 
 	

 	
ALTER  PROCEDURE obtenerPrecio
	(
		@codPub varchar(6),
		@precioPub float = 0 OUTPUT  
	)
	AS
		SET @precioPub = (SELECT price FROM titles WHERE title_id = @codPub)
		PRINT 'precio ' + CONVERT (varchar, @precioPub)
		RETURN @precioPub
 
ALTER  PROCEDURE obtenerPrecio
	(
		@codPub varchar(6)
	)
	AS
		RETURN (SELECT price FROM titles WHERE title_id = @codPub)
		
		
		DECLARE	@precio float;
		SET	@precio = EXEC obtenerPrecio @codPub = 'PS1372'
		
		SELECT t.title_id FROM titles t 
		WHERE t.price =	@precio
		
		
		
		
		DECLARE cTitles CURSOR 
			FOR 
				SELECT price
					FROM titles
					WHERE pub_id = '0736'
					FOR UPDATE OF price
		
		DECLARE @precio float
					
		OPEN cTitles
		
		FETCH NEXT
			FROM cTitles
			INTO @precio
		
		WHILE @@fetch_status = 0
			BEGIN
				IF @precio <= 10
					UPDATE titles 
						SET price = price*1.25
						WHERE CURRENT  OF cTitles
				IF @precio > 10
					UPDATE titles 
						SET price = price*0.75
						WHERE CURRENT  OF cTitles
				
				FETCH NEXT
					FROM cTitles
					INTO @precio
			
			END
			
			
		CLOSE cTitles
		DEALLOCATE cTitles
		
		SELECT * FROM titles
		
		SELECT title, price FROM titles
		WHERE pub_id = '0736'
		
		
		
		DECLARE curTypes CURSOR FOR
			SELECT DISTINCT TYPE FROM Titles
		
		DECLARE @tipo char(14)
			
		OPEN curTypes
		FETCH NEXT
			FROM curTypes
			INTO @tipo
		
		DECLARE
				@precio float,
				@max1 float = 0,
				@max2 float = 0,
				@max3 float = 0
				
		WHILE @@fetch_status = 0
			BEGIN
				-------
				DECLARE cPrices CURSOR FOR
					SELECT price FROM titles 
						WHERE type = @tipo
				
				OPEN cPrices
				FETCH NEXT
					FROM cPrices
					INTO @precio
				
				WHILE @@fetch_status = 0
					BEGIN
						
						IF @precio > @max1
							BEGIN
								SET @max3 = @max2
								SET @max2 = @max1
								SET @max1 = @precio
							END
						ELSE IF	@precio > @max2
							BEGIN
								SET @max3 = @max2
								SET @max2 = @precio
							END
						ELSE IF @precio > @max3
							SET @max3 = @precio
						
							
						FETCH NEXT
							FROM cPrices
							INTO @precio
					END
					CLOSE cPrices
					DEALLOCATE cPrices
		
				-------
				
				PRINT 'Publicaciones más caras de tipo ' + @tipo
					PRINT '---------------'
					PRINT ''
					IF @max1 != 0
						PRINT @max1
					ELSE	
						PRINT 'NULL'
					IF @max2 != 0
						PRINT @max2
					ELSE	
						PRINT 'NULL'
					IF @max3 != 0
						PRINT @max3
					ELSE	
						PRINT 'NULL'
					
					PRINT ''
					
				SET @max1 = 0
				SET @max2 = 0
				SET @max3 = 0
				
				FETCH NEXT
					FROM curTypes
					INTO @tipo
			
			END
			CLOSE curTypes
			DEALLOCATE curTypes
			
			
----------------------
	
	DECLARE curPub CURSOR FOR 
		SELECT t.pub_id, t.price*s.qty   FROM titles t INNER JOIN sales s
			ON t.title_id = s.title_id
			ORDER BY pub_id
	
	DECLARE 
		@currentPub char(4),
		@currentMoney float = 0,
		@pub char(4),
		@money float,
		@minPub1 char(4),
		@minMoney1 float = 10000000, ---ultimo
		@minPub2 char(4),
		@minMoney2 float = 100000000  ---anteultimo
			
	OPEN curPub
	FETCH NEXT
		FROM curPub
		INTO @pub, @money
	
	SET @currentPub = @pub	
	---------- min ---------
	WHILE @@fetch_status = 0
		BEGIN
			IF @pub != @currentPub 
				BEGIN
					IF @currentMoney < @minMoney1
						BEGIN
							SET @minMoney2 = @minMoney1
							SET @minPub2 = @minPub1
							SET @minMoney1 = @currentMoney
							SET @minPub1 = @currentPub
						END	
					ELSE IF @currentMoney < @minMoney2
						BEGIN 
							SET @minMoney2 = @currentMoney
							SET @minPub2 = @currentPub
						END
					SET @currentPub = @pub
					SET @currentMoney = 0
				
				END 
	
			
			SET @currentMoney = @currentMoney + @money
			
			
			FETCH NEXT
				FROM curPub
				INTO @pub, @money		
		END
		CLOSE curPub
		DEALLOCATE curPub
		PRINT @minPub1 + ' ' + @minPub2
		
		---------- max ---------
		DECLARE curPub CURSOR FOR 
		SELECT t.pub_id, t.price*s.qty   FROM titles t INNER JOIN sales s
			ON t.title_id = s.title_id
			ORDER BY pub_id
			
		OPEN curPub
		FETCH NEXT
			FROM curPub
			INTO @pub, @money
		
		DECLARE
				@maxPub char(4),
				@maxMoney float = 0
		
				
		SET @currentPub = @pub
		SET @currentMoney = 0
				
		WHILE @@fetch_status = 0
		BEGIN
			IF @pub != @currentPub 
				BEGIN
					IF @currentMoney > @maxMoney
						BEGIN
							SET @maxMoney = @currentMoney
							SET @maxPub = @currentPub
						END 
					SET @currentPub = @pub
					SET @currentMoney = 0
				
				END 
	
			
			SET @currentMoney = @currentMoney + @money
			
			
			FETCH NEXT
				FROM curPub
				INTO @pub, @money		
		END	
		---------
		IF @currentMoney > @maxMoney
						BEGIN
							SET @maxMoney = @currentMoney
							SET @maxPub = @currentPub
						END 
		----------
		CLOSE curPub
		DEALLOCATE curPub
		PRINT @maxPub	
		
		DECLARE curEmp CURSOR FOR
			SELECT p.pub_id, e.emp_id FROM publishers p INNER JOIN employee e 
				ON p.pub_id = e.pub_id
				WHERE e.job_id = 5

		DECLARE
			@empPub char(4),
			@emp char(9),
			@transfer char(9),
			@hired date = GETDATE()
				
		OPEN curEmp
		FETCH NEXT FROM curEmp INTO @empPub, @emp
		WHILE @@fetch_status = 0
			BEGIN
				IF @empPub = @minPub1 OR @empPub = @minPub2
					BEGIN 
						IF @hired > (SELECT hire_date FROM employee
										WHERE emp_id = @emp)
							BEGIN 
								SET @transfer = @emp
								SET @hired = (SELECT hire_date FROM employee
										WHERE emp_id = @emp)
							END
					END
					
				FETCH NEXT FROM curEmp INTO @empPub, @emp
			END
			CLOSE curEmp
			DEALLOCATE curEmp
			PRINT @transfer +' contratado en:'+ CONVERT(varchar, @hired) + ', va a trabajar en ' + @maxPub

	----------------
			
	ALTER PROCEDURE ventasXMES
		(
			@totalSales float = 0 OUTPUT 
		)
		AS 
		BEGIN 
				
			DECLARE curSales CURSOR FOR
				SELECT YEAR (s.ord_date), MONTH (s.ord_date), sum(s.qty*t.price) FROM titles t INNER JOIN sales s
					ON t.title_id = s.title_id
					GROUP BY MONTH(s.ord_date), YEAR(s.ord_date) 
			DECLARE 
			 	---@totalSales float = 0,
				@year int,
				@month int,
				@monthName varchar(20) = 'febrero',
				@net float = 0
			
			OPEN curSales
			FETCH NEXT FROM curSales INTO @year, @month, @net
			
			WHILE @@fetch_status = 0
				BEGIN
					IF @month  = 2 
						SET @monthName = 'february'
					ELSE IF @month = 6
						SET @monthName = 'June'
					ELSE SET @monthName = '???'
					
					PRINT 'Ventas de' + @monthName + ' año ' + CONVERT(varchar, @year) + ' fueron: $' + CONVERT(varchar, @net)
					SET @totalSales  = @totalSales + @net
					PRINT @totalSales
					FETCH NEXT FROM curSales INTO @year, @month, @net
			
				END
				CLOSE curSales
				DEALLOCATE curSales
				RETURN @totalSales
		END
	DECLARE @out float  = 100;
	EXECUTE ventasXMES @out
	PRINT @out
		SELECT lname,
 
SELECT lname,
 CASE
 WHEN job_lvl < 100 THEN 'Puntaje menor que 100'
 WHEN job_lvl < 200 THEN 'Puntaje entre 100 y 200'
 ELSE 'Puntaje mayor que 200'
 END Nivel
 FROM Employee
 ORDER BY 2,1
		
 
 CREATE TABLE test1 (
 	ID int,
 	NAME VARCHAR(40)
 )
 
 CREATE TABLE test1Record(
 	id int IDENTITY(1,1),
 	description varchar(255)
 )
 
 
 
 ALTER  TRIGGER tInsertAuthor
 	ON test1 
 	FOR INSERT 
 	AS
 	DECLARE 
 		@inName varchar(40);
 	BEGIN
	 	SET @inName = (SELECT name FROM inserted);
	 	IF @inName = ''
	 		ROLLBACK TRANSACTION
	 	ELSE  		
	 		INSERT INTO test1Record
	 		VALUES (CONVERT(varchar, CURRENT_TIMESTAMP) + @inName)
 	END
 	
 		
 INSERT INTO test1 VALUES(2, '')
 
 SELECT * FROM test1Record
 
 

 
 