class CreateProductions < ActiveRecord::Migration[6.1]
  def change
    create_table :productions do |t|
      t.string :title
      t.integer :score
      t.date :released_date
      t.string :image

      t.timestamps
    end
  end
end
