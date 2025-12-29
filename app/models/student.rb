class Student < ApplicationRecord
    self.table_name = :students
    validate :check_dob
  
    validates :scholar_number, :first_name, :last_name, :father_name, :mother_name, :email, :phone_number,
              :country_code, :city, :state, :country, :address, :aadhar_number,
              presence: true, on: :create
  
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: "Email is invalid" }
    validates_uniqueness_of :email, message: "Email has been already taken", on: :create, if: -> { student_exists }
  
    validates_length_of :first_name, minimum: 3, if: -> { first_name.present? }, message: "First name is too short (minimum is 3 characters)"
    validates_length_of :phone_number, minimum: 4, maximum: 16, if: -> { phone_number.present? }, message: "Phone number is too short (minimum is 4 characters)"
    
    enum :grade, { nursery: 0, lkg: 1, ukg: 2, class1: 3, class2: 4, class3: 5, class4: 6, class5: 7, class6: 8, class7: 9, class8: 10, class9: 11, class10: 12, class11: 13, class12: 14 }

    enum :gender, { male: 0, female: 1, others: 2 }

     # ---- RANSACK SAFE LISTING ----

    # Allow only safe searchable fields
    def self.ransackable_attributes(auth_object = nil)
      %w[
        id
        scholar_number
        first_name
        last_name
        grade
        father_name
        mother_name
        gender
        dob
        email
        address
        city
        state
        country
        country_code
        phone_number
        aadhar_number
        created_at
        updated_at
      ]
    end

    # Add associations here (if any)
    def self.ransackable_associations(auth_object = nil)
      []
    end
  
    private
  
    def student_exists
      Student.find_by(email: email).present?
    end
  
    def check_dob
      dt_format = "%m/%e/%Y"
      errors.add(:dob, "please select valid date") if dob.present? &&
        Date.strptime(dob, dt_format) >= Date.strptime(Date.today.strftime(dt_format), dt_format)
    end
  end
