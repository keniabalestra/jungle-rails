require 'rails_helper'

RSpec.describe Product, type: :model do
  #block of code to be run before each example
  before do
    @category = Category.new
    @category.name = "flowering"

    @product = Product.new
    @product.name = "Magnoliophyta"
    @product.price_cents = 100
    @product.quantity = 15
    @product.category = @category
  end

 describe 'Validations' do
  it 'should save product with all four fields' do
    @product.save
    expect(@product).to be_valid
  end

  #validades :name, presence: true
  it 'should not save product without name' do
    @product.name = nil
    @product.save
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end
  
   #validades :price, presence: true
  it 'should not save product without price' do
    @product.price_cents = nil
    @product.save
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end

  #validades :quantity, presence: true
  it 'should not save product without quantity' do
    @product.quantity = nil
    @product.save
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end

     #validades :category, presence: true
  it 'should not save product without category' do
    @product.category = nil
    @product.save
    expect(@product.errors.full_messages).to include("Category can't be blank")
    end
 end
end
