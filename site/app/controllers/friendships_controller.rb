class FriendshipsController < ApplicationController
	def create
		if (params[:id].eql? params[:friend_id])
			flash[:notice] = "Voce nao pode solicitar amizade a si mesmo"
		else
		begin
		@user = User.find(params[:friend_id])
		if  (((current_user.pending_friends).include? @user) || ((current_user.requested_friendships).include? @user))
			flash[:notice] = "Voce nao pode solicitar amizade enquanto houver uma solitacao pendente"
		else
			if(((current_user.received_friends).include? @user) || ((current_user.active_friends).include? @user))
				flash[:notice] = "Voce nao pode solicitar amizade de alguem que ja eh seu amigo"
			else
				@friendship = current_user.friendships.build(friend_id: params[:friend_id])
				if @friendship.save
					flash[:notice] = "Pedido de amizade eviado."
				else
					flash[:notice] = "Ocorreu um erro ao tentar fazer a solicitação de amizade"
					end
				end
			end
		rescue ActiveRecord::RecordNotFound
		flash[:notice] = "Usuario inexistente"
		end
	end
end

	def update
		@friendship = Friendship.find params[:request_id]
		@friendship.update(accepted: true)
		if @friendship.save
			flash[:notice] = "Voces agora são amigos!"
		else
			flash[:notice] = "Ocorreu um erro ao tentar aceitar a solicitação de amizade"
		end
	end

	def destroy
			@friendship = Friendship.find_by(id: params[:request_id])
			@friendship.destroy
			flash[:notice] = "Amizade desfeita."
			redirect_to controller: 'user', action: 'show', id: current_user.id
	end
end
