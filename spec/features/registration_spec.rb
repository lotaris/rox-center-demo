require 'spec_helper'

describe 'Customer Registration' do

  it "should create an adult customer", rox: { key: '13238479e781', data: {
    'gherkin.scenario' => '
      GIVEN a consumer of legal age
      WHEN his form is submitted
      THEN he should be registered
      AND his name and age should appear on the page'
  } } do

    visit 'http://localhost:3001/'

    first_name = random_name()
    last_name = random_name()
    age = 21

    within "#new_person" do
      fill_in 'person[first_name]', with: first_name
      fill_in 'person[last_name]', with: last_name
      fill_in 'person[age]', with: age
    end
    
    click_button 'Submit'

    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name.upcase)
    expect(page).to have_content(age)
  end

  it "should not create an underage customer", rox: { key: '811a25142997', data: {
    'gherkin.scenario' => '
      GIVEN a customer who is underage 
      WHEN his form is submitted
      THEN no customer should be registered
      AND an error message should be displayed'
  } } do

    visit 'http://localhost:3001/'

    first_name = random_name()
    last_name = random_name()
    age = 17

    within "#new_person" do
      fill_in 'person[first_name]', with: first_name
      fill_in 'person[last_name]', with: last_name
      fill_in 'person[age]', with: age.to_s
    end

    expect do

      click_button 'Submit'
      expect(page).not_to have_content(first_name)
      expect(page).not_to have_content(last_name.upcase)
      expect(page).not_to have_content(age)
    end.not_to change(Person, :count)
  end

  def random_name
    (0...12).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
