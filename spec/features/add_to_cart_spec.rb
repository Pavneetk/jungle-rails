require 'rails_helper'

RSpec.feature "Visitor can add to cart and cart increases by 1", type: :feature, js: true do

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

  scenario "Click add" do
    visit root_path
    click_on('Add', match: :first)
    # commented out b/c it's for debugging only
    Capybara.default_max_wait_time = 5
    save_screenshot

    expect(page).to have_content("My Cart (1)")
  end
end