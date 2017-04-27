class BookingsController < ApplicationController

  def create
    @booking = Booking.create(booking_params)
  end

private

  def booking_params
    booking_params = params.require(:booking).permit(:name, :email)
  end
end
