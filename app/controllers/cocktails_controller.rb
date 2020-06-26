class CocktailsController < ApplicationController
    def index
        @cocktails = Cocktail.all
        @new_cocktail = Cocktail.new
    end

    # def new
    #     @cocktail = Cocktail.new
    # end

    def show
        @new_cocktail = Cocktail.new
        @cocktail = Cocktail.find(params[:id])
        @doses = []
        data = Dose.where(cocktail: @cocktail)
        description_data = data.map {|d| d.description}
        ingredient_ids = data.map {|d| d.ingredient_id }
        ingredient_names = ingredient_ids.map {|i| Ingredient.find(i).name }
        ingredients_array = description_data.zip(ingredient_names)
        ingredients_array.each {|a| @doses << (a[0] + a[1]) }
    end

    def create
        @cocktail = Cocktail.new(cocktail_params)
        @cocktail.save
        redirect_to cocktails_path
    end


    private

    def cocktail_params
        params.require(:cocktail).permit(:name)
    end
end
