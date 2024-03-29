# Clear existing records to avoid duplication
Studio.destroy_all
Stay.destroy_all

# Create studios
studio1 = Studio.create(name: "Studio 1")
studio2 = Studio.create(name: "Studio 2")

16.times do |empty_stay|
  Studio.create(name: "Studio #{empty_stay + 2}")
end

# Create stays for studio1
Stay.create(studio: studio1, start_date: Date.new(2024, 1, 1), end_date: Date.new(2024, 1, 8))
Stay.create(studio: studio1, start_date: Date.new(2024, 1, 16), end_date: Date.new(2024, 1, 24))
Stay.create(studio: studio1, start_date: Date.new(2024, 3, 10), end_date: Date.new(2024, 3, 29))
Stay.create(studio: studio1, start_date: Date.new(2024, 5, 2), end_date: Date.new(2024, 5, 7))
Stay.create(studio: studio1, start_date: Date.new(2024, 8, 8), end_date: Date.new(2024, 8, 22))

# Create stays for studio2
Stay.create(studio: studio2, start_date: Date.new(2024, 1, 5), end_date: Date.new(2024, 1, 10))
Stay.create(studio: studio2, start_date: Date.new(2024, 1, 15), end_date: Date.new(2024, 1, 20))
Stay.create(studio: studio2, start_date: Date.new(2024, 1, 21), end_date: Date.new(2024, 1, 25))

puts "Seed data generated successfully."
