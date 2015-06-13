class Comment < ActiveRecord::Base
  validates :body, :author, :commentable, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :authored_comments
  )



end
