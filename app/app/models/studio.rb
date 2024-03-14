class Studio < ApplicationRecord
  has_many :stays, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.absences
    studios_with_absences = {}

    all.includes(:stays).each do |studio|
      studios_with_absences["#{studio.name}/id:#{studio.id}"] = studio.get_absences
    end

    studios_with_absences
  end

  def get_absences
    return ['No stays booked'] unless stays.present?

    absences = []
    prev_end_date = stays.first[:start_date]

    stays.each do |stay|
      absence_start_date = prev_end_date + 1
      absence_end_date = stay[:start_date] - 1

      absences << { start_date: absence_start_date, end_date: absence_end_date } if absence_start_date <= absence_end_date

      prev_end_date = [prev_end_date, stay[:end_date]].max
    end

    absences
  end
end
