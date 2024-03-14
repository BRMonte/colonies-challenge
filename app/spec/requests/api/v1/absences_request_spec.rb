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

      expected_response = {
        "absences" => {
          "#{@studio1.name}/id:#{@studio1.id}" => [
            { "start_date" => "2024-01-09", "end_date" => "2024-01-15" }
          ],
          "#{@studio2.name}/id:#{@studio2.id}" => [
            { "start_date" => "2024-01-11", "end_date" => "2024-01-14" }
          ],
          "#{@studio3.name}/id:#{@studio3.id}" => ["No stays booked"]
        }
      }

      expect(JSON.parse(response.body)).to eq(expected_response)
    end

  end
end
