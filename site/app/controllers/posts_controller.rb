class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	#Redirecionamento de excecoes
	rescue_from ActiveRecord::RecordNotFound, :with => :post_nao_achado

	# GET /posts/1
	# GET /posts/1.json
	def show
	end

	# GET /posts/new
	def new
		@post = Post.new
	end

	# GET /posts/1/edit
	def edit
	end

	# POST /posts
	# POST /posts.json
	def create
		@post = Post.new(post_params)
		respond_to do |format|
			if @post.save
				format.html { redirect_to @post, notice: 'Post was successfully created.' }
				format.json { render :show, status: :created, location: @post }
			else
				format.html { render :new }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /posts/1
	# PATCH/PUT /posts/1.json
	def update
		#TODO: remover foto se antes era imagem e mudou a categoria
		check_current_user(@post.user_id)
		respond_to do |format|
			if @post.update(post_params)
				format.html { redirect_to @post, notice: 'Post was successfully updated.' }
				format.json { render :show, status: :ok, location: @post }
			else
				format.html { render :edit }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /posts/1
	# DELETE /posts/1.json
	def destroy
		check_current_user(@post.user_id)
		@post.destroy
		respond_to do |format|
			format.html { redirect_to '/home', notice: 'Post was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

		def check_current_user(id_externo)
			id_atual = current_user.id
			if id_atual != id_externo
				raise "Sem permissao"
			end
		end

		# Use callbacks to share common setup or constraints between actions.
		def set_post
			@post = Post.find(params[:id])
		end

		def post_nao_achado
			#TODO: melhorar isso
			redirect_to '/home'
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def post_params
			params.require(:post).permit(:titulo, :categoria, :texto, :user_id, :imagem)
		end
end
