require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.new(name: "Category")
      @product = described_class.new(name: "Product Name", price: 100, quantity: 1, category: @category)
      expect(@product).to be_valid
      expect(@product.errors.full_messages).to be_empty
    end

    it "is invalid without a name" do
      @category = Category.new(name: "Category")
      @product = described_class.new(name: nil, price: 100, quantity: 1, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "is invalid without a price" do
      @category = Category.new(name: "Category")
      @product = described_class.new(name: "Product Name", price: nil, quantity: 1, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it "is invalid without a quantity" do
      @category = Category.new(name: "Category")
      @product = described_class.new(name: "Product Name", price: 100, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "is invalid without a category" do
      @product = described_class.new(name: "Product Name", price: 100, quantity: 1, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
