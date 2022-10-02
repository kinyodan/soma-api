# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_01_122022) do
  create_table "applications", force: :cascade do |t|
    t.string "uuid"
    t.integer "student_id"
    t.string "ksce_cert"
    t.string "passport"
    t.string "school_leaving"
    t.string "visa_refusals"
    t.string "degree_certificate"
    t.string "degree_transcript"
    t.string "passport_copy"
    t.string "recommendation_letters"
    t.string "cv"
    t.string "personal_statement"
    t.string "confirmation_of_acceptance"
    t.string "bank_statement"
    t.string "previous_visa"
    t.string "status"
    t.string "upload_by"
    t.string "applicatio_admin"
    t.string "progress_state"
    t.integer "progress_steps"
    t.integer "current_step"
    t.integer "current_agent_processing"
    t.string "workflow_state"
    t.string "workflow_status"
    t.string "worklow_progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted"
  end

  create_table "appointment_dates", force: :cascade do |t|
    t.integer "appointment_id"
    t.string "designation"
    t.string "date"
    t.integer "day"
    t.boolean "future"
    t.boolean "hasDay"
    t.boolean "hasTime"
    t.integer "hour"
    t.integer "minute"
    t.integer "month"
    t.boolean "past"
    t.boolean "present"
    t.string "time"
    t.integer "weekday"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "start_date_id"
    t.integer "end_date_id"
    t.integer "student_id"
    t.string "email"
    t.integer "student_application_id"
    t.string "uuid"
    t.string "name"
    t.string "title"
    t.string "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_date"
    t.string "end_date"
    t.string "color"
    t.string "start"
    t.string "end"
    t.boolean "timed"
  end

  create_table "documents", force: :cascade do |t|
    t.integer "student_id"
    t.integer "student_application_id"
    t.string "document_name"
    t.string "document_type"
    t.string "document"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted"
  end

  create_table "installs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_installs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "country_code"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "student_applications", force: :cascade do |t|
    t.string "uuid"
    t.integer "student_id"
    t.string "ksce_cert"
    t.string "passport"
    t.string "school_leaving"
    t.string "visa_refusals"
    t.string "degree_certificate"
    t.string "degree_transcript"
    t.string "passport_copy"
    t.string "recommendation_letters"
    t.string "cv"
    t.string "personal_statement"
    t.string "confirmation_of_acceptance"
    t.string "bank_statement"
    t.string "previous_visa"
    t.string "status"
    t.string "upload_by"
    t.string "application_admin"
    t.string "progress_state"
    t.integer "progress_steps"
    t.integer "current_step"
    t.integer "current_agent_processing"
    t.string "workflow_state"
    t.string "workflow_status"
    t.string "worklow_progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "institution_name"
    t.string "institution_email"
    t.string "institution_phone"
    t.string "institution_id"
    t.string "application_form_template_url"
    t.string "application_form"
    t.string "fill_form_workprocess_flow"
    t.string "visa_payment_workprocess_flow"
    t.string "appointment_workprocess_flow"
    t.string "document_uploading_workprocess_flow"
    t.string "additional_workprocess_flow"
    t.string "extra_workprocess_flow"
    t.string "finished_work_process_flow"
    t.integer "fileCount"
    t.boolean "deleted"
    t.boolean "is_deleted", default: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "location"
    t.integer "country_id"
    t.string "country_code"
    t.boolean "status"
    t.string "created_by"
    t.string "deleted_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.boolean "deleted"
    t.string "password"
    t.string "confirm_password"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
