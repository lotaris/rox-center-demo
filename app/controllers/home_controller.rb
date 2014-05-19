class HomeController < ApplicationController

  def index
    @person = Person.new
    @people = Person.order('last_name ASC, first_name ASC').to_a
  end
end
