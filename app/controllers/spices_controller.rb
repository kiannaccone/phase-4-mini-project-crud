class SpicesController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def index
    spices = Spice.all
    render json: spices, status: :ok
  end

  def create
    spice = Spice.create(spice_params)
    if spice.valid?
      render json: spice, status: :created
    else
      render json: {errors: spice.errors.full_messages}, status: :unprocessable_entity
    end  
  end

  def update
    spice = Spice.find_by(id: params[:id])
    spice.update!(spice_params)
    render json: spice, status: :ok
  end

  def destroy
    spice = Spice.find_by(id: params[:id])
    spice.destroy
    head :no_content
    # render json: {message: ':( '}, status:
  end

  private

  # def find_spice
  #   Spice.find(params[:id])
  # end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
    # params.require(:spice).permit(:notes, :title, :image, :description, :rating)
  end

  def render_record_not_found
    render json: {error: "record not found"}, status: :not_found
  end

  def render_record_invalid(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :not_found
  end

end
