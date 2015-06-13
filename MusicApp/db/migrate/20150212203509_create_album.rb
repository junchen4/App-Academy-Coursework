class CreateAlbum < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, null: false

      t.timestamps
    end
  end
end
