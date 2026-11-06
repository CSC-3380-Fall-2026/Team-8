extends Node

signal health_changed(current_health: int)
signal enemy_died

@export var max_health: int = 100
var current_health: int

func _ready() -> void:
	current_health = max_health
	print("Enemy spawned with ", current_health, " HP!")

func take_damage(damage: int) -> void:
	if current_health <= 0:
		return

	current_health = max(current_health - max(damage, 0), 0)

	print("Enemy took ", damage, " damage!")
	print("Enemy HP: ", current_health, "/", max_health)

	health_changed.emit(current_health)

	if current_health == 0:
		print("Enemy defeated!")
		enemy_died.emit()
