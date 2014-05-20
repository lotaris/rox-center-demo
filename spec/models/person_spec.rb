require 'spec_helper'

describe Person do

  it{ should validate_presence_of(:first_name) }
  it{ should validate_presence_of(:last_name) }
  it{ should ensure_length_of(:first_name).is_at_most(50) }
  it{ should ensure_length_of(:last_name).is_at_most(50) }

  describe "with an existing person in the database" do
    before(:each){ create :person }

    it{ should validate_uniqueness_of(:last_name).scoped_to(:first_name).with_message(/have already been taken/) }
  end
end
