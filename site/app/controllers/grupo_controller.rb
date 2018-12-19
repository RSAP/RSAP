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
	#############################SOLICITACOES#####################################
	##############################################################################

	def solicitarMinhaParticiao

		grupo = Grupo.find_by(id: params[:idGrupo])
		user = User.find_by(id: current_user.id)

		if grupo.nil?
			noticiar("Grupo nao existe")
		end
		if essa_solicitacao_existe(user, grupo)
			noticiar("Já existe solicitacao pendente")
		end
		if eh_mebro_do_grupo(user, grupo)
			noticiar("Voce já é membro do grupo")
		end

		grupo.addSolicitacao(user)
		redirect_to grupos_path

	end

	def cancelarMinhaParticiao

		grupo = Grupo.find_by(id: params[:idGrupo])
		user = User.find_by(id: current_user.id)

		if grupo.nil?
			noticiar("Grupo nao existe")
		end
		if !(essa_solicitacao_existe(user, grupo))
			noticiar("Já existe solicitacao pendente")
		end
		if eh_mebro_do_grupo(user, grupo)
			noticiar("Voce já é membro do grupo")
		end

		grupo.removerSolicitacao(user)
		redirect_to grupos_path

	end

	def rejeitarSolicitacao

	end

	def aceitarSolitacao

	end

	##############################################################################
	#############################SOLICITACOES#####################################
	##############################################################################




	private
	def grupo_params
		params.require(:grupo).permit(:nome, :descricao)
	end


	##############################################################################
	#############################SOLICITACOES#####################################
	##############################################################################

	def eh_moderador

	end

	def eh_mebro_do_grupo(user, grupo)

	end

	def essa_solicitacao_existe(user, grupo)

	end

	def noticiar(mensagem)
		flash[:notice] = mensagem
	end


	##############################################################################
	#############################SOLICITACOES#####################################
	##############################################################################

end
