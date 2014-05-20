require 'spec_helper'

describe 'Customer Registration' do
  let(:random_first_name){ random_name }
  let(:random_last_name){ random_name }

  it "should create an adult customer", rox: { key: '13238479e781', data: {
    'gherkin.scenario' => '
      GIVEN a consumer of legal age
      WHEN his form is submitted
      THEN he should be registered
      AND his name and age should appear on the page'
  } } do

    visit 'http://localhost:3001/'

    within "#new_person" do
      fill_in 'person[first_name]', with: random_first_name
      fill_in 'person[last_name]', with: random_last_name
      fill_in 'person[age]', with: 21
    end
    
    click_button 'Submit'

    expect(page).to have_content(random_first_name)
    expect(page).to have_content(random_last_name.upcase)
    expect(page).to have_content(21)
  end

  it "should not create an underage customer", rox: { key: '811a25142997', data: {
    'gherkin.scenario' => '
      GIVEN a customer who is underage 
      WHEN his form is submitted
      THEN no customer should be registered
      AND an error message should be displayed'
  } } do

    visit 'http://localhost:3001/'

    within "#new_person" do
      fill_in 'person[first_name]', with: random_first_name
      fill_in 'person[last_name]', with: random_last_name
      fill_in 'person[age]', with: 17.to_s
    end

    expect do

      click_button 'Submit'
      expect(page).not_to have_content(random_first_name)
      expect(page).not_to have_content(random_last_name.upcase)
      expect(page).not_to have_content(17)
    end.not_to change(Person, :count)
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
