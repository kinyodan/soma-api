class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  def assign_default_role
    @student = Student.where(email: self.email)
    if @student
      self.add_role(:student) if self.roles.blank?
    end
  end

  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :jwt_authenticatable,:rememberable, :validatable,jwt_revocation_strategy: self
end
