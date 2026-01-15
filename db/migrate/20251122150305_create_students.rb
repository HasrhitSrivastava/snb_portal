class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students, if_not_exists: true do |t|
      t.bigint :scholar_number
      t.string :first_name
      t.string :last_name
      t.integer :grade
      t.string :father_name
      t.string :mother_name
      t.integer :gender
      t.string :dob
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :country_code
      t.bigint :phone_number
      t.string :aadhar_number
      t.timestamps
    end
  end
end
