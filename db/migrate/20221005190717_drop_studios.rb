class DropStudios < ActiveRecord::Migration[6.1]
  def change
    drop_table :studios
  end
end
