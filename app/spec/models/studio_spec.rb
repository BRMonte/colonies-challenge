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
end
