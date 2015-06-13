class Goal < ActiveRecord::Base
  include Commentable
  validates :body, :user, presence: true

  belongs_to :user, inverse_of: :goals

  after_initialize { self.completed ||= false }

  def completed?
    self.completed
  end

  def public?
    self.public
  end


end
