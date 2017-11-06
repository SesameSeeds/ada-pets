class PetsController < ApplicationController
  def index
    pets = Pet.all

    render(
      json: pets.as_json(only: [:age, :id, :human, :name]),status: :ok
    )
  end

  def show

    pet = Pet.find_by(id: params[:id])

    if pet
      render json: pet.as_json(only: [:age, :human, :id, :name]), status: :ok
    else
      render json: { ok: false }, status: :not_found
    end

  end

  def create
    pet = Pet.new(pet_params)
    pet.save!
    render json: { id: pet.id }, status: :ok
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :age, :human)
  end
end
