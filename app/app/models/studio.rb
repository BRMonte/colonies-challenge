class Studio < ApplicationRecord
  has_many :stays, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.absences
    return 'No Studios to check' if Studio.count.zero?

    absences_data = []

    all.includes(:stays).each do |studio|
      absences = studio.get_absences
      next if absences.empty?

      absences_data.concat(absences.map { |absence| { studio_id: studio.id, studio_name: studio.name, absences: absence } })
    end

    absences_data
  end

  def find_affected_stays(start_date, end_date)
    stays.where("start_date <= ? AND end_date >= ?", end_date, start_date)
  end

  def get_absences
    return ['No stays booked'] unless stays.present?

    absences = []
    stays.order(start_date: :asc).each_cons(2) do |previous_stay, stay|
      absence_start_date = previous_stay.end_date + 1
      absence_end_date = stay.start_date - 1

      if absence_start_date <= absence_end_date
        absences << {
          start_date: absence_start_date.strftime("%d/%m/%Y"),
          end_date: absence_end_date.strftime("%d/%m/%Y")
        }
      end
    end

    [absences]
  end
end
