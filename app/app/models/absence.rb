class Absence
  def initialize(studio, start_date, end_date)
    @studio = studio
    @start_date = Date.parse(start_date.to_s)
    @end_date = Date.parse(end_date.to_s)
  end

  def handle_stays
    affected_stays = @studio.find_affected_stays(@start_date, @end_date)
    return false unless affected_stays.any?

    affected_stays.each do |stay|
      handle_current_stays(stay)
    end

    true
  end

  private

  def handle_current_stays(stay)
    if is_range_fully_in_absence?(stay)
      stay.delete
    elsif is_absence_fully_in_range?(stay)
      handle_absence_fully_in_range(stay)
    elsif is_start_date_in_absence?(stay)
      stay.update(start_date: @end_date + 1)
    elsif is_end_date_in_absence?(stay)
      stay.update(end_date: @start_date - 1)
    end
  end

  def create_absence(stay)
    @studio.stays.create(start_date: @end_date + 1, end_date: stay.end_date)
  end

  def is_range_fully_in_absence?(stay)
    stay.start_date >= @start_date && stay.end_date <= @end_date
  end

  def handle_absence_fully_in_range(stay)
    stay.update(end_date: @start_date - 1)
    create_absence(stay)
  end

  def is_absence_fully_in_range?(stay)
    stay.start_date < @start_date && stay.end_date > @end_date
  end


  def is_start_date_in_absence?(stay)
    stay.start_date >= @start_date && stay.end_date > @end_date
  end

  def is_end_date_in_absence?(stay)
    stay.start_date <= @start_date && stay.end < @end_date
  end
end
