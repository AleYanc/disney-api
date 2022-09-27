class CreateJoinTableStudiosCharacters < ActiveRecord::Migration[6.1]
  def change
    create_join_table :characters, :studios do |t|
      t.index [:character_id, :studio_id]
      t.index [:studio_id, :character_id]
    end
  end
end
