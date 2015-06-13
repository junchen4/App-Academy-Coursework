class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
        t.string :title, null: false
        t.text :description, null:false
        t.integer :mod_id, null:false

      t.timestamps null: false
    end
  end
end
