class RecipesController < ApplicationController

  def index
    @recipes = Recipe.paginate(page: params[:page])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :level, :time)
  end
end
