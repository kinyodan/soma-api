class CreateStudentApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :student_applications do |t|
      t.string :uuid
      t.integer :student_id
      t.string :ksce_cert
      t.string :passport
      t.string :school_leaving
      t.string :visa_refusals
      t.string :degree_certificate
      t.string :degree_transcript
      t.string :passport_copy
      t.string :recommendation_letters
      t.string :cv
      t.string :personal_statement
      t.string :confirmation_of_acceptance
      t.string :bank_statement
      t.string :previous_visa
      t.string :status
      t.string :upload_by
      t.string :applicatio_admin
      t.string :progress_state
      t.integer :progress_steps
      t.integer :current_step
      t.integer :current_agent_processing
      t.string :workflow_state
      t.string :workflow_status
      t.string :worklow_progress

      t.timestamps
    end
  end
end
