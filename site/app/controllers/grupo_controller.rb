class GrupoController < ApplicationController

	#TODO: todas as checageens de grupo, creio que o model já ta todo ok


	def getUser(idUser)
        begin
            user = User.find(idUser)
        rescue ActiveRecord::RecordNotFound
            return nil
        end
    end


	def buscarGrupoNome
		@grupos = Grupo.search(params[:search])
	end

	def index
		@grupos = Grupo.all
	end

	def new
		@grupo = Grupo.new
	end

	def show
		@grupo = buscarGrupo
	end

	def verMembros
		@grupo = buscarGrupo
	end

	def edit
		@grupo = buscarGrupo
		case @grupo.nil?
		when true
			noticiar("Esse grupo não existe")
			redirecionarDefault(list_path)
		end
	end

	def buscarGrupo
		begin
		Grupo.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		nil
		end
	end

	def create
		@grupo = Grupo.new(grupo_params)
		respond_to do |format|
			if @grupo.save
				format.html { redirect_to grupos_url, notice: 'Grupo criado com sucesso.' }
			else
				format.html { render :new }
				format.json { render json: @grupo.errors, status: :unprocessable_entity }
			end
		end
		@grupo.addUser(current_user)
		@grupo.addModerador(current_user)
	end

	def update
		@grupo = Grupo.find(params[:id])
		if eh_moderador(current_user, @grupo)
			if @grupo.update_attributes(grupo_params)
				noticiar("Atualizado com sucesso!")
				redirect_to grupos_path
			else
				respond_to do |format|
					format.html { render :new }
					format.json { render json: @grupo.errors, status: :unprocessable_entity }
				end
			end
		else
			erro("Você precisa de privilégios de administrador pra fazer isso")
		end
	end


	def destroy
		grupo = buscarGrupo
		case grupo.nil?
		when false
			case souAdmin(grupo)
			when true
				case maisDeUmMembro(grupo)
				when false
					buscarGrupo.removerDeTabelaGrupo
					noticiar("Removido com sucesso!")
					redirecionar(list_path)
				else
					noticiar("Erro: Grupo possui mais de um membro!")
					redirecionarDefault(list_path)
				end
			else
				noticiar("Você não é administrador do grupo")
				redirecionarDefault(list_path)
			end
		else
			noticiar("Esse grupo não existe")
			redirecionar(list_path)
		end
	end

	def gruposDe
		todosGrupos = Grupo.all
		@grupos = Array.new
		todosGrupos.each do |g|
			if(g.getUsers().include?(getUser(params[:id])))
		 		@grupos.push(g) #append
			end
		end
		render "grupo/index"
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
			if grupo.getModeradores.length == 1
				erro("Só tem vc de moderador, vc nao pode sair")
				return
			end
			grupo.removerModerador(current_user)
		end

		if eh_mebro_do_grupo(current_user, grupo)
			if grupo.getUsers.length == 1
				erro("Só tem vc no grupo, vc nao pode sair. Apague o grupo")
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

	def atribuirNovoModerador
		grupo  = getGrupo(params[:idGrupo])
		user = getUser(params[:idNovoModerador])

		if eh_moderador(current_user, grupo)
			if eh_mebro_do_grupo(user, grupo)
				if !eh_moderador(user, grupo)
					grupo.addModerador(user)
				else
					erro("Esse usuário já é moderador.")
					return
				end
			else
				erro("Esse usuário não é membro do grupo!")
				return
			end
		else
			erro("Você não tem privilégio para realizar essa ação!")
			return
		end
		redirect_to root_path
	end


	def removerModeracao
		grupo  = getGrupo(params[:idGrupo])
		user = getUser(params[:idModerador])

		if eh_moderador(current_user, grupo)
			if eh_mebro_do_grupo(user, grupo)
				if eh_moderador(user, grupo)
					grupo.removerModerador(user)
				else
					erro("Esse usuário Não é moderador; Não da pra remover um moderador que não é moderador k")
					return
				end
			else
				erro("Esse usuário não é membro do grupo!")
				return
			end
		else
			erro("Você não tem privilégio para realizar essa ação!")
			return
		end
		redirect_to root_path
	end



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


	##############################################################################
	##################################POST########################################
	##############################################################################


	def novoPost

		@post = Post.new
		@post.e_de_grupo = true

		@grupo = getGrupo(params[:id])

		if @grupo.nil?
			erro("Grupo nao existe")
			return
		end

	end



	def salvarPost

		@grupo = getGrupo(params[:id])

		if @grupo.nil?
			erro("Grupo nao existe")
			return
		end

		@post = Post.create(post_params)

		if !(@post.valid?)
			erro("Post invalido")
			return
		end

		@post.e_de_grupo = true
		@post.save
		@post.fixarEmGrupo(@grupo.id)

	end



	##############################################################################
	##############################################################################
	##############################################################################




	#################### DAQUI PRA BAIXO É TUDO PRIVADO ##########################

	private
	def grupo_params
		params.require(:grupo).permit(:nome, :descricao)
	end

	def post_params
		params.require(:post).permit(:titulo, :categoria, :texto, :user_id, :imagem)
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

	def redirecionarDefault path
		redirect_back fallback_location: path
	end

	def redirecionar path
		redirect_to path
	end

	def noticiar mensagem
		flash[:notice] = mensagem
	end

	def souAdmin grupo
		user = grupo.getModeradores
		user.include? current_user
	end

	def maisDeUmMembro grupo
		grupo.getUsers.length > 1
	end


	############## DAQUI PRA BAIXO É TUDO HELPER PRA USAR NA VIEW ############

	helper_method :eh_mebro_do_grupo
	helper_method :eh_moderador
	helper_method :essa_solicitacao_existe


end
