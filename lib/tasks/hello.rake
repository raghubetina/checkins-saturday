task({ :send_reminders => :environment }) do
  # Find flights where the reminder hasn't been sent yet
  alert_needed_flights = Flight.where({ :alert_sent => false })

  # Then find flights that are within the reminder window
  cutoff_time = 24.hours.from_now + 15.minutes
  
  need_reminder_flights = alert_needed_flights.where("departs_at < ?", cutoff_time)

  # For each flight, send SMS to user

  need_reminder_flights.each do |a_flight|
    p a_flight.description
    p a_flight.user.phone_number

    # Send SMS with Twilio gem

    # Update the alert_sent to true
    a_flight.alert_sent = true
    a_flight.save
  end


end
