extends Control

@onready var position_manager = $PositionManager

func _ready() -> void:
	$VictoryLabel.hide()
	update_health_labels()
	$VBoxContainer/VanguardButton.pressed.connect(
		func(): position_manager.switch_position(
			position_manager.Position.VANGUARD
		)
	)

	$VBoxContainer/EquilibriumButton.pressed.connect(
		func(): position_manager.switch_position(
			position_manager.Position.EQUILIBRIUM
		)
	)

	$VBoxContainer/RearguardButton.pressed.connect(
		func(): position_manager.switch_position(
			position_manager.Position.REARGUARD
		)
	)

	$VBoxContainer/AttackButton.pressed.connect(_on_attack_pressed)

	$EnemyHPBar.max_value = $EnemyHealth.max_health
	$EnemyHPBar.value = $EnemyHealth.current_health
	$EnemyHPBar.show_percentage = false

	$EnemyHealth.health_changed.connect(_on_enemy_health_changed)
	$EnemyHealth.enemy_died.connect(_on_enemy_died)

	$TurnManager.turn_changed.connect(_on_turn_changed)


func _on_attack_pressed() -> void:
	if $TurnManager.current_turn != $TurnManager.Turn.PLAYER:
		return

	if $EnemyHealth.current_health <= 0:
		return

	var damage: int = position_manager.perform_attack()
	$EnemyHealth.take_damage(damage)

	if $EnemyHealth.current_health > 0:
		$TurnManager.end_turn()


func _on_enemy_health_changed(new_health: int) -> void:
	$EnemyHPBar.value = new_health
	update_health_labels()


func _on_enemy_died() -> void:
	$VictoryLabel.show()
	$VBoxContainer/AttackButton.disabled = true
	print("Victory! Enemy defeated!")


func _on_turn_changed(new_turn: String) -> void:
	var player_turn: bool = new_turn == "PLAYER"
	var enemy_alive: bool = $EnemyHealth.current_health > 0
	var can_act: bool = player_turn and enemy_alive

	$VBoxContainer/AttackButton.disabled = not can_act
	$VBoxContainer/VanguardButton.disabled = not can_act
	$VBoxContainer/EquilibriumButton.disabled = not can_act
	$VBoxContainer/RearguardButton.disabled = not can_act

	if new_turn == "ENEMY":
		enemy_attack()


func enemy_attack() -> void:
	if $PlayerHealth.current_health <= 0:
		return

	var damage: int = 5

	$PlayerHealth.take_damage(damage)

	print("Enemy attacks!")
	print("Damage dealt to player: ", damage)
	print("Player HP: ", $PlayerHealth.current_health)
	$PlayerHPBar.min_value = 0
	$PlayerHPBar.max_value = $PlayerHealth.max_health
	$PlayerHPBar.value = $PlayerHealth.max_health
	$PlayerHPBar.show_percentage = false
	$PlayerHealth.health_changed.connect(_on_player_health_changed)
func _on_player_health_changed(new_health: int) -> void:
	$PlayerHPBar.value = new_health
	update_health_labels()
	
func update_health_labels() -> void:
	$EnemyHPBar/EnemyHPLabel.text = str($EnemyHealth.current_health) + " / " + str($EnemyHealth.max_health) + " HP"
	$PlayerHPBar/PlayerHPLabel.text = str($PlayerHealth.current_health) + " / " + str($PlayerHealth.max_health) + " HP"
