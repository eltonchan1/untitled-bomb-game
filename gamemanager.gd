extends Node

var game_time: float = 0.0
var bomb_strength_multiplier: float = 0.5  # Starts at 50%

# Player stocks
var player1_stocks: int = 3
var player2_stocks: int = 3

# Respawn positions
var player1_spawn: Vector3 = Vector3(0, 2, 4.5)
var player2_spawn: Vector3 = Vector3(0, 2, -4.5)

func _process(delta: float) -> void:
	game_time += delta
	
	# Calculate bomb strength: 50% + 10% per minute
	var minutes_elapsed = floor(game_time / 60.0)
	bomb_strength_multiplier = 0.5 + (minutes_elapsed * 0.1)

func get_bomb_strength() -> float:
	return bomb_strength_multiplier

func get_time_string() -> String:
	var minutes = int(game_time) / 60
	var seconds = int(game_time) % 60
	return "%02d:%02d" % [minutes, seconds]

func player_died(player_id: int):
	if player_id == 1:
		player1_stocks -= 1
		if player1_stocks <= 0:
			print("Player 2 Wins!")
			# Handle game over
	elif player_id == 2:
		player2_stocks -= 1
		if player2_stocks <= 0:
			print("Player 1 Wins!")
			# Handle game over

func get_spawn_position(player_id: int) -> Vector3:
	return player1_spawn if player_id == 1 else player2_spawn
