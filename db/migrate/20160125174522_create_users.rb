class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :tribehr_id, null: false
      t.string :email, limit: 64, null: false
      t.integer :manager_id
      t.string :first_name, limit: 32, null: false
      t.string :last_name, limit: 32, null: false
      t.string :title, limit: 64, null: false
      t.integer :department_id, null: false

      t.index :tribehr_id
      t.index :email      
    end
  end
end
