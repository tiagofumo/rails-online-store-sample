class Category < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :products

  def self.get_tree
    categories = self.all.to_a

    children_of = Hash.new([])

    # Build children_of
    categories.each do |category|
      parent_id = category.category_id
      if children_of.key?(parent_id)
        children_of[parent_id].push category
      else
        children_of[parent_id] = [category]
      end
    end

    # Sort children
    children_of.each do |parent_id, children|
      children.sort_by! { |node| node.name.upcase }
    end

    self.build_children_nodes(children_of, nil)
  end

  private
    def self.build_children_nodes(children_of, parent_id)
      children_nodes = []

      children_of[parent_id].each do |child|
        grand_children = self.build_children_nodes(children_of, child.id)
        children_nodes.push([child, grand_children])
      end

      children_nodes
    end
end
