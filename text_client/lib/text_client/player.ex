defmodule TextClient.Player do
	
	alias TextClient.{Mover, Prompter, State, Summary}

	# Won, Lost, Good Guess, Bad Guess, Already Used, initializing
	def play(%State{tally: %{game_state: :won}}) do
		exit_with_message("You WON !")
	end

	def play(%State{tally: %{game_state: :lost}}) do
		exit_with_message("Sorry, You Lost. Game Over")
	end

	def play(game = %State{tally: %{game_state: :good_guess}}) do
		continue_with_msg(game, "Correct Guess!")
	end

	def play(game = %State{tally: %{game_state: :bad_guess}}) do
		continue_with_msg(game, "Incorrect Guess")
	end

	def play(game = %State{tally: %{game_state: :already_used}}) do
		continue_with_msg(game, "You've already used that letter, try again.")
	end

	def play(game) do
		continue(game)
	end

	def continue_with_msg(game, msg) do
		IO.puts(msg)
		continue(game)
	end
	def continue(game) do 
		game
		|> Summary.display()
		|> Prompter.accept_move()
		|> Mover.move()
		|> play()
	end

	def make_move(game) do
		game
	end

	defp exit_with_message(msg) do
		IO.puts(msg)
		exit(:normal)
	end


end