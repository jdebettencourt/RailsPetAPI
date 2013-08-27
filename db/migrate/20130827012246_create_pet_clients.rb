class CreatePetClients < ActiveRecord::Migration
  def change
    create_table :pet_clients do |t|

      t.timestamps
    end
  end
end
