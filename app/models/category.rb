class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_many :children, foreign_key: 'parent_id', class_name: 'CategoryRelationship'
  has_many :parents, foreign_key: 'child_id', class_name: 'CategoryRelationship'
  validates :name, presence: true

  def self.get_tree
    categories = self.all.includes(:children).to_a.index_by(&:id)
    top_relationships = CategoryRelationship.where(parent_id: nil).to_a
    self.build_children_nodes(categories, top_relationships)
  end

  private

  def self.build_children_nodes(categories, relationships)
    relationships.map do |relationship|
      c = categories[relationship.child_id]
      subrelationships = c.children.to_a
      [c, self.build_children_nodes(categories, subrelationships)]
    end
  end
end
