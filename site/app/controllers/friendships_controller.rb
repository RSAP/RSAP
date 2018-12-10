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
						end
					end
				end
			rescue ActiveRecord::RecordNotFound
				flash[:notice] = "Usuario inexistente"
			end
		end
	end

	def update
		@friendship = Friendship.find_by(id: params[:request_id])
		if @friendship
			if ((@friendship.user_id.eql? current_user.id) || (@friendship.friend_id.eql? current_user.id))
				@friendship.update(accepted: true)
				if @friendship.save
					flash[:notice] = "Voces agora são amigos!"
				end
			else
				flash[:notice] = "Você não tem permissão para fazer isso!"
			end
		else
			flash[:notice] = "Essa amizade não existe!"
		end
	end

	def destroy
		begin
			@friendship = Friendship.find_by(id: params[:request_id])
			if @friendship
				if ((@friendship.user_id.eql? current_user.id) || (@friendship.friend_id.eql? current_user.id))
					@friendship.destroy
					if @friendship.save
						flash[:notice] = "Amizade desfeita."
					end
				else
					flash[:notice] = "Você não tem permissão para fazer isso!"
				end
			else
				flash[:notice] = "Essa amizade não existe!"
			end
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "Essa amizade não existe!"
		end
	end
end
