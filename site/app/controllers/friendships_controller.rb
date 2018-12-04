class FriendshipsController < ApplicationController
	def create
		begin
		@user = User.find(params[:friend_id])
		if  (((current_user.pending_friends).include? @user) || ((current_user.requested_friendships).include? @user))
			redirect_to controller: 'user', action: 'list', id: current_user.id, notice: "Ocorreu um erro ao tentar fazer a solicitação de amizade"
		else
			@friendship = current_user.friendships.build(friend_id: params[:friend_id])
			if @friendship.save
				flash[:notice] = "Pedido de amizade eviado."
			else
				flash[:notice] = "Ocorreu um erro ao tentar fazer a solicitação de amizade"
			end
		end
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "Usuario inexistente"
		end
	end


	def update
		@friendship = Friendship.find params[:request_id]
		@friendship.update(accepted: true)
		if @friendship.save
			redirect_to controller: 'user', action: 'list', id: current_user.id, notice: "Voces agora são amigos!"
		else
			redirect_to controller: 'user', action: 'list', id: current_user.id, notice: "Ocorreu um erro ao tentar aceitar a solicitação de amizade"
		end
	end

	def destroy
		@friendship = Friendship.find_by(id: params[:request_id])
		@friendship.destroy
		flash[:notice] = "Amizade desfeita."
		redirect_to controller: 'user', action: 'show', id: current_user.id
	end
end
