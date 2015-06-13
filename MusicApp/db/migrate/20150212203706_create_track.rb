class CreateTrack < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.string :bonus_or_regular, null: false
      t.text :lyrics, null: false

      t.timestamps
    end
  end
end
