class CategoryRelationship < ActiveRecord::Base
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Category'
  belongs_to :child, foreign_key: 'child_id', class_name: 'Category'
  validates :child_id, presence: true
end
