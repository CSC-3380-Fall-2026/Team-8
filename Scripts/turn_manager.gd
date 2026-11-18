extends Node

signal turn_changed(current_turn: String)
signal turn_ended(finished_turn: String)

enum Turn { PLAYER, ENEMY }

var current_turn: Turn = Turn.PLAYER
var active_player_index: int = 0
@onready var party_manager:Node = get_parent()

func _ready() -> void:
	call_deferred("start_player_turn")

func start_player_turn() -> void:
	current_turn = Turn.PLAYER
	var active_player: Node = party_manager.get_member(active_player_index)
	if active_player == null:
		push_error("Active player not found.")
		return
	if active_player_index == 0:
		turn_changed.emit("PLAYER")
	print("Turn started: ", active_player.name)

func start_enemy_turn() -> void:
	current_turn = Turn.ENEMY
	turn_changed.emit("ENEMY")
	print("Turn started: ENEMY")
	await get_tree().create_timer(1.5).timeout
	turn_ended.emit("ENEMY")
	active_player_index = 0
	start_player_turn()

func end_turn() -> void:
	if current_turn != Turn.PLAYER:
		return
	var active_player: Node = party_manager.get_member(active_player_index)
	if active_player == null:
		push_error("Active player not found.")
		return
	
	active_player_index += 1
	if active_player_index < party_manager.party_members.size():
		start_player_turn()
	else:
		turn_ended.emit("PLAYER")
		start_enemy_turn()

func player_attack() -> void: 
	if current_turn != Turn.PLAYER:
		return
	var active_player: Node = party_manager.get_member(active_player_index)
	if active_player == null:
		push_error("Active player not found.")
		return
		
	var attack_component: Node = active_player.get_node_or_null("PlayerAttack")
	var enemy_health: Health = get_parent().get_node_or_null("Enemy/Health") as Health
		
	if attack_component == null or enemy_health == null:
		push_error("Missing PlayerAttack component or enemy Health.")
		return
		
	if enemy_health.health <= 0:
		return
	attack_component.attack(enemy_health)
	print(active_player.name, " attacked! Enemy HP: ", enemy_health.health)
	end_turn()
