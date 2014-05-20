require 'spec_helper'

describe 'Customer Registration' do
  let(:random_first_name){ random_name }
  let(:random_last_name){ random_name }

  it "should create a valid customer", scenario: '
    GIVEN a customer
    WHEN his form is completed with his first and last name
    AND the form is submitted
    THEN he should be registered
    AND his name should appear on the page
    AND his last name should be in uppercase' do

    visit 'http://localhost:3001'

    within '#new_person' do
      fill_in 'person[first_name]', with: random_first_name
      fill_in 'person[last_name]', with: random_last_name
    end

    click_button 'Submit'
    expect(page).to have_content(random_first_name)
    expect(page).to have_content(random_last_name.upcase)
  end

  it "should not create an invalid customer", scenario: '
    GIVEN a customer
    WHEN his form is completed but information is missing
    AND the form is submitted
    THEN no customer should be registered
    AND his name should not appear on the page
    AND an error message should be displayed' do

    visit 'http://localhost:3001'

    within '#new_person' do
      fill_in 'person[first_name]', with: random_first_name
    end

    click_button 'Submit'
    expect(page).not_to have_content(random_first_name)
    expect(page).not_to have_content(random_last_name.upcase)
    expect(page).to have_content("Last name can't be blank")
  end

  private

  def random_name
    (0...12).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
