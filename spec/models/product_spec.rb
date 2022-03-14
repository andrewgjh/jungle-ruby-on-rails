require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:all) do
      @category = Category.new(name: 'Test Category')
      @category.save
    end

    after(:all) do
      @category.destroy
    end

    it 'should have name' do
      @product= @category.products.create(
          name: 'headphones', 
          description: "nice but won't feel bad if lost",
          price: 200,
          quantity: 100, )
      @product.save
      expect(@product[:name]).to eq('headphones')
      expect(@product.valid?).to eq(true)
    end
    it 'should have not save without name' do
      @product= @category.products.create(
          description: "nice but won't feel bad if lost",
          price: 200,
          quantity: 100 )
      @product.save
     
      expect(@product.valid?).to eq(false)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
  
    it 'should have not save without price' do
      @product= @category.products.create(
          name: 'headphones', 
          description: "nice but won't feel bad if lost",
          quantity: 100 )
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product.valid?).to eq(false)
    end
    it 'should have not save without quantity' do
      @product= @category.products.create(
          name: 'headphones', 
          description: "nice but won't feel bad if lost",
          price: 200 )
      @product.save

      expect(@product.valid?).to eq(false)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should have a category.id' do
      @product= @category.products.create(
          name: 'headphones', 
          description: "nice but won't feel bad if lost",
          price: 200, 
          quantity: 200)
      @product.save
      expect(@product[:category_id]).to be_a(Integer)
    end
  end
end
