extends Node

@onready var enemy_health = get_node("../Health")
@onready var defeat_label = get_node("../EnemyDefeatUI/EnemyDefeatLabel")
func _ready():
	enemy_health.health_depleted.connect(defeat_enemy)

func defeat_enemy():
	print("Enemy Defeated!")
	defeat_label.show()
	get_parent().hide()
