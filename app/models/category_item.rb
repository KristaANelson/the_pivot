class CategoryItem < ActiveRecord::Base
  belongs_to :item_id
  belongs_to :category_id
end
