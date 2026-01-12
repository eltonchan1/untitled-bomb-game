extends Label

func _process(delta: float) -> void:
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		var time_str = game_manager.get_time_string()
		var strength = int(game_manager.get_bomb_strength() * 100)
		var p1_stocks = game_manager.player1_stocks
		var p2_stocks = game_manager.player2_stocks
		text = "Time: %s | Bomb Strength: %d%%\nP1 Stocks: %d | P2 Stocks: %d" % [time_str, strength, p1_stocks, p2_stocks]
