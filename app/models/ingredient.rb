class Ingredient < ApplicationRecord

    ALL_INGREDIENTS = Ingredient.all

    has_many :doses
    validates :name, presence: true, uniqueness: { case_sensitive: false}

end
