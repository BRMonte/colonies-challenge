class Stay < ApplicationRecord
  OPEN_CALENDAR_AT = Date.new(2024, 1, 1).freeze
  belongs_to :studio

  before_save :set_end_date, unless: :end_date_present?

  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }, if: :end_date_present?
  validate :start_date_after_open_calendar
  validate :no_overlapping_stays, if: :end_date_present?

  private

  def set_end_date
    standart_duration = 3
    self.end_date = start_date + standart_duration if start_date
  end

  def end_date_present?
    end_date.present?
  end

  def start_date_after_open_calendar
    errors.add(:start_date, "Can't be before calendar is open") if start_date && start_date < OPEN_CALENDAR_AT
  end

  def no_overlapping_stays
    current_stay_range = start_date..end_date

    overlapping_stays = Stay.where(studio_id: studio_id)
                            .where.not(id: id)
                            .select { |stay| (stay.start_date..stay.end_date).overlaps?(current_stay_range) }

    errors.add(:base, "Can't overlap with another stay") if overlapping_stays.any?
  end
end
