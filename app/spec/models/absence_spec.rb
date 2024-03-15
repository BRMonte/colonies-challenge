require 'rails_helper'

RSpec.describe Absence, type: :model do
  describe "#handle_stays" do
    let(:absence) { { start_date: Date.new(2024, 1, 1), end_date: Date.new(2024, 1, 7) } }

    let(:studio_affected) { create(:studio) }
    let(:studio_not_affected) { create(:studio) }

    let!(:stay_affected) {
      create(
        :stay,
        studio: studio_affected,
        start_date: absence[:start_date] + 1,
        end_date: absence[:end_date] - 1
      )
    }

    let!(:stay_not_affected) {
      create(
        :stay,
        studio: studio_not_affected,
        start_date: Date.new(2024, 1, 10),
        end_date: Date.new(2024, 1, 20)
      )
    }

    context "when there are no affected stays" do
      it "returns false" do
        absence_instance = Absence.new(studio_not_affected, absence[:start_date], absence[:end_date])
        result = absence_instance.handle_stays

        expect(result).to eq(false)
      end
    end

    context "when there are affected stays" do
      it "returns true" do
        absence_instance = Absence.new(studio_affected, absence[:start_date], absence[:end_date])
        result = absence_instance.handle_stays

        expect(result).to eq(true)
      end

      it "updates stays as expected" do
        absence_instance = Absence.new(studio_affected, absence[:start_date], absence[:end_date])
        absence_instance.handle_stays

        # stay_affected.reload
        expect(stay_affected.start_date).to eq(absence[:end_date] + 1)
        expect(stay_affected.end_date).to eq(absence[:end_date] - 1)
      end
    end
  end
end
