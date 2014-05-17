class SpartanMailer < ActionMailer::Base
  default from: ENV["EMAIL_ADDRESS"]
  def new_quote_request(trip_id)
    @trip = Trip.where(id: trip_id).first 
    mail(to: ENV["ADMIN_EMAIL"], subject: "New quote request") do |format|
      format.html
    end
  end

end
