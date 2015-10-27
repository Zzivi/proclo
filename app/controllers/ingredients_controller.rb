class IngredientsController < ApplicationController
  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
  	@ingredient = Ingredient.new
  end

  def create
  	@ingredient = Ingredient.new(ingredient_params)
  	if @ingredient.save
      flash[:success] = "New ingredient added!"
      redirect_to @ingredient
    else
      render 'new'
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    flash[:success] = "Ingredient deleted!"
    redirect_to root_url
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description)
  end
end
