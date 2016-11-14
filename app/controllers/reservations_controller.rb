class ReservationsController < ApplicationController
<<<<<<< HEAD
  before_action :load_restaurant
  before_action :ensure_logged_in, only: [:create, :destroy]

 def index
   @reservations = Reservation.all
 end

 def show
   @reservation = Reservation.find(params[:id])

   if current_user
     @user = @reservation.users.build
   end
 end

 def new
   @reservation = Reservation.new
   @restaurant = Restaurant.find(params[:restaurant_id])
 end

 def create
   @reservation = Reservation.new(reservation_params)
   @restaurant = Restaurant.find(reservation_params[:restaurant_id])
   if @restaurant.available(reservation_params[:number_of_seats].to_i,reservation_params[:time_of_reservation].to_time)
     if @reservation.save
       redirect_to reservations_url
     else
       render :new
     end
   end
 end

 def edit
   @reservation = Reservation.find(params[:id])
   @restaurant = Restaurant.find(params[:restaurant_id])
 end

 def update
   @reservation = Reservation.find(params[:id])
   @restaurant = Restaurant.find(params[:restaurant_id])
     if @reservation.update_attributes(reservation_params)
       redirect_to reservation_url(@reservation)
     else
       render :edit
     end
 end

 def destroy
   @reservation = Reservation.find(params[:id])
   @reservation.destroy
   redirect_to reservations_url
 end

 private
 def reservation_params
   params.require(:reservation).permit(:restaurant_id,:date_of_reservation, :time_of_reservation, :number_of_seats)
 end

 def load_restaurant
   @restaurant = Restaurant.find(params[:restaurant_id])
 end
end
