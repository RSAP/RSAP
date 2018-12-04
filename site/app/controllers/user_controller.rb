class UserController < ApplicationController

   def create
      # redirect_to new_user_registration (flash: "algo está errado!")
      @user = User.create(user_params)
      if @user.id?
         redirect_to root_path
      else
         redirect_to root_path
         redirect_back fallback_location: root_path
      end
   end

   #Para view de ver perfil
   def show
      @user = User.find(params[:id])
   end

<<<<<<< HEAD
   def erro
      @msg = 'opa'
      render 'erro/erro'
=======
   def home
	   @user = User.find(current_user.id)
	   @posts =Post.where(user_id: current_user.id)
   end

   def mural
	   @user = User.find(params[:id])
	   @posts = Post.where(user_id: params[:id])
>>>>>>> e5c91a3a22174a992af4d8cf249b56e8cd50e7d1
   end

   private

   # Use strong_parameters for attribute whitelisting
   # Be sure to update your create() and update() controller methods.

   def user_params
      params.require(:user).permit(:avatar)
   end

end
