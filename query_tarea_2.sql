--Q1
WITH empleados_con_trimestre AS (
  SELECT 
    he.id,
    dep.department,
    jb.job,
    DATE_PART(quarter, TO_DATE(he.datetime, 'YYYY-MM-DD')) AS trimestre
  FROM "dev"."public"."hired_employees" he
  LEFT JOIN departments dep ON he.department_id = dep.id
  LEFT JOIN jobs jb ON he.job_id = jb.id
  where he.datetime between timestamp '2021-01-01' AND timestamp '2022-01-01'
)
SELECT 
  department,
  job,
  COUNT(CASE WHEN trimestre = 1 THEN 1 END) AS q1,
  COUNT(CASE WHEN trimestre = 2 THEN 1 END) AS q2,
  COUNT(CASE WHEN trimestre = 3 THEN 1 END) AS q3,
  COUNT(CASE WHEN trimestre = 4 THEN 1 END) AS q4
FROM empleados_con_trimestre
GROUP BY department, job
ORDER BY department, job;

--Q2

with total_emp_2021 as (
    SELECT 
        department_id,
        COUNT(*) AS total_empleados
    FROM "dev"."public"."hired_employees"
    where datetime between timestamp '2021-01-01' AND timestamp '2022-01-01'
    GROUP BY department_id
)
, media_emp_2021 as (
    SELECT
        AVG(total_empleados) AS media_emp
    FROM total_emp_2021
)
SELECT 
    dep.id,
    dep.department,
    tep.total_empleados as hired
FROM total_emp_2021 tep
JOIN "dev"."public"."departments" dep
  ON tep.department_id = dep.id
JOIN media_emp_2021 mep
  ON tep.total_empleados > mep.media_emp
ORDER BY tep.total_empleados DESC;
