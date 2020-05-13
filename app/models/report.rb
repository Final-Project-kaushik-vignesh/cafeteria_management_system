class Report < ApplicationRecord
  has_many :orders
  validates_presence_of :start_date, message: "Field is mandatory: Start Date"
  validates_presence_of :end_date, message: "Field is mandatory: End Date"
  validate :end_after_start

  private

  def end_after_start
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "End Date Must be after the Start date")
    end
  end
end
