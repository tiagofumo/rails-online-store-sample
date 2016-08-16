require "rails_helper"

RSpec.describe Category, :type => :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:children) }
    it { is_expected.to have_many(:parents) }
    it { is_expected.to have_and_belong_to_many(:products) }
  end

  context '#get_tree' do
    before (:each) do
      arduino = FactoryGirl.create(:root_category, name: 'Arduino',
                                                   child_count: 3)
      raspberry_pi = FactoryGirl.create(:root_category, name: 'Raspberry Pi')
      dev_tools = FactoryGirl.create(:root_category, name: 'Develpoment Tools')
      CategoryRelationship.create(parent: dev_tools, child: arduino)
      CategoryRelationship.create(parent: dev_tools, child: raspberry_pi)
      leds = FactoryGirl.create(:category, name: 'LEDs', child_count: 3)
      components = FactoryGirl.create(:root_category, name: 'Components',
                                                      child_count: 5)
      CategoryRelationship.create(parent: components, child: leds)
    end

    it 'returns tree root nodes that match top category relationships' do
      top_relationships = CategoryRelationship.where(parent_id: nil).
                                               order(:child_id).
                                               map{ |cr| cr.child_id }
      top_tree_ids = Category.get_tree.map { |top_node| top_node[0].id }.sort
      expect(top_tree_ids).to match_array(top_relationships)
    end

    it 'returns tree child nodes that match category relationships' do
      categories = Category.all.includes(children: :child).to_a.index_by(&:id)
      tree_to_array(Category.get_tree).each do |node|
        children_ids = categories[node[0]].children.map {|i| i.child_id}.sort
        expect(node[1].sort).to match_array(children_ids)
      end
    end

    def tree_to_array(tree)
      ary_of_arys = tree.map do |node|
        [[ node[0].id, node[1].map{|i| i[0].id}.sort ]] + tree_to_array(node[1])
      end
      ary_of_arys.inject([]) { |flat_ary, ary| flat_ary + ary }
    end
  end
end
