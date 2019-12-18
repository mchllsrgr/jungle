require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "User can navigate from home page to product detail page by clicking on a product" do
    visit root_path
    page.first('article.product footer.actions a').click
    find('article.product-detail')
    save_screenshot("home_to_pdp.png")
    expect(page).to have_css 'article.product-detail'
  end
end
