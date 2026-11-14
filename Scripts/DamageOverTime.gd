extends Node

@export var damage: int = 2
@export var target: Health

func _ready() -> void:
	var turn_manager = get_tree().get_first_node_in_group("turn_manager")
	if turn_manager != null:
		turn_manager.turn_changed.connect(_on_turn_changed)

func _on_turn_changed(current_turn: String) -> void:
	if current_turn == "PLAYER" and target != null:
		target.health -= damage
