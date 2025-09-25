public class SalaryUpdater {
    public int updateSalary(List<Employee> employees, int deptId, double incrementPercent) {
        int updatedCount = 0;
        for (Employee emp : employees) {
            if (emp.getDepartmentId() == deptId) {
                double newSalary = emp.getSalary() + (emp.getSalary() * incrementPercent / 100);
                emp.setSalary(newSalary);
                emp.setLastUpdated(LocalDateTime.now());
                updatedCount++;
            }
        }
        return updatedCount;
    }
}