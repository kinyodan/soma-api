class Appointment < ApplicationRecord
  after_create :call_create_dates

  def call_create_dates
    # p self
    # p params[:start_date]
    # p params[:end_date]
    # start = params[:start_date].split('T')
    # p start
    # AppointmentDate.create(appointment_id: )
    # t.integer :appointment_id
    # t.string :designation
    # t.string :date
    # t.integer :day
    # t.boolean :future
    # t.boolean :hasDay
    # t.boolean :hasTime
    # t.integer :hour
    # t.integer :minute
    # t.integer :month
    # t.boolean :past
    # t.boolean :present
    # t.string :time
    # t.integer :weekday
    # t.integer :year
  end

end
