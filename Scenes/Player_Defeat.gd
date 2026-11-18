extends Node

@onready var player_health = get_node("../Health")
@onready var player_movement: CharacterBody2D = get_parent() as CharacterBody2D

func _ready():
	player_health.health_depleted.connect(defeat_player)

func defeat_player():
	player_movement.velocity = Vector2.ZERO
	player_movement.set_physics_process(false)
	print(player_movement.name, " defeated!")
