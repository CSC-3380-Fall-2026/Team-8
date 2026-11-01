extends Node

signal ailment_expired(ailment: String)

@export_enum("PLAYER", "ENEMY") var owner_turn: String = "PLAYER"

var ailments: Dictionary = {}

func _ready() -> void:
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	if turn_manager != null:
		turn_manager.turn_ended.connect(_on_turn_ended)

func _on_turn_ended(finished_turn: String) -> void:
	if finished_turn == owner_turn:
		end_turn()

func add_ailment(ailment: String, turns: int) -> void:
	if turns > 0:
		ailments[ailment] = turns

func end_turn() -> void:
	for ailment in ailments.keys():
		ailments[ailment] -= 1
		if ailments[ailment] == 0:
			ailments.erase(ailment)
			ailment_expired.emit(ailment)
