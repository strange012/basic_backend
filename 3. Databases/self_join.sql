SELECT emp.employee_id, emp.last_name, emp.manager_id, mng.last_name
FROM   employees emp, employees mng
WHERE  emp.manager_id = mng.employee_id
