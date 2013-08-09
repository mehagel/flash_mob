get '/' do
  # Form to create account
  # Form to log in
  erb :index
end

post '/sign_in' do
  # authentication
  # save user id to session
  redirect '/users/:id'
end

post '/sign_up' do
  # create new user
  redirect '/'
end

get '/users/:id' do
  # User Page with user stats
  # Displays all decks to choose from
  erb :user_page
end

post '/rounds/:deck_id' do
  @current_round = prep_the_game(params[:deck_id])
  @round_id = @current_round.id
  p @round_id
  redirect '/rounds/question_screen/' + @round_id.to_s
end

get '/rounds/question_screen/:round_id' do 
  @cards = Round.find(params[:round_id]).deck.cards
  @card = @cards.select { |card| card.shown == false }.sample
  if @card
    @card.shown = true
    @round_id = params[:round_id]
    erb :game_page
  else
    reset_cards(@cards)
    redirect '/users/' + sessions[:id].to_s
  end
end

post '/rounds/:round_id/answer' do
  # store correct/incorrect in session or in round object
end

get '/result_page'  do
  # correct or incorrect
  erb :result_page
end



=begin

1 - Homepage, login, create account
  '/'
  session[:id] = user_id

2 - User page
  '/users/:id'
  displaying decks
  -linked to rounds
  previous rounds (stretch)

3 - Running a Round
  '/rounds/:deck_id'
  Round.create with user_id(session) and deck_id
  -logic
    -shuffle/find deck

in the round model -
  we need method to iterate our deck
 
=end