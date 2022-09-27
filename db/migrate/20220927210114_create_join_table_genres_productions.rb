class CreateJoinTableGenresProductions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :genres, :productions do |t|
      t.index [:genre_id, :production_id]
      t.index [:production_id, :genre_id]
    end
  end
end
