module GoalsHelper


  def all_public_goals
    Goal.where(public: true).where.not(user: current_user)
  end

end
