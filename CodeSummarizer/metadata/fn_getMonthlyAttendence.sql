CREATE FUNCTION dbo.fn_GetMonthlyAttendance
(
    @EmployeeID INT,
    @Month INT,
    @Year INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT COUNT(*) AS PresentDays
    FROM Attendance
    WHERE EmployeeID = @EmployeeID
      AND MONTH(Date) = @Month
      AND YEAR(Date) = @Year
      AND IsPresent = 1
)