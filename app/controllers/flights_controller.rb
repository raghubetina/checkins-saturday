class FlightsController < ApplicationController
  def index
    # matching_flights = Flight.where({ :user_id => @current_user.id })
    
    matching_flights = @current_user.flights

    @upcoming_flights = matching_flights.where("departs_at > ?", Time.now).order({ :created_at => :desc })

    @past_flights = matching_flights.where("departs_at <= ?", Time.now).order({ :created_at => :desc })

    render({ :template => "flights/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_flights = Flight.where({ :id => the_id })

    @the_flight = matching_flights.at(0)

    render({ :template => "flights/show.html.erb" })
  end

  def create
    the_flight = Flight.new
    the_flight.user_id = @current_user.id
    the_flight.departs_at = params.fetch("query_departs_at")
    the_flight.description = params.fetch("query_description")

    if the_flight.valid?
      the_flight.save
      redirect_to("/flights", { :notice => "Flight created successfully." })
    else
      redirect_to("/flights", { :notice => "Flight failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_flight = Flight.where({ :id => the_id }).at(0)

    the_flight.user_id = params.fetch("query_user_id")
    the_flight.departs_at = params.fetch("query_departs_at")
    the_flight.description = params.fetch("query_description")
    the_flight.alert_sent = params.fetch("query_alert_sent", false)

    if the_flight.valid?
      the_flight.save
      redirect_to("/flights/#{the_flight.id}", { :notice => "Flight updated successfully."} )
    else
      redirect_to("/flights/#{the_flight.id}", { :alert => "Flight failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_flight = Flight.where({ :id => the_id }).at(0)

    the_flight.destroy

    redirect_to("/flights", { :notice => "Flight deleted successfully."} )
  end
end
