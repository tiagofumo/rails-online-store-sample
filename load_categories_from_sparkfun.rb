require 'json'
require 'open-uri'
require 'pp'

# Destroy all categories first
Category.where.not(sparkfun_id: nil).delete_all
CategoryRelationship.delete_all

parents = JSON.parse open('./categories.json').read
parents['0'].delete_at 23
parents.delete 'retired'

ids = {}

parents.each do |parent_id, children|
  children.each do |child|
    if !ids.key? child['id']
      category = Category.create name: child['name'], sparkfun_id: child['id']
      ids[child['id']] = category.id
    end
  end
end

parents.each do |parent_id, children|
  children.each do |child|
    p_id = ids[parent_id.to_i]
    c_id = ids[child['id']]
    if !p_id.nil? || parent_id.to_i == 0
      CategoryRelationship.create parent_id: p_id, child_id: c_id
    end
  end
end
