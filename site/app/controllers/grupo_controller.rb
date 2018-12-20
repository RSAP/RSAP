class GrupoController < ApplicationController

	#TODO: todas as checageens de grupo, creio que o model já ta todo ok


	def index
		@grupos = Grupo.all
	end

	def new
		@grupo = Grupo.new
	end

	def show
	end

	def edit
	end

	def create
		@grupo = Grupo.new(grupo_params)
		respond_to do |format|
			if @grupo.save
				format.html { redirect_to grupos_url, notice: 'Grupo was successfully created.' }
			else
				format.html { render :new }
			end
		end
		@grupo.addUser(current_user)
	end

	def update
		respond_to do |format|
			if @grupo.update(grupo_params)
				format.html { redirect_to  grupos_url, notice: 'Grupo was successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end


	def destroy
		@grupo.destroy
		respond_to do |format|
			format.html { redirect_to '/home', notice: 'Grupo was successfully destroyed.' }
		end
	end



	##############################################################################
	###################################SAIR#######################################
	##############################################################################

	def sair
		grupo = getGrupo(params[:idGrupo])

		if grupo.nil?
			erro("Grupo nao existe")
			return
		end

		if eh_moderador(current_user, grupo)
			if grupo.getModeradores. length == 1
				erro("Só tem vc de moderador, vc nao pode sair")
				return
			end
			grupo.removerModerador(current_user)
		end


		if eh_mebro_do_grupo(current_user, grupo)
			if grupo.getUsers. length == 1
				erro("Só tem vc no grupo, vc nao pode sair")
				return
			end
			grupo.removerUser(current_user)
		else
			erro("Mas vc não faz parte do grupo")
			return
		end

	end

	##############################################################################
	##############################################################################
	##############################################################################






	##############################################################################
	#############################SOLICITACOES#####################################
	##############################################################################
	#TODO: remover codigo duplicado

	def solicitarMinhaParticipacao

		grupo = getGrupo(params[:idGrupo])
		user = getUser(current_user.id)

		if (user.nil? or grupo.nil?)
			noticiar("Grupo ou Usuario nao existe")
			redirect_to grupos_path
			return
		end


		if essa_solicitacao_existe(user, grupo)
			noticiar("Já existe solicitacao pendente")
			redirect_to grupos_path
			return
		end
		if eh_mebro_do_grupo(user, grupo)
			noticiar("Voce já é membro do grupo")
			redirect_to grupos_path
			return
		end

		noticiar("Solicitacao pendente")
		grupo.addSolicitacao(user)
		redirect_to grupos_path

	end

	def cancelarMinhaSolicitacao

		grupo = getGrupo(params[:idGrupo])
		user = getUser(current_user.id)

		if (user.nil? or grupo.nil?)
			noticiar("Grupo ou Usuario nao existe")
			redirect_to grupos_path
			return
		end

		if !(essa_solicitacao_existe(user, grupo))
			noticiar("Não existe solicitacao pendente")
			redirect_to grupos_path
			return
		end
		if eh_mebro_do_grupo(user, grupo)
			noticiar("Voce já é membro do grupo")
			redirect_to grupos_path
			return
		end

		grupo.removerSolicitacao(user)
		redirect_to grupos_path

	end

	def rejeitarSolicitacao

		grupo = getGrupo(params[:idGrupo])
		user = getUser(params[:idDeQuem])

		if (user.nil? or grupo.nil?)
			noticiar("Grupo ou Usuario nao existe")
			redirect_to grupos_path
			return
		end


		if condicoesParaManusearPedidos(user, grupo)
			grupo.removerSolicitacao(user)
			noticiar("Solitacao de #{user.getNick} rejeitada")
			redirect_to grupos_path
			return
		end


		redirect_to grupos_path
	end

	def aceitarSolitacao


		grupo = getGrupo(params[:idGrupo])
		user = getUser(params[:idDeQuem])

		if (user.nil? or grupo.nil?)
			noticiar("Grupo ou Usuario nao existe")
			redirect_to grupos_path
			return
		end

		if condicoesParaManusearPedidos(user, grupo)
			grupo.addUser(user)
			grupo.removerSolicitacao(user)
			noticiar("Solitacao de #{user.getNick} aceita")
			redirect_to grupos_path
			return
		end
	end



	def solicitacoes
		@grupo = getGrupo(params[:idGrupo])
		if @grupo.nil?
			erro("Grupo nao existe")
			return
		end

		if !(eh_moderador(current_user, @grupo))
			erro("Voce nao é moderador do grupo")
			return
		end

		@solicitantes = @grupo.getSolicitacoes


	end


	##############################################################################
	##############################################################################
	##############################################################################



	#################### DAQUI PRA BAIXO É TUDO PRIVADO ##########################

	private
	def grupo_params
		params.require(:grupo).permit(:nome, :descricao)
	end


	##############################################################################
	#############################SOLICITACOES#####################################
	##############################################################################

	def eh_moderador(user, grupo)
		grupo.getModeradores.include?(user)
	end

	def eh_mebro_do_grupo(user, grupo)
		grupo.getUsers.include?(user)
	end

	def essa_solicitacao_existe(user, grupo)
		grupo.getSolicitacoes.include?(user)
	end

	def noticiar(mensagem)
		flash[:notice] = mensagem
	end

	def getGrupo(idGrupo)
		begin
			user = Grupo.find(idGrupo)
		rescue ActiveRecord::RecordNotFound
			return nil
		end
	end

	def getUser(idUser)
		begin
			user = User.find(idUser)
		rescue ActiveRecord::RecordNotFound
			return nil
		end
	end


	def condicoesParaManusearPedidos(user, grupo)
		eu = current_user

		if !(eh_moderador(eu, grupo))
			erro("Voce nao é moderador do grupo")
			return false
		end

		if !(essa_solicitacao_existe(user, grupo))
			erro("Essa solitacao nao existe")
			return false
		end

		return true
	end

	##############################################################################
	##############################################################################
	##############################################################################


	def erro(messagem)
		@msg = messagem
		render 'erro/erro'
	end

	############## DAQUI PRA BAIXO É TUDO HELPER PRA USAR NA VIEW ############


	helper_method :eh_mebro_do_grupo
	helper_method :eh_moderador
	helper_method :essa_solicitacao_existe



end
