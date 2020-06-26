class CocktailsController < ApplicationController
    def index
        # Existing cocktails
        @cocktails = Cocktail.all
        # New Cocktail -- see navbar
        @new_cocktail = Cocktail.new
    end

    # def new
    #     @cocktail = Cocktail.new
    # end

    def show
        # Displays dose information

        @cocktail = Cocktail.find(params[:id])
        @doses = []
        data = Dose.where(cocktail: @cocktail)
        description_data = data.map {|d| d.description}
        ingredient_ids = data.map {|d| d.ingredient_id }
        ingredient_names = ingredient_ids.map {|i| Ingredient.find(i).name }
        ingredients_array = description_data.zip(ingredient_names)
        ingredients_array.each {|a| @doses << (a[0] + a[1]) }
        # Form for another new dose
        @new_dose = Dose.new
        # Form for new cocktail
        @new_cocktail = Cocktail.new
        # Form for new photo
    end

    def create
        @new_cocktail = Cocktail.new(cocktail_params)

        if @new_cocktail.save
          redirect_to cocktail_path(@new_cocktail)
        end

    end


    private

    def cocktail_params
        params.require(:cocktail).permit(:name, :photo)
    end

end
