--Retirement titles

Select e.emp_no,e.first_name,e.last_name,t.title
into retirement_titles
from employees e
join titles t 
on e.emp_no = t.emp_no
where birth_date between '01-01-1952' and '12-31-1955'
order by e.emp_no;

Select * from retirement_titles

--Unique Titles

Select distinct on (e.emp_no) e.emp_no,e.first_name,e.last_name,t.title
into unique_titles
from employees e
join titles t 
on e.emp_no = t.emp_no
where birth_date between '01-01-1952' and '12-31-1955'
and to_date = '9999-01-01'
order by e.emp_no;

Select count(*) from unique_titles;

--Retiring titles by count

Select title,count(*) as Titlecounts into  retiring_titles

from
(
Select distinct on (e.emp_no) e.emp_no,e.first_name,e.last_name,t.title,t.from_date,t.to_date
from employees e
join titles t 
on e.emp_no = t.emp_no
where birth_date between '01-01-1952' and '12-31-1955'
and to_date = '9999-01-01'
order by e.emp_no)T
group by title
order by Titlecounts desc;

Select * from  retiring_titles;

--Mentorship Eligibility

Select distinct on (e.emp_no) e.emp_no,e.first_name,e.last_name,e.birth_date,de.from_date,de.to_date,t.title
into mentorship_eligibilty
from employees e
join dept_employees de
on e.emp_no = de.emp_no
join titles t
on e.emp_no = t.emp_no
where de.to_date = '9999-01-01'
and e.birth_date between '01-01-1965' and '12-31-1965'
order by e.emp_no;

Select * from mentorship_eligibilty
limit 10;

-- retiring titles by department

Select dept_name,title,count(title)
into retiring_titles_by_department
from
(
Select distinct on (e.emp_no) e.emp_no,e.first_name,e.last_name,t.title,de.dept_no,d.dept_name
from employees e
join titles t 
on e.emp_no = t.emp_no
join dept_employees de
on e.emp_no = de.emp_no
join departments d
on de.dept_no = d.dept_no
where birth_date between '01-01-1952' and '12-31-1955'
and t.to_date = '9999-01-01'
order by e.emp_no
)T
group by 1,2
order by title desc;

--Mentorship eligibility by department

Select dept_name,title,count(title)
into mentorship_by_dept
from
(
Select distinct on (e.emp_no) e.emp_no,e.first_name,e.last_name,e.birth_date,de.from_date,de.to_date,t.title,d.dept_name
from employees e
join dept_employees de
on e.emp_no = de.emp_no
join titles t
on e.emp_no = t.emp_no
join departments d
on de.dept_no = d.dept_no
where de.to_date = '9999-01-01'
and t.to_date ='9999-01-01'
and e.birth_date between '01-01-1965' and '12-31-1965'
order by e.emp_no)T
group by 1,2
order by title desc;

