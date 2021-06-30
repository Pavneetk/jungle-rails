require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before :each do
      @cat1 = Category.find_or_create_by! name: 'Apparel'
      @product = @cat1.products.create!({
        name:  'Men\'s Classy shirt',
        price: 64.99,
        quantity: 10,
        description: "Faker::Hipster.paragraph(4)",
        image: 'apparel1.jpg',
      })
    end
    
    it 'is valid with all attributes' do
      expect(@product).to be_valid
    end

    it 'is invalid if missing name' do
      @product.name = nil
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it 'is invalid if missing price' do
      @p1 = @cat1.products.new({
        name:  'Men\'s Classy shirt',
        quantity: 10,
      })
      @p1.save
      expect(@p1).to be_invalid
      expect(@p1.errors.full_messages[0]).to eq("Price cents is not a number")
    end

    it 'is invalid if missing quantity' do
      @product.quantity = nil
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it 'is invalid if missing category' do
      @product.category = nil
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
    end
  
  end
end
