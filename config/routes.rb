Rails.application.routes.draw do

  resources(
    :posts,
    defaults: {format: :json}
  )

  root to: "root#index"

end
