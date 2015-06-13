class UpdateShortenedUrl < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :topic, :string
  end
end
