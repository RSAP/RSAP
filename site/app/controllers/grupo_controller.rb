class GrupoController < ApplicationController

	#TODO: todas as checageens de grupo, creio que o model já ta todo ok


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

	end

	def buscarGrupo
		grupo = Grupo.find(params[:id])
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
		@grupo.addModerador(current_user)
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
		begin
			grupo = buscarGrupo
			case souAdmin(grupo)
			when true
				case maisDeUmMembro(grupo)
				when false
					buscarGrupo.removerDeTabelaGrupo(current_user)
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
		rescue ActiveRecord::RecordNotFound
			noticiar("Esse grupo não existe")
			redirecionar(list_path)
		end
	end

	private
	def grupo_params
		params.require(:grupo).permit(:nome, :descricao)
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


end
