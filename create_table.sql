--DROP TABLE "dev"."public"."departments"
--DROP TABLE "dev"."public"."hired_employees"
--DROP TABLE "dev"."public"."jobs"

CREATE TABLE "dev"."public"."departments"
(
  id   INTEGER NOT NULL,
  department  VARCHAR(100) NOT NULL
);

CREATE TABLE "dev"."public"."hired_employees"
(
  id   INTEGER NOT NULL,
  name  VARCHAR(100) NOT NULL,
  datetime VARCHAR(100) NOT NULL,
  department_id INTEGER ,
  job_id INTEGER 
);

CREATE TABLE "dev"."public"."jobs"
(
  id   INTEGER NOT NULL,
  job  VARCHAR(100) NOT NULL
);