extends Node

func _ready():
	test_independent_player_health()
	test_health_cannot_go_below_zero()
	test_health_cannot_exceed_maximum()
	test_health_depleted_signal()

func test_independent_player_health():
	var player1 = Health.new()
	var player2 = Health.new()
	add_child(player1)
	add_child(player2)
	player1.health -= 5
	assert(player1.health == 15, "Player 1 should have 15 HP")
	assert(player2.health == 20, "Player 2 should still have 20 HP")
	print("PASS: Independent player health")
	player1.queue_free()
	player2.queue_free()
	
func test_health_cannot_go_below_zero():
	var player = Health.new()
	add_child(player)
	player.health -= 30
	assert(player.health == 0, "Health should not go below 0")
	print("PASS: Health cannot go below zero")
	player.queue_free()

func test_health_cannot_exceed_maximum():
	var player = Health.new()
	add_child(player)
	player.health += 50
	assert(player.health == 20, "Health should not exceed maximum HP")
	print("PASS: Health cannot exceed maximum")
	player.queue_free()


func test_health_depleted_signal():
	var player = Health.new()
	add_child(player)
	var signal_count = [0]
	player.health_depleted.connect(
		func(): signal_count[0] += 1
	)
	player.health = 0
	assert(signal_count[0] == 1, "Defeat signal should fire once")
	print("PASS: Health depleted signal")
	player.queue_free()
