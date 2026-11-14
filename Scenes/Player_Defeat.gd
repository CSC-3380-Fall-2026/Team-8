extends Node

@onready var player_health = get_node("../Health")
@onready var player_movement = get_parent()
@onready var defeat_label = get_node("../DefeatUI/DefeatLabel")

func _ready():
	player_health.health_depleted.connect(defeat_player)

func defeat_player():
	player_movement.velocity = Vector2.ZERO
	player_movement.set_physics_process(false)
	defeat_label.show()
	print("Player Defeated!")
