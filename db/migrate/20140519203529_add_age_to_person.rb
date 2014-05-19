class AddAgeToPerson < ActiveRecord::Migration
  def change
    add_column :people, :age, :integer, null: false, default: 18
  end
end
