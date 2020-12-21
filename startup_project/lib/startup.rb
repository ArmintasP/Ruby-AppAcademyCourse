require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return true if @salaries.has_key?(title)
        false
    end

    def > (startup)
        return true if self.funding > startup.funding
        false
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise_error
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding >= salaries[employee.title]
            employee.pay(salaries[employee.title])
            @funding -= salaries[employee.title]
        else
            raise_error
        end
    end

    def payday
        @employees.each {|ele| pay_employee(ele)}
    end

    def average_salary
        sum = 0
        @employees.each do |ele|
            sum += @salaries[ele.title]
        end
        sum / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each {} |k, v| @salaries[k] = v if @salaries[k] == nil}
        startup.employees.each {|ele| @employees << ele}
        startup.close
    end

end
