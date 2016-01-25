require 'rails_helper'

RSpec.describe TribeImporter do

  let(:service) { described_class.new }

  let(:users_response) do
    [
      {"id" => 1}
    ]
  end
  let(:id){ users_response.first["id"] }
  let(:user_response) do
    {
      "id" => 1,
      "email" => "hello@clio.com",
      "employee_record" => employee_record,
      "assignment_record" => assignment_record
    }
  end

  let(:employee_record) do
    {
      "first_name" => "Hello",
      "last_name" => "World"
    }
  end

  let(:assignment_record) do
    {
      "department" => department,
      "manager" => manager,
      "job" => job
    }
  end

  let(:department) { { "id" => 10, "name" => "Huzzah"} }
  let(:manager) { { "id" => 100 } }
  let(:job) { { "title" => "Super cool!" } }
  
  
  before do
    allow_any_instance_of(TribeFetcher).to receive(:users).and_return(users_response)
    allow_any_instance_of(TribeFetcher).to receive(:user).with(id).and_return(user_response)
  end
  
  describe "#perform" do
    context "when the user doesn't exist" do
      it "creates the user" do
        expect{ service.perform }.to change(User, :count).by(1)
        u = User.last
        expect(u).to_not be_nil
        expect(u.first_name).to eql "Hello"
        expect(u.last_name).to eql "World"
        expect(u.title).to eql "Super cool!"
        expect(u.manager_id).to eql 100
        expect(u.tribehr_id).to eql id
        expect(u.email).to eql "hello@clio.com"
        expect(u.department_id).to eql 10
      end
    end

    context "when the user already exists" do
      let!(:user) { create(:user, tribehr_id: id, department_id: 10) }
      it "doesn't create any more users" do
        expect{ service.perform }.to_not change(User, :count)
      end
      it "updates the user information" do
        service.perform
        u = user.reload
        expect(u).to_not be_nil
        expect(u.first_name).to eql "Hello"
        expect(u.last_name).to eql "World"
        expect(u.title).to eql "Super cool!"
        expect(u.manager_id).to eql 100
        expect(u.tribehr_id).to eql id
        expect(u.email).to eql "hello@clio.com"
        expect(u.department_id).to eql 10        
      end
    end

    context "when the department doesn't exist" do
      it "creates the department" do
        expect{ service.perform }.to change(Department, :count).by(1)
        d = Department.last
        expect(d.tribehr_id).to eql 10
        expect(d.name).to eql "Huzzah"
      end
    end

    context "when the department already exists" do
      let!(:department_record) { create(:department, tribehr_id: 10) }
      it "doesn't create a new department" do
        expect{ service.perform }.to_not change(Department, :count)     
      end
      it "updates the department" do
        service.perform
        d = department_record.reload
        expect(d.name).to eql "Huzzah"      
      end
    end

    context "when there is no job record" do
      let(:job) { [] }
      it "doesn't create a user or department" do
        service.perform
        expect(User).to_not exist
        expect(Department).to_not exist
      end
    end
    
  end
  
end
