require 'rails_helper'

RSpec.describe "Api::V1::Absences", type: :request do
  describe "GET /api/v1/absences" do
    before(:each) do
      @studio1 = create(:studio, name: "Studio 1")
      @studio2 = create(:studio, name: "Studio 2")
      @studio3 = create(:studio, name: "Studio 3")

      create(:stay, studio: @studio1, start_date: Date.new(2024, 1, 1), end_date: Date.new(2024, 1, 8))
      create(:stay, studio: @studio1, start_date: Date.new(2024, 1, 16), end_date: Date.new(2024, 1, 24))

      create(:stay, studio: @studio2, start_date: Date.new(2024, 1, 5), end_date: Date.new(2024, 1, 10))
      create(:stay, studio: @studio2, start_date: Date.new(2024, 1, 15), end_date: Date.new(2024, 1, 20))
      create(:stay, studio: @studio2, start_date: Date.new(2024, 1, 21), end_date: Date.new(2024, 1, 25))
    end

    it "returns a ok status code" do
      get "/api/v1/absences"

      expect(response).to have_http_status(:ok)
    end

    it "returns the correct response body" do
      get "/api/v1/absences"

      expected_result = { absences: [
        {
          studio_id: @studio1.id,
          studio_name: @studio1.name,
          absences: [
            {
              start_date: "09/01/2024",
              end_date: "15/01/2024"
            }
          ]
        },
        {
          studio_id: @studio2.id,
          studio_name: @studio2.name,
          absences: [
            {
              start_date: "11/01/2024",
              end_date: "14/01/2024"
            },
          ]
        },
        {
          studio_id: @studio3.id,
          studio_name: @studio3.name,
          absences: "No stays booked"
        }
      ]
     }

      expect(JSON.parse(response.body)).to eq(expected_result)
    end

  end
end
