class PerfilExternosController < ApplicationController
	before_action :set_perfil_externo, only: [:show, :edit, :update, :destroy]

	# GET /perfil_externos/1
	# GET /perfil_externos/1.json
	def show
		if !(logado)
			@perfil_externo = PerfilExterno.all
		else
			redirecionarDefault('/')
		end
	end

	def logado
		current_user.nil?
	end
	# GET /perfil_externos/new
	def new
		@perfil_externo = PerfilExterno.new
	end

	# GET /perfil_externos/1/edit
	def edit
		begin
			case logado
			when false
				@perfil_externo = PerfilExterno.find(params[:id])
				case donoPerfil(@perfil_externo)
				when false
					noticiar("Você não pode fazer isso")
					redirect_to "/"
				end
			else
				redirecionarDefault('/')
			end
		rescue ActiveRecord::RecordNotFound
			noticiar("Perfil externo inexistente")
			redirect_to "/"
		end
	end


	def friend_perfil_externo
		begin
			@user = User.find(params[:id])
			case amigos(@user)
			when true
				@perfil_externo = PerfilExterno.where(user_id: params[:id])
			else
				noticiar("Vocês não são amigos")
				redirecionarDefault(perfil_externo_path)
			end
		rescue ActiveRecord::RecordNotFound
			noticiar("Usuario não encontrado!")
			redirecionarDefault(perfil_externo_path)
		end
	end

	def amigos user
		current_user.friends.include? user
	end

	# POST /perfil_externos
	# POST /perfil_externos.json
	def create
		@perfil_externo = PerfilExterno.new(perfil_externo_params)
		@perfil_externo.user_id = current_user.id

		respond_to do |format|
			if @perfil_externo.save
				format.html { redirect_to @perfil_externo, notice: 'Perfil externo was successfully created.' }
				format.json { render :show, status: :created, location: @perfil_externo }
			else
				format.html { render :new }
				format.json { render json: @perfil_externo.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /perfil_externos/1
	# PATCH/PUT /perfil_externos/1.json
	def update
		@perfil_externo = PerfilExterno.find(params[:id])
		if @perfil_externo.update_attributes(perfil_externo_params)
			noticiar("Atualizado com sucesso!")
			redirect_to perfil_externo_path
		else
		respond_to do |format|
			format.html { render :new }
			format.json { render json: @perfil_externo.errors, status: :unprocessable_entity }
		end
		end
	end



	# DELETE /perfil_externos/1
	# DELETE /perfil_externos/1.json
	def destroy
		begin
			perfil =  PerfilExterno.find(params[:id])
			case perfil.nil?
			when true
				noticiar("Esse perfil não existe")
			else
				case donoPerfil(perfil)
				when true
					perfil.destroy
					noticiar("Deletado com sucesso")
					redirecionarDefault(perfil_externo_path)
				else
					noticiar("Você não tem permissão para isso")
					redirecionarDefault(perfil_externo_path)
				end
			end
		rescue ActiveRecord::RecordNotFound
			noticiar("Usuario não encontrado!")
			redirecionarDefault(perfil_externo_path)
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_perfil_externo
		begin
			@perfil_externo = PerfilExterno.find_by(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to "/perfil_externos/new"
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def perfil_externo_params
		params.require(:perfil_externo).permit(:nome, :link, :user_id)
	end

	def redirecionarDefault path
		redirect_back fallback_location: path
	end

	def noticiar mensagem
		flash[:notice] = mensagem
	end

	def donoPerfil perfil
		current_user.id.eql? perfil.user_id
	end
end
