class RecipesController < ApplicationController

  def index
    @recipes = Recipe.paginate(page: params[:page])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = t('.new_recipe')
      redirect_to @recipe
    else
      render 'new'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :level, :time)
  end
end
