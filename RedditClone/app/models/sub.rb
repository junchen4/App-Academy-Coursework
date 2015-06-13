class Sub < ActiveRecord::Base
  validates :description, :mod_id, presence: true
  validates :title, presence: true, uniqueness: true

  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :mod_id
  )

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :sub_id
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

end
