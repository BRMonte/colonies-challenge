require 'rails_helper'

RSpec.describe Studio, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      valid_studio = build(:studio, name: 'test')
      nameless_studio = build(:studio, name: nil)

      expect(nameless_studio).not_to be_valid
      expect(nameless_studio.errors[:name]).to include("can't be blank")
      expect(valid_studio).to be_valid
    end

    it 'validates uniqueness of name' do
      create(:studio, name: 'Test Studio')
      duplicated_studio = build(:studio, name: 'Test Studio')

      expect(duplicated_studio).not_to be_valid
      expect(duplicated_studio.errors[:name]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'has many stays' do
      association = described_class.reflect_on_association(:stays)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'class method' do
    describe '.absences' do
      it 'returns absences for all studios' do
        studio1 = create(:studio, name: 'Studio 1')
        studio2 = create(:studio, name: 'Studio 2')
        studio3 = create(:studio, name: 'Studio 3')

        create(:stay, studio: studio1, start_date: Date.new(2024, 1, 1), end_date: Date.new(2024, 1, 8))
        create(:stay, studio: studio1, start_date: Date.new(2024, 1, 16), end_date: Date.new(2024, 1, 24))

        create(:stay, studio: studio2, start_date: Date.new(2024, 1, 5), end_date: Date.new(2024, 1, 10))
        create(:stay, studio: studio2, start_date: Date.new(2024, 1, 15), end_date: Date.new(2024, 1, 20))
        create(:stay, studio: studio2, start_date: Date.new(2024, 1, 21), end_date: Date.new(2024, 1, 25))
        create(:stay, studio: studio2, start_date: Date.new(2024, 3, 3), end_date: Date.new(2024, 4, 15))

        expected_result = [
          {
            studio_id: studio1.id,
            studio_name: studio1.name,
            absences: [
              {
                start_date: "09/01/2024",
                end_date: "15/01/2024"
              }
            ]
          },
          {
            studio_id: studio2.id,
            studio_name: studio2.name,
            absences: [
              {
                start_date: "11/01/2024",
                end_date: "14/01/2024"
              },
              {
                start_date: "26/01/2024",
                end_date: "02/03/2024"
              }
            ]
          },
          {
            studio_id: studio3.id,
            studio_name: studio3.name,
            absences: "No stays booked"
          }
        ]

        expect(Studio.absences).to eq(expected_result)
      end
    end
  end
end
