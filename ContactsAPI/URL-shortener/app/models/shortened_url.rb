class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :submitter_id, :long_url, :presence => true
  validate :topic_does_not_exist


  def self.create_for_user_and_long_url!(user, long_url, topic = "misc")
    create!({:submitter_id => user.id,
      :long_url => long_url,
      :short_url => random_code,
      :topic => topic})
  end

  def self.random_code
    code = nil
    until code
      unless ShortenedUrl.where("short_url = 'code'").exists?
        code = SecureRandom.urlsafe_base64
      end
    end

    code
  end

  def self.most_popular_links_in(category)
    ShortenedUrl.where("topic = ?",category).group(:long_url).limit(2)
  end

  def self.most_popular_links_for(category)
    # ShortenedUrl.references(:tagging).where("tagging.shortened_url_id")

    ShortenedUrl.joins("JOIN tagging ON .id = tagging.shortened_url_id").
      joins("JOIN tag_topics ON tagging.topic_id = tag_topic.id").
      where("? = tag_topic.topic", category).group(:long_url).
      order('COUNT(*) DESC').limit(2)
    #
    #
    # SELECT
    #   url.*
    # FROM
    #   shortened_url AS url
    # JOIN
    #   tagging
    # ON
    #   url.id = tagging.shortened_url_id
    # WHERE
    #   tagging.shortened_url_id = (
    #       SELECT id
    #       FROM tag_topics
    #       WHERE topic = category
    #       )
    # GROUP BY
    #   url.long_url
    # ORDER BY
    #   COUNT(*)
    # LIMIT
    #   2;)
  end

  def num_clicks
    Visit.where("shortened_url_id = ?", id).count
  end

  def num_uniques
    #Visit.where("shortened_url_id = ?", id).select('user_id').distinct.count
    #Replace with:
    self.visitors.count
  end

  def num_recent_uniques
    Visit.where("shortened_url_id = ?", id).select('user_id').
      where("created_at > ?", 1.minutes.ago).distinct.count
  end

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => 'Visit',
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    Proc.new { distinct }, #same as: -> { distinct }
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  private
  def topic_does_not_exist
    topics = ["misc", "news", "tech",  "sport"]
    if !topics.include?(topic)
      errors[:topic] << " does not exist!"
    end
  end
end
