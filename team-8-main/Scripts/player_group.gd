extends Node2D

var players:Array = []
var index : int = 0


signal all_players_finished


func _ready():
	players = get_children()
	players[0].focus()
	for i in players.size():
		players[i].position = Vector2(0,i*160)

func current_player():
	return players[index]


		
		

func finish_current_player():
	var old_index = index
	
	while index < players.size() - 1:
		index += 1
		if players[index].health > 0:
			switch_focus(index, old_index)
			$"../EnemyGroup".show_choice()
			return
	all_players_finished.emit()



func switch_focus(x,y):
	players[x].focus()
	players[y].unfocus()
