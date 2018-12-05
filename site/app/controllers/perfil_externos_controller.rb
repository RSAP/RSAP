class PerfilExternosController < ApplicationController
  before_action :set_perfil_externo, only: [:show, :edit, :update, :destroy]

  # GET /perfil_externos
  # GET /perfil_externos.json
  def index
    @perfil_externos = PerfilExterno.all
  end

  # GET /perfil_externos/1
  # GET /perfil_externos/1.json
  def show
  end

  # GET /perfil_externos/new
  def new
    @perfil_externo = PerfilExterno.new
  end

  # GET /perfil_externos/1/edit
  def edit
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
    respond_to do |format|
      if @perfil_externo.update(perfil_externo_params)
        format.html { redirect_to @perfil_externo, notice: 'Perfil externo was successfully updated.' }
        format.json { render :show, status: :ok, location: @perfil_externo }
      else
        format.html { render :edit }
        format.json { render json: @perfil_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfil_externos/1
  # DELETE /perfil_externos/1.json
  def destroy
    @perfil_externo.destroy
    respond_to do |format|
      format.html { redirect_to perfil_externos_url, notice: 'Perfil externo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfil_externo
      @perfil_externo = PerfilExterno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perfil_externo_params
      params.require(:perfil_externo).permit(:nome, :link, :user_id)
    end
end
