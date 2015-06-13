# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

nick = User.create({user_name: "Nick"})
test1 = User.create({user_name: "test1"})
test2 = User.create({user_name: "test2"})
test3 = User.create({user_name: "test3"})

poll1 = Poll.create({title: "poll 1", author_id: 1})

question1 = Question.create({question_text: "what is your fav color?", poll_id: 1})

AnswerChoice.create({answer_text: "Blue", question_id: 1})
AnswerChoice.create({answer_text: "Red", question_id: 1})
AnswerChoice.create({answer_text: "Green", question_id: 1})


Response.create({user_id: 2, answer_choice_id: 2})
