class CreateJoinTableStudiosProductions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :productions, :studios do |t|
      t.index [:studio_id, :production_id]
      t.index [:production_id, :studio_id]
    end
  end
end
