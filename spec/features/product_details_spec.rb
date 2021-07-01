require 'rails_helper'

RSpec.feature "Visitor navigates to product page from home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
       name:  Faker::Hipster.sentence(3),
       description: Faker::Hipster.paragraph(4),
       image: open_asset('apparel1.jpg'),
       quantity: 10,
       price: 64.99
      )
    end
  end

  scenario "Navigate to product page" do
    visit root_path
    click_on(@category.products.first.name)
    # commented out b/c it's for debugging only
    sleep 2
    save_screenshot

    expect(page).to have_content(@category.products.first.description)
  end
end
