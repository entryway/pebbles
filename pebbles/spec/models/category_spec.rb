require File.dirname(__FILE__) + '/../spec_helper'


describe Category do

  before(:each) do
    @categories = Factory(:category, :name => 'products', :position => 0)

    @women = Factory(:category, :name => 'women', :position => 0)
    @women.move_to_child_of @categories
    sub_category = Factory(:category, :name => 'cute-tube', :position => 5)
    sub_category.move_to_child_of @women
    sub_category = Factory(:category, :name => 'tanks', :position => 4)
    sub_category.move_to_child_of @women
    sub_category = Factory(:category, :name => 'short', :position => 2)
    sub_category.move_to_child_of @women
    sub_category = Factory(:category, :name => 'long', :position => 3)
    sub_category.move_to_child_of @women

    @men = Factory(:category, :name => 'men', :position => 1)
    @men.move_to_child_of @categories
    sub_category = Factory(:category, :name => 'crews', :position => 5)
    sub_category.move_to_child_of @men
    sub_category = Factory(:category, :name => 'tanks', :position => 4)
    sub_category.move_to_child_of @men
    sub_category = Factory(:category, :name => 'short-sleeve', :position => 2)
    sub_category.move_to_child_of @men
    sub_category = Factory(:category, :name => 'long-sleeve', :position => 3)
    sub_category.move_to_child_of @men
    
    @categories.root.descendants.size.should == 10 
    @men.children.size.should == 4
    @women.children.size.should == 4
  end

  it 'is active' do
    cute_tube = @women.descendants[0]
    cute_tube.active = false
    cute_tube.save!

    womens = @women.active_descendants
    womens[0].name.should_not == 'cute-tube'
  end

  it 'is ordered by position' do
    sorted = Category.positioned
    sorted[0].position.should == 0
    sorted[1].position.should == 1
    sorted[2].position.should == 2
    sorted[3].position.should == 2
    sorted[4].position.should == 3
    sorted[5].position.should == 3
    sorted[6].position.should == 4
    sorted[7].position.should == 4
    sorted[8].position.should == 5
    sorted[9].position.should == 5


    sorted = @men.positioned 
    sorted[0].position.should == 2
    sorted[1].position.should == 3
    sorted[2].position.should == 4
    sorted[3].position.should == 5
   end

  it 'is ordered alphabetically' do
    sorted = @men.alphabetical
    sorted[0].name.should == 'crews'
    sorted[1].name.should == 'long-sleeve'
    sorted[2].name.should == 'short-sleeve'
    sorted[3].name.should == 'tanks'

    sorted = Category.alphabetical 
    sorted[0].name.should == 'crews'
    sorted[1].name.should == 'cute-tube'
    sorted[2].name.should == 'long'
    sorted[3].name.should == 'long-sleeve'
    sorted[4].name.should == 'men'
  end

  it 'a specific category is sorted by position' do
    categories = Category.tree('bunk')
    categories.empty?.should == true

    categories = Category.tree('men') 
    categories[0].name.should == 'short-sleeve'
    categories[1].name.should == 'long-sleeve'
    categories[2].name.should == 'tanks'
    categories[3].name.should == 'crews'
  end

end
