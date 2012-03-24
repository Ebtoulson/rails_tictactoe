Tictactoe::Application.routes.draw do
  root :to => "play#index"
  match "/play" => "play#show", :as => "play"
  match "/move" => "play#edit", :as => "move"
  match "/new_game" => "play#new", :as => "new"
end
