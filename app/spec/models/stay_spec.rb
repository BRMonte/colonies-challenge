require 'rails_helper'

RSpec.describe Stay, type: :model do
  describe 'callbacks' do
    describe 'set_end_date' do
      let(:no_end_date_stay) { build(:stay, :without_end_date) }
      let(:stay) { build(:stay, start_date: Date.today, end_date: Date.tomorrow) }

      context 'when end_date is not present' do
        it 'sets end_date to 3 days after start_date' do
          standart_duration = 3
          no_end_date_stay.save

          expect(no_end_date_stay.end_date).to eq(no_end_date_stay.start_date + standart_duration)
        end
      end

      context 'when end_date is present' do
        it 'keeps original end_date' do
          stay.save

          expect(stay.end_date).to eq(Date.tomorrow)
        end
      end
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      stay = build(:stay)

      expect(stay).to be_valid
    end

    it 'is invalid without a start date' do
      stay = build(:stay, start_date: nil)

      expect(stay).not_to be_valid
      expect(stay.errors[:start_date]).to include("can't be blank")
    end

    it 'is invalid if end date is before start date' do
      stay = build(:stay, start_date: Date.today, end_date: Date.yesterday)

      expect(stay).not_to be_valid
      expect(stay.errors[:end_date]).to include("must be greater than #{stay.start_date}")
    end

    it 'is invalid if start date is before the open calendar' do
      open_calendar = Date.new(2024, 1, 1)
      stay = build(:stay, start_date: Date.new(2023, 12, 31))

      expect(stay).not_to be_valid
      expect(stay.errors[:start_date]).to include("Can't be before calendar is open")
    end

    it 'is invalid if it overlaps with another stay' do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.today, end_date: Date.tomorrow)
      overlaped_stay = build(:stay, studio: studio, start_date: Date.tomorrow, end_date: Date.tomorrow + 1)

      expect(overlaped_stay).not_to be_valid
      expect(overlaped_stay.errors[:base]).to include("Can't overlap with another stay")
    end
  end
end
