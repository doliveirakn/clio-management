class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :tribehr_id, null: false
      t.string :name, null: false, limit: 30
      t.index :tribehr_id
    end
  end
end
