class AddTagToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :tag, :string
  end
end
