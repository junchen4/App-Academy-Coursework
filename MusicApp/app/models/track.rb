class Track < ActiveRecord::Base
  validates :name, :album_id, :bonus_or_regular, :lyrics, presence: true

  belongs_to(
    :albums,
    :class_name => 'Album',
    :foreign_key => :album_id,
    :primary_key => :id
  )

end
