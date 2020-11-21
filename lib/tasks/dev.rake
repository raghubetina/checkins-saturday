desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do

  User.destroy_all
  Flight.destroy_all

  u = User.new
  u.email = "alice@example.com"
  u.password = "password"
  u.password_confirmation = "password"
  u.phone_number = "+1234567890"
  u.save

  p u.errors.full_messages

  first_flight = Flight.new
  first_flight.description = "Within reminder window"
  first_flight.departs_at = 24.hours.from_now + 5.minutes
  first_flight.user_id = u.id
  first_flight.save

  p first_flight.errors.full_messages

  second_flight = Flight.new
  second_flight.description = "Outside reminder window"
  second_flight.departs_at = 48.hours.from_now + 5.minutes
  second_flight.user_id = u.id
  second_flight.save

  p second_flight.errors.full_messages
end
