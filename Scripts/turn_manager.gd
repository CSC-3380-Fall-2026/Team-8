extends Node

signal turn_changed(current_turn: String)
signal turn_ended(finished_turn: String)

enum Turn { PLAYER, ENEMY }

var current_turn: Turn = Turn.PLAYER
var active_player_index: int = 0
var combat_ended: bool = false
@onready var party_manager:Node = get_parent()

func _ready() -> void:
	call_deferred("begin_player_phase")

func begin_player_phase() -> void:
	if combat_ended:
		return
	current_turn = Turn.PLAYER
	active_player_index = 0
	turn_changed.emit("PLAYER")
	start_player_turn()

func start_player_turn() -> void:
	current_turn = Turn.PLAYER

	while active_player_index < party_manager.party_members.size():
		if is_player_alive(active_player_index):
			var active_player: Node = party_manager.get_member(active_player_index)
			print("Turn started: ", active_player.name)
			return
		active_player_index += 1
	print("NO LIVING PLAYERS AVAILABLE")

func start_enemy_turn() -> void:
	if combat_ended:
		return
	current_turn = Turn.ENEMY
	turn_changed.emit("ENEMY")
	print("Turn started: ENEMY")
	await get_tree().create_timer(1.5).timeout
	if not is_inside_tree() or combat_ended:
		return
	var enemy_health: Health = party_manager.get_node_or_null("Enemy/Health") as Health
	if enemy_health != null and enemy_health.health > 0:
		enemy_attack()
	turn_ended.emit("ENEMY")
	var any_player_alive: bool = false
	for index: int in range(party_manager.party_members.size()):
		if is_player_alive(index):
			any_player_alive = true
			break
	if not any_player_alive:
		combat_ended = true
		print("PARTY DEFEATED: COMBAT ENDED")
		for member: Node in party_manager.party_members:
			var defeat_label: Label = member.get_node_or_null("DefeatUI/DefeatLabel") as Label
			if defeat_label != null:
				defeat_label.text = "PARTY DEFEATED!"
				defeat_label.show()
		return
	begin_player_phase()

func end_turn() -> void:
	if combat_ended or current_turn != Turn.PLAYER:
		return
	active_player_index += 1
	while active_player_index < party_manager.party_members.size():
		if is_player_alive(active_player_index):
			start_player_turn()
			return
		active_player_index += 1
	turn_ended.emit("PLAYER")
	start_enemy_turn()

func player_attack() -> void:
	if combat_ended or current_turn != Turn.PLAYER:
		return
	var active_player: Node = party_manager.get_member(active_player_index)
	if active_player == null:
		push_error("Active player not found.")
		return
	if not is_player_alive(active_player_index):
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
	if enemy_health.health <= 0:
		combat_ended = true
		print("COMBAT ENDED: VICTORY")
		return
	end_turn()

@export var enemy_attack_damage: int = 5
func enemy_attack() -> void:
	var living_members: Array[Node] = []
	for member: Node in party_manager.party_members:
		var member_health: Health = member.get_node_or_null("Health") as Health
		if member_health != null and member_health.health > 0:
			living_members.append(member)

	if living_members.is_empty():
		print("NO LIVING PARTY MEMBERS REMAIN")
		return

	var target: Node = living_members.pick_random()
	var target_health: Health = target.get_node("Health") as Health

	target_health.health -= enemy_attack_damage
	print("Enemy attacked ", target.name, " for ", enemy_attack_damage, " damage!")
	print(target.name, " HP remaining: ", target_health.health)

func is_player_alive(index: int) -> bool:
	var member: Node = party_manager.get_member(index)
	if member == null:
		return false
	var member_health: Health = member.get_node_or_null("Health") as Health
	return member_health != null and member_health.health > 0
