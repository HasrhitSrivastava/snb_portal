ActiveAdmin.register Student do
  # Specify parameters which should be permitted for assignment
  permit_params :scholar_number, :first_name, :last_name, :grade, :father_name, :mother_name, :gender, :dob, :email, :address, :city, :state, :country, :country_code, :phone_number, :aadhar_number

  # or consider:
  #
  # permit_params do
  #   permitted = [:scholar_number, :first_name, :last_name, :grade, :father_name, :mother_name, :gender, :dob, :email, :address, :city, :state, :country, :country_code, :phone_number, :aadhar_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :scholar_number
  filter :first_name
  filter :last_name
  filter :grade,
       as: :select,
       collection: Student.grades.map { |name, value| [ name.titleize, value ] }
  filter :father_name
  filter :mother_name
  filter :gender,
       as: :select,
       collection: Student.genders.map { |name, value| [ name.titleize, value ] }

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :scholar_number
    column :first_name
    column :last_name
    column :grade
    column :father_name
    column :mother_name
    column :gender
    column :dob
    column :email
    column :address
    column :city
    column :state
    column :country
    column :country_code
    column :phone_number
    column :aadhar_number
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :scholar_number
      row :first_name
      row :last_name
      row :grade
      row :father_name
      row :mother_name
      row :gender
      row :dob
      row :email
      row :address
      row :city
      row :state
      row :country
      row :country_code
      row :phone_number
      row :aadhar_number
      row :created_at
      row :updated_at
    end
  end

  action_item :download_sample, only: :index do
    link_to "Download Sample CSV", "/sample.csv", target: "_blank", class: "action-item-button"
  end

  action_item :print_snb_eng_tc, only: :index do
    link_to "SNB TC", print_snb_eng_tc_admin_students_path, target: "_blank", class: "action-item-button"
  end

  action_item :print_snbsn_tc, only: :index do
    link_to "SNBSN TC", print_snbsn_tc_admin_students_path, target: "_blank", class: "action-item-button"
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :scholar_number
      f.input :first_name
      f.input :last_name
      f.input :grade
      f.input :father_name
      f.input :mother_name
      f.input :gender
      f.input :dob
      f.input :email
      f.input :address
      f.input :city
      f.input :state
      f.input :country,
              required: true,
              as: :select,
              collection: ISO3166::Country.all.map { |c| [ "#{c.emoji_flag} #{c.common_name}", c.common_name ] },
              selected: f.object.country,
              input_html: {
                class: "select2",
                data: { placeholder: "Select a country" }
              }
      f.input :country_code,
              required: true,
              as: :select,
              collection: ISO3166::Country.all.map { |c| [ "#{c.emoji_flag} #{c.common_name} (+#{c.country_code})", c.country_code ] },
              selected: f.object.country_code,
              input_html: {
                class: "select2",
                data: { placeholder: "Select a country code" }
              }
      f.input :phone_number
      f.input :aadhar_number
    end
    f.actions
  end

  collection_action :print_snb_eng_tc, method: :get do
    # Generate any generic or batch DOC file here
    send_file Rails.root.join("app", "templates", "snb_transfer_certificate_eng.docx"), type: "application/docx"
  end

  collection_action :print_snbsn_tc, method: :get do
    # Generate any generic or batch DOC file here
    send_file Rails.root.join("app", "templates", "snb_transfer_certificate.docx"), type: "application/docx"
  end
end
