class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.paginate(page: params[:page])
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
  	@ingredient = Ingredient.new
  end

  def create
  	@ingredient = Ingredient.new(ingredient_params)
  	if @ingredient.save
      flash[:success] = t('.new_ingredient')
      redirect_to @ingredient
    else
      render 'new'
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update_attributes(ingredient_params)
      flash[:success] = t('.updated_ingredient')
      redirect_to @ingredient
    else
      render 'edit'
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
