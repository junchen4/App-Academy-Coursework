class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll

  def sibling_responses
  #  p self.id
    if self.id.nil?
      question.responses
    else
      question.responses.where("responses.id != ?", id)
    end
  end




  belongs_to(
    :respondent,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
    :answer_choice,
    :class_name => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
  )

  has_one(
    :question,
    :through => :answer_choice,
    :source => :question
  )

  private
  def respondent_has_not_already_answered_question

    if sibling_responses.exists?
      errors[:question]<< "Respondant has already answered question"
    end

  end

  def author_cannot_respond_to_own_poll

    if answer_choice.question.poll.author_id == user_id
      errors[:respondant] << "Poll author cannot answer question"
    end

  end


end
