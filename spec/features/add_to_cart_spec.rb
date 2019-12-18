require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "User can click 'Add to Cart' button for a product on the home page and cart increases by one" do
    visit root_path
    page.first('article.product footer.actions button').click
    save_screenshot("home_add_to_cart.png")
    expect(page).to have_css('nav', text: 'My Cart (1)')
  end
end
