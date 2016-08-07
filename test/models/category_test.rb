require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:arduino)
  end

  test "Category should be valid" do
    assert @category.valid?
  end

  test "Category without a name should not be valid" do
    @category.name = ''
    assert_not @category.valid?
  end

  test "Category's children should not be empty" do
    assert_not @category.children.empty?
  end

  test "Category tree nodes should match category relationships" do
    categories = Category.all.includes(children: :child).to_a.index_by(&:id)
    tree_to_array(Category.get_tree).each do |node|
      should_be = categories[node[0]].children.map {|i| i.child_id}.sort
      assert(node[1].sort == should_be,
             "Children array of #{node[0]}:#{categories[node[0]].name}, " \
             "should be #{should_be} but was #{node[1]}")
    end
  end

  def tree_to_array(tree)
    ary_of_arys = tree.map do |node|
      [[ node[0].id, node[1].map{ |i| i[0].id }.sort ]] + tree_to_array(node[1])
    end
    ary_of_arys.inject([]) { |flat_ary, ary| flat_ary + ary }
  end
end
