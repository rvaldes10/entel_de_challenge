COPY departments 
FROM 's3://testing-dataengineer/post-stage/departments/departments_processed.csv' 
DELIMITER '|' 
REGION 'us-east-1'
IGNOREHEADER 1
IAM_ROLE default

COPY jobs 
FROM 's3://testing-dataengineer/post-stage/jobs/jobs_processed.csv' 
DELIMITER '|' 
REGION 'us-east-1'
IGNOREHEADER 1
IAM_ROLE default

COPY hired_employees 
FROM 's3://testing-dataengineer/post-stage/hired_employees/hired_employees_processed.csv' 
DELIMITER '|' 
REGION 'us-east-1'
IGNOREHEADER 1
IAM_ROLE default