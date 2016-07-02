module ApplicationHelper
  def build_categories
    categories = Category.get_tree
    render partial: 'layouts/categories_list', locals: { categories: categories }
  end

  def sidebar_item(item_label, path, className = '')
    render partial: 'layouts/sidebar_item',
           locals: { item_label: item_label, path: path, className: className }
  end

  def content_tag_a(name, array, options = nil)
    content_tag(name, options) do
      array.each do |item|
        concat item
      end
    end
  end

  def select_options(collection, selected = nil)
    options_from_collection_for_select(collection, 'id', 'name', selected)
  end

  def choose_one
    { prompt: '-- Choose One --' }
  end
end
