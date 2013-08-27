class CreatePetSearches < ActiveRecord::Migration
  def change
    create_table :pet_searches do |t|

      t.timestamps
    end
  end
end
