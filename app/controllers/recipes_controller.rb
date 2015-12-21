class RecipesController < ApplicationController

  def index
    @recipes = Recipe.paginate(page: params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredient_quantities = @recipe.ingredient_quantities.paginate(page: params[:page])
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

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      flash[:success] = t('.updated_recipe')
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = t('.delete_recipe')
    redirect_to root_url
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :level, :time)
  end
end
