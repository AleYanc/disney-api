class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.float :weight
      t.string :history
      t.string :image

      t.timestamps
    end
  end
end
