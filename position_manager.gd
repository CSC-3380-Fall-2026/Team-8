extends Node

signal position_changed(new_position: String)

enum Position {
	VANGUARD,
	EQUILIBRIUM,
	REARGUARD
}

var current_position: Position = Position.EQUILIBRIUM

var equipped_weapons: Dictionary = {
	Position.VANGUARD: "Sword",
	Position.EQUILIBRIUM: "Staff",
	Position.REARGUARD: "Bow"
}
var position_stats: Dictionary = {
	Position.VANGUARD: {
		"attack": 15,
		"defense": 5,
		"range": "Close"
	},
	Position.EQUILIBRIUM: {
		"attack": 10,
		"defense": 10,
		"range": "Medium"
	},
	Position.REARGUARD: {
		"attack": 8,
		"defense": 7,
		"range": "Long"
	}
}
func _ready() -> void:
	print("Position Manager started!")
	show_current_position()

func switch_position(new_position: Position) -> void:
	if current_position == new_position:
		print("Already in this position!")
		return

	current_position = new_position
	print("Position switched!")
	show_current_position()
	position_changed.emit(Position.keys()[current_position])

func show_current_position() -> void:
	var position_name: String = Position.keys()[current_position]
	var weapon_name: String = equipped_weapons[current_position]
	var stats: Dictionary = position_stats[current_position]

	print("Current position: ", position_name)
	print("Equipped weapon: ", weapon_name)
	print("Attack: ", stats["attack"])
	print("Defense: ", stats["defense"])
	print("Range: ", stats["range"])
	print("------------------------")
func perform_attack() -> int:
	var stats: Dictionary = position_stats[current_position]
	var damage: int = stats["attack"]

	print("Attacking from ", Position.keys()[current_position])
	print("Weapon: ", equipped_weapons[current_position])
	print("Damage dealt: ", damage)
	print("------------------------")

	return damage
