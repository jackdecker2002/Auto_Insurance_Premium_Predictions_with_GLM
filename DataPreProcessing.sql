-- SQLite

-- Phase 1: Explore background information on the dataset

-- Find the number of columns
SELECT COUNT(*)
FROM pragma_table_info('RawData');
-- Output: 39

-- Find the number of rows
SELECT COUNT(*)
FROM RawData;
-- Output: 1000

-- Count the number of rows where "capital-gains" is greater than 25000
SELECT COUNT(*) AS "capital-gains"
FROM RawData
WHERE "capital-gains" > 25000;
-- Output 468

-- Find duplicate policy_bind_date entries
SELECT policy_bind_date, COUNT(*) AS cnt
FROM RawData
GROUP BY policy_bind_date
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
-- Output: There is three dates with 3 entries and many with 2 entries

-- I want to know how many entries of 3 and entries of 2 there are
SELECT dup_count, COUNT(*) AS num_ids
FROM (
    SELECT policy_bind_date, COUNT(*) AS dup_count
    FROM RawData
    GROUP BY policy_bind_date
    HAVING COUNT(*) > 1
) AS sub
GROUP BY dup_count
ORDER BY dup_count;
-- Output: Doubles: 43, Triples: 3

-- Retrieve all the rows with triples and doubles in order
SELECT r.rowid, r.*, d.dup_count
FROM RawData r
JOIN (
    SELECT policy_bind_date, COUNT(*) AS dup_count
    FROM RawData
    GROUP BY policy_bind_date
    HAVING COUNT(*) > 1
) d ON r.policy_bind_date = d.policy_bind_date
ORDER BY d.dup_count DESC, r.policy_bind_date, r.rowid;
-- Output: Table with all rows having triples then doubles

-- Find duplicates insured_occupation entries
SELECT insured_occupation, COUNT(*) AS cnt
FROM RawData
GROUP BY insured_occupation
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
-- Output: Sorted table with the leaders being machine-op-inspct, prof-specialty, and tech-support

-- Find duplicates insured_hobbies entries
SELECT insured_hobbies, COUNT(*) AS cnt
FROM RawData
GROUP BY insured_hobbies
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
-- Output: Sorted table with the leaders being reading, exercise, and paintball

-- Phase 2: Aggregate queries

-- Sort by Policies, Insureds, Incidents, Claims, and Vehicles

CREATE TABLE policies AS
SELECT DISTINCT
    policy_number,
    policy_bind_date,
    policy_state,
    policy_csl,
    policy_deductable,
    policy_annual_premium,
    umbrella_limit,
    months_as_customer
FROM RawData;

CREATE TABLE insureds AS
SELECT DISTINCT
    policy_number,
    age,
    insured_zip,
    insured_sex,
    insured_education_level,
    insured_income,
    insured_occupation,
    insured_hobbies
FROM RawData;

CREATE TABLE incidents AS
SELECT DISTINCT
    incident_id,
    incident_date,
    incident_type,
    incident_description,
    incident_severity
FROM RawData;

CREATE TABLE claims AS
SELECT DISTINCT
    claim_id,
    claim_date,
    claim_amount,
    claim_status,
    claim_description
FROM RawData;

CREATE TABLE vehicles AS
SELECT DISTINCT
    vehicle_id,
    vehicle_make,
    vehicle_model,
    vehicle_year,
    vehicle_type
FROM RawData;
