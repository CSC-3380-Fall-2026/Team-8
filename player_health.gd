extends Node

signal health_changed(current_health: int)
signal player_died

@export var max_health: int = 20

var current_health: int = 20

func _ready() -> void:
	current_health = max_health
	print("Player started with ", current_health, " HP!")

func take_damage(damage: int) -> void:
	if current_health <= 0:
		return

	var actual_damage: int = max(damage, 0)
	current_health = max(current_health - actual_damage, 0)

	print("Player took ", actual_damage, " damage!")
	print("Player HP: ", current_health, "/", max_health)

	health_changed.emit(current_health)

	if current_health == 0:
		print("Player defeated!")
		player_died.emit()

func heal(amount: int) -> void:
	if current_health <= 0:
		return

	current_health = min(current_health + max(amount, 0), max_health)
	health_changed.emit(current_health)
