class RecipesController < ApplicationController

  def index
    @recipes = Recipe.paginate(page: params[:page])
  end

  def new
    @recipe = Recipe.new
  end
  
  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :level, :time)
  end
end
