
--Challenge 7.1 with duplicates
SELECT E.emp_no,E.first_name,E.last_name,T.title,T.from_date,S.salary 
INTO retiring_titles_duplicates
FROM employees as E
INNER JOIN salaries as S ON E.emp_no=S.emp_no
INNER JOIN titles as T on E.emp_no=T.emp_no
WHERE (E.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
       AND (E.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	   AND (E.emp_no) IN (SELECT emp_no FROM public.dept_emp where to_date = '9999-01-01');

--get counts for each title
SELECT count(title), title FROM public.retiring_titles_duplicates
GROUP By title;

--to remove the duplicates, I used a method I usually use for this type
--of problem when using SQL Server, seems to work the same way for postgres.
--I had to write it differently to make it give duplicates as above.
--here I used CTEs. easier to read and faster to process. 
with rt AS
	(SELECT emp_no, first_name, last_name FROM employees where birth_date
		BETWEEN '1952-01-01' AND '1955-12-31'
	 	AND hire_date BETWEEN '1985-01-01' AND '1988-12-31'),
	t as
		(SELECT emp_no, to_date, from_date, title FROM titles 
			where to_date ='9999-01-01')
--Now we just treat the CTEs as tables			
SELECT rt.emp_no, rt.first_name, rt.last_name, t.title, s.salary, t.from_date 
INTO retiring_titles_no_duplicates
FROM rt
INNER JOIN t ON rt.emp_no=t.emp_no
INNER JOIN salaries as s on rt.emp_no=s.emp_no
ORDER BY from_date desc;

--get my counts by title
SELECT count(title), title FROM public.retiring_titles_no_duplicates
GROUP By title;

--create mentor listing of current employees, by current title
--who were born in the year 1965
WITH E AS
	(SELECT emp_no, first_name, last_name FROM employees
		where birth_date BETWEEN '1965-01-01' AND '1965-12-31'),
	
	T as 
	(SELECT emp_no, title, from_date, to_date FROM titles
		WHERE to_date = '9999-01-01')
		
SELECT E.emp_no, E.first_name, E.last_name, T.title, T.from_date, T.to_date
INTO mentor_list
FROM E
INNER JOIN T ON E.emp_no=T.emp_no;


--Get totals for each title
SELECT Count(Title), Title from mentor_list
Group By Title;

		