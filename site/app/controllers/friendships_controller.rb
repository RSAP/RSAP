class FriendshipsController < ApplicationController
	def create
		mesmaPessoa = mesmoUsuario
		case mesmaPessoa
		when true
			noticiar("Voce nao pode solicitar amizade a si mesmo")
		else
			user = User.find_by(id: params[:friend_id])
			encontrou = user.nil?
			case encontrou
			when false
				flag = pedidoJaExiste(user)
				case flag
				when true
					noticiar("Voce nao pode solicitar amizade enquanto houver uma solitacao pendente")
				else
					amigos = jaSaoAmigos(user)
					case amigos
					when true
						noticiar("Voce nao pode solicitar amizade de alguem que ja eh seu amigo")
					else
						friendship = current_user.friendships.build(friend_id: params[:friend_id])
						friendship.save
						noticiar("Pedido de amizade eviado.")
					end
				end
			else
				noticiar("Usuario inexistente")
			end
		end
	end

	def noticiar mensagem
		flash[:notice] = mensagem
	end

	def jaSaoAmigos user
		((current_user.received_friends).include? user) || ((current_user.active_friends).include? user)
	end

	def pedidoJaExiste user
		((current_user.pending_friends).include? user) || ((current_user.requested_friendships).include? user)

	end

	def mesmoUsuario
		params[:id].eql? params[:friend_id]
	end

	def usuarioParticipaAmizade friendship
		((friendship.user_id.eql? current_user.id) || (friendship.friend_id.eql? current_user.id))
	end

	def buscarAmizade
		friendship = Friendship.find_by(id: params[:request_id])
	end

	def update
		friendship = buscarAmizade
		existe = friendship.nil?
		case existe
		when false
			participa = usuarioParticipaAmizade(friendship)
			case participa
			when true
				friendship.update(accepted: true)
				friendship.save
				noticiar("Voces agora são amigos!")
			else
				noticiar("Você não tem permissão para fazer isso!")
			end
		else
			noticiar("Essa amizade não existe!")
		end
	end

	def destroy
			friendship = buscarAmizade
			existe = friendship.nil?
			case existe
			when false
				participa = usuarioParticipaAmizade(friendship)
				case participa
				when true
					friendship.destroy
					friendship.save
					noticiar("Amizade desfeita.")
				else
					noticiar("Você não tem permissão para fazer isso!")
				end
				else
				noticiar("Essa amizade não existe!")
			end
		end
	end
