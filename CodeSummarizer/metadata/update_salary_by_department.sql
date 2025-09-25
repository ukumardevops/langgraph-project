CREATE PROCEDURE update_salary_by_department (
    IN dept_id INT,
    IN increment_percent DECIMAL(5,2)
)
BEGIN
    DECLARE updated_count INT DEFAULT 0;

    UPDATE employees
    SET salary = salary + (salary * increment_percent / 100),
        last_updated = CURRENT_TIMESTAMP
    WHERE department_id = dept_id;

    SELECT COUNT(*) INTO updated_count
    FROM employees
    WHERE department_id = dept_id;

    SELECT updated_count AS total_updated;
END;