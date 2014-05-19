class PeopleController < ApplicationController

  def create
    @person = Person.new params.require(:person).permit(:first_name, :last_name, :age)
    unless @person.save
      flash[:errors] = @person.errors.full_messages
    end
    redirect_to root_path
  end

  def destroy
    @person = Person.find params[:id].to_i
    @person.destroy
    redirect_to root_path
  end
end
