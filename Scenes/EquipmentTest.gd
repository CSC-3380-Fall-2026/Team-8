extends Node

func _ready() -> void:
	var weapons: Array[WeaponData] = [
		load("res://Equipment/FlameSword.tres"),
		load("res://Equipment/WaterStaff.tres"),
		load("res://Equipment/EarthHammer.tres")
	]
	for weapon in weapons:
		print("Weapon: ", weapon.weapon_name)
		print("Type: ", weapon.weapon_type)
		print("Damage: ", weapon.damage)
		print("Ailments: ", weapon.ailments)
		print("---")
