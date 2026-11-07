extends Node2D

var enemies: Array = []
var action_queue: Array = []
var is_battling: bool = false
var index: int = 0
var battle_over := false

signal next_player
@onready var choice: VBoxContainer = $"../CanvasLayer/Choice"

@onready var player_group = $"../PlayerGroup"

@onready var game_over_label = $"../CanvasLayer/GameOverLabel"

func _ready():
	enemies = get_children()
	
	player_group.all_players_finished.connect(enemy_turn)
	
	for i in enemies.size():
		enemies[i].position = Vector2(0, i*160)
		
	show_choice()

func _process(_delta):
	if battle_over:
			return
	if not choice.visible:
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index, index + 1)
		if Input.is_action_just_pressed("ui_down"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index - 1)
		if Input.is_action_just_pressed("ui_accept"):
			if enemies[index].health <= 0:
				return
			
			_attack_enemy(index)
		
	if action_queue.size() == enemies.size() and not is_battling:
		is_battling = true
		_action(action_queue)


func _attack_enemy(enemy_index):
	
	enemies[enemy_index].take_damage(3)
	
	if all_enemies_defeated():
		print("Victory!")
		return
		
	
	await get_tree().create_timer(1).timeout
	
	player_group.finish_current_player()

func _action(stack):
	
	for i in stack:
		enemies[i].take_damage(2)
		await get_tree().create_timer(1).timeout
		
	if all_enemies_defeated():
		print("Victory!")
		return
		
		
	await enemy_turn()
	
	action_queue.clear()
	is_battling = false
	show_choice()

func enemy_turn():
	
	for enemy in enemies:
		
		if enemy.health <= 0:
			continue
			
		var living_players = []
		
		for player in player_group.players:
			if player.is_alive():
				living_players.append(player)
		if living_players.is_empty():
			return
		var target = living_players.pick_random()
		
		target.take_damage(5)
		
		if all_players_defeated():
			game_over()
			return
		
		
		
		
		await get_tree().create_timer(1).timeout
		
		
		for player in player_group.players:
			player.unfocus()
			
		for i in range(player_group.players.size()):
			if player_group.players[i].health > 0:
				player_group.index = i
				player_group.players[i].focus()
				break
			
			
		
	show_choice()



func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()

func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()
	
func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy.unfocus()
		
func _start_choosing():
	_reset_focus()
	enemies[0].focus()


func _on_attack_pressed():
	choice.hide()
	_start_choosing()
	
	
func all_enemies_defeated() -> bool:
	
	for enemy in enemies:
		if enemy.health > 0: 
			return false
			
	return true

func all_players_defeated() -> bool:
	for player in player_group.players:
		if player.health > 0:
			return false
			
	return true
	
func game_over():
	
	battle_over = true
	
	print("GAME OVER FUNCTION CALLED")
	game_over_label.show()

	choice.hide()

	print("Game Over")
