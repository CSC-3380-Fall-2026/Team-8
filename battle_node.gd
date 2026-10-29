extends Control

signal battle_selected

func _ready() -> void:
	$BattleButton.pressed.connect(_on_battle_pressed)

func _on_battle_pressed() -> void:
	print("Battle node selected!")
	battle_selected.emit()
