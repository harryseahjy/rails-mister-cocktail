class DosesController < ApplicationController
   def new
     @new_cocktail = Cocktail.new
     @cocktail = Cocktail.find(params[:cocktail_id])
     @dose = Dose.new
   end

   def create
     @cocktail = Cocktail.find(params[:cocktail_id])
     ingredient =  Ingredient.find(params[:dose][:ingredient])
     @dose = Dose.new(cocktail: @cocktail, description: params[:dose][:description], ingredient: ingredient)

     if @dose.save
        redirect_to cocktail_path(@cocktail)
     else
        raise
     end
   end


   private

   def dose_params
     params.require(:dose).permit(:description, :cocktail, :ingredient)
   end
end
