class StudentApplication < ApplicationRecord
  default_scope { where(is_deleted: false) }
  
  mount_uploader :application_form, ApplicationAdminUploader
  mount_uploader :progress_state, ProgressStateUploader
  mount_uploader :ksce_cert, KsceCertUploader
  mount_uploader :degree_certificate, DegreeCertificateUploader
  mount_uploader :degree_transcript, DegreeTranscriptUploader
  mount_uploader :recommendation_letters, RecommendationLettersUploader
  mount_uploader :cv, CvUploader
  mount_uploader :personal_statement, PersonalStatementUploader
  mount_uploader :confirmation_of_acceptance, ConfirmationOfAcceptanceUploader
  mount_uploader :bank_statement, BankStatementUploader
  mount_uploader :passport_copy, PassportCopyUploader
  mount_uploader :passport, PassportUploader
  mount_uploader :school_leaving, SchoolLeavingUploader
  mount_uploader :previous_visa ,PreviousVisaUploader
  mount_uploader :visa_refusals, VisaRefusalsUploader

  before_create :create_uuid
  before_create :set_work_process_flow

  def create_uuid
    self.uuid = SecureRandom.uuid.split('-').first
  end

  def set_work_process_flow
    self.fill_form_workprocess_flow = "done" if self.application_form.present?
    self.visa_payment_workprocess_flow = "pending" if self.application_form.present?
    self.appointment_workprocess_flow = "pending" if self.application_form.present?
    self.document_uploading_workprocess_flow = "done" if self.fileCount > 9

    if (self.fill_form_workprocess_flow == "done") &&
      (self.visa_payment_workprocess_flow == "done") &&
      (self.appointment_workprocess_flow == "done") &&
      (self.document_uploading_workprocess_flow == "done")
     self.finished_work_process_flow = "done"
    end
   
  end

end
