class AddColsToAlbum < ActiveRecord::Migration
  def change
    add_column(:albums, :live_or_studio, :string)
  end
end
