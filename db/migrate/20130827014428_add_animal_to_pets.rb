class AddAnimalToPets < ActiveRecord::Migration
  def change
    add_column :pets, :animal, :string
  end
end
