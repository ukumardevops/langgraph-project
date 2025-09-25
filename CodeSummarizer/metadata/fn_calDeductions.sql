CREATE FUNCTION dbo.fn_CalculateDeductions
(
    @BaseSalary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalDeduction DECIMAL(10,2) = 0

    SELECT @TotalDeduction += (@BaseSalary * Percentage / 100)
    FROM Deductions

    RETURN @TotalDeduction
END