class UserController < ApplicationController

	def index
		@user = User.search(params[:search])
	end

   def create
      @user = User.create(user_params)
   end

   def viewUser
	   @user = User.find(params[:idUser])
	   @pendente = Friendship.all
   end

   #Para view de ver perfil
   def show
      @user = User.find(params[:id])
   end

	def list
		@user = User.find(params[:id])
		@pendente = Friendship.all
	end

	def listFriends
		@user = User.find(params[:id])
	end


   private

   # Use strong_parameters for attribute whitelisting
   # Be sure to update your create() and update() controller methods.

   def user_params
      params.require(:user).permit(:avatar)
   end

end
