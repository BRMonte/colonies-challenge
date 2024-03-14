class Studio < ApplicationRecord
  has_many :stays, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.absences
    return 'No Studios to check' if Studio.count == 0

    studios_with_absences = {}

    all.includes(:stays).each do |studio|
      studios_with_absences["#{studio.name}/id:#{studio.id}"] = studio.get_absences
    end

    studios_with_absences
  end

  def find_affected_stays(start_date, end_date)
    stays.where("start_date <= ? AND end_date >= ?", end_date, start_date)
  end

  def adjust_stays(start_date, end_date)
    affected_stays = find_affected_stays(start_date, end_date)
    affected_stays.each do |stay|
        start_distance = (start_date - stay.start_date).to_i
        end_distance = (stay.end_date - end_date).to_i

        if start_distance > end_distance
          stay.update(end_date: stay.start_date + (end_date - start_date).days - 1.day)
        else
          stay.update(start_date: stay.end_date - (end_date - start_date).days + 1.day)
        end
    end
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
