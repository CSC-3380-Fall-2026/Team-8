extends ProgressBar

@onready var player_health = get_node("../Health")
func _ready():
	max_value = player_health.max_health
	value = player_health.health
	player_health.health_changed.connect(update_health_bar)
	
func update_health_bar(_diff : int):
	value = player_health.health
