class CreateJoinTableCharactersProductions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :characters, :productions do |t|
      t.index [:character_id, :production_id]
      t.index [:production_id, :character_id]
    end
  end
end
