class TribeImporter

  def initialize
    @fetcher = TribeFetcher.new    
  end

  def perform
    @fetcher.users.each do |user|
      response = @fetcher.user(user["id"])
      id, email, employee_record, assignment_record = response.values_at("id", "email", "employee_record", "assignment_record")
      department = assignment_record["department"]
      manager_id = assignment_record.fetch("manager", {})["id"]
      
      if assignment_record["job"].any?
        title = assignment_record["job"]["title"]
        first_name, last_name = employee_record.values_at("first_name", "last_name")
        find_or_create_department(department)
        
        user = User.find_or_initialize_by(tribehr_id: id)
        user.update_attributes!(email: email, manager_id: manager_id, first_name: first_name,
                                last_name: last_name, title: title, department_id: department["id"])        
      end
    end
  end

  private
  def find_or_create_department(department)
    d = Department.find_or_initialize_by(tribehr_id: department["id"])
    d.update_attributes!(name: department["name"])
  end

  
end
