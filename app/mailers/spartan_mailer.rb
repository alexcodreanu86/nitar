class SpartanMailer < ActionMailer::Base
  default from: ENV["EMAIL_ADDRESS"]
  def new_quote_request(trip_id)
    @trip = Trip.where(id: trip_id).first 
    mail(to: ENV["ADMIN_EMAIL"], subject: "New quote request") do |format|
      format.html
    end
  end

  def new_message(message)
    @message = message
    mail(to: ENV["ADMIN_EMAIL"], subject: "New Message From Customer") do |format|
      format.html
    end
  end

  def send_customer_confirmation(message, trip)
    @message = message
    @trip = trip
    mail(to: @trip.contact_email, subject: "Trip confirmation") do |format|
      format.html
    end
  end
end
