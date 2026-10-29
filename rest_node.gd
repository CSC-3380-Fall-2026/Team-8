extends Control

signal rest_selected

func _ready() -> void:
	$RestButton.pressed.connect(_on_rest_pressed)

func _on_rest_pressed() -> void:
	print("Rest node selected!")
	rest_selected.emit()
