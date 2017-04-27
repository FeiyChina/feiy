class BookingsController < ApplicationController

  def create
    @booking = Booking.create(booking_params)
    redirect_to root_path
  end

private

  def booking_params
    booking_params = params.require(:booking).permit(:name, :email)
  end
end
