extends Node

signal turn_changed(current_turn: String)

enum Turn {
	PLAYER,
	ENEMY
}

var current_turn: Turn = Turn.PLAYER

func _ready() -> void:
	print("Combat started!")
	start_player_turn()

func start_player_turn() -> void:
	current_turn = Turn.PLAYER
	print("Player's turn!")
	turn_changed.emit("PLAYER")

func start_enemy_turn() -> void:
	current_turn = Turn.ENEMY
	print("Enemy's turn!")
	turn_changed.emit("ENEMY")

	await get_tree().create_timer(1.5).timeout

	print("Enemy finished its turn!")
	start_player_turn()

func end_turn() -> void:
	if current_turn == Turn.PLAYER:
		start_enemy_turn()
	else:
		start_player_turn()
