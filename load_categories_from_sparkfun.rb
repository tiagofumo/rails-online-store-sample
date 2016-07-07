require 'json'
require 'open-uri'
require 'pp'

# Destroy all categories first
# Category.where.not(sparkfun_id: nil).destroy_all

categories = JSON.parse open('./categories.json').read

def walk_tree(array, parent_id, categories)
  array.each do |node|
    id = node['id'].to_s
    category = Category.create name: node['name'],
                               sparkfun_id: id,
                               category_id: parent_id
    if categories.key? id
      walk_tree(categories[id], category.id, categories)
    end
  end
end

walk_tree(categories['0'], nil, categories)
