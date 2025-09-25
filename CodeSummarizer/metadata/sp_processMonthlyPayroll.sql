CREATE PROCEDURE dbo.sp_ProcessPayroll
    @Month INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @EmployeeID INT, @BaseSalary DECIMAL(10,2)
    DECLARE @GrossSalary DECIMAL(10,2), @Deductions DECIMAL(10,2), @NetSalary DECIMAL(10,2)
    DECLARE @PresentDays INT, @TotalWorkingDays INT

    -- Assume 22 working days per month (or calculate dynamically if needed)
    SET @TotalWorkingDays = 22

    DECLARE payroll_cursor CURSOR FOR
    SELECT EmployeeID, BaseSalary FROM Employees WHERE IsActive = 1

    OPEN payroll_cursor
    FETCH NEXT FROM payroll_cursor INTO @EmployeeID, @BaseSalary

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Get present days from attendance
        SELECT @PresentDays = PresentDays
        FROM dbo.fn_GetMonthlyAttendance(@EmployeeID, @Month, @Year)

        -- Prorate salary based on attendance
        SET @GrossSalary = (@BaseSalary / @TotalWorkingDays) * @PresentDays

        -- Apply deductions
        SET @Deductions = dbo.fn_CalculateDeductions(@GrossSalary)
        SET @NetSalary = @GrossSalary - @Deductions

        -- Insert payroll record
        INSERT INTO Payroll (EmployeeID, Month, Year, GrossSalary, Deductions, NetSalary, ProcessedDate)
        VALUES (@EmployeeID, @Month, @Year, @GrossSalary, @Deductions, @NetSalary, GETDATE())

        FETCH NEXT FROM payroll_cursor INTO @EmployeeID, @BaseSalary
    END

    CLOSE payroll_cursor
    DEALLOCATE payroll_cursor
END