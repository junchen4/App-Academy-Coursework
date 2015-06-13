class Question < ActiveRecord::Base
  validates :question_text, :poll_id, :presence => true

  def results

    choices_with_count = self.answer_choices
      .select("answer_choices.*, COUNT(responses.*) AS choice_count")
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.id")


    result_count = Hash.new(0)

    choices_with_count.each do |choice|
      result_count[choice.answer_text] = choice.choice_count
    end

    result_count

  end




  belongs_to(
    :poll,
    :class_name => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  has_many(
    :answer_choices,
    :class_name => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :through => :answer_choices,
    :source => :responses
  )


end
