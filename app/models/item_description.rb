class ItemDescription < ApplicationRecord
  #
  # validations
  #

  validates_uniqueness_of :item_name, scope: [:tree_id]

  #
  # associations
  #
  belongs_to :tree
  has_many_attached :images

end
