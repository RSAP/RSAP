class UserController < ApplicationController

   def create
      @user = User.create(user_params)
   end

   #Para view de ver perfil
   def show
      @user = User.find(params[:id])
   end

   private

   # Use strong_parameters for attribute whitelisting
   # Be sure to update your create() and update() controller methods.

   def user_params
      params.require(:user).permit(:avatar)
   end

end
