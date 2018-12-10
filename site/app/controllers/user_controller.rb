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

	def update
		# @user = User.find(params[:id])
		redirect_to edit_user_registration_path
	end

	#Para view de ver perfil
	def show
		@user = User.find(params[:id])
	end

	def home
		@user = User.find(current_user.id)
		@posts =Post.where(user_id: current_user.id)
	end

	def mural
		@user = User.find(params[:id])
		@posts = Post.where(user_id: params[:id])
	end
	def index
		@user = User.search(params[:search])
	end

	def viewUser
		@user = User.find(params[:idUser])
		@pendente = Friendship.all
	end

	def list
		@user = User.find(params[:id])
		@pendente = Friendship.all
	end

	def listFriends
		@user = User.find(params[:id])
	end


	private

	def erro
		@msg = 'opa'
		render 'erro/erro'
	end

	def sendToHome
		redirect_to root_path
	end


	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
		params.require(:user).permit(:avatar)
	end

end
