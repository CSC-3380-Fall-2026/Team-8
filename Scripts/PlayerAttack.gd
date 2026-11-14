extends Node
@export var attack_damage: int = 5

func attack(target: Health) -> void:
	if target == null:
		return
	target.health -= attack_damage
