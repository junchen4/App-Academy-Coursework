class Sub < ActiveRecord::Base
  validates :description, :mod_id, presence: true
  validates :title, presence: true, uniqueness: true

  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :mod_id
  )
  
end
