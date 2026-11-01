extends Node

signal turn_changed(current_turn: String)
signal turn_ended(finished_turn: String)

enum Turn { PLAYER, ENEMY }

var current_turn: Turn = Turn.PLAYER

func _ready() -> void:
	start_player_turn()

func start_player_turn() -> void:
	current_turn = Turn.PLAYER
	turn_changed.emit("PLAYER")

func start_enemy_turn() -> void:
	current_turn = Turn.ENEMY
	turn_changed.emit("ENEMY")
	await get_tree().create_timer(1.5).timeout
	turn_ended.emit("ENEMY")
	start_player_turn()

func end_turn() -> void:
	if current_turn != Turn.PLAYER:
		return
	turn_ended.emit("PLAYER")
	start_enemy_turn()
