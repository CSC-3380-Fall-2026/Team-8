extends Control

@onready var active_label = $ActiveLabel
@onready var ailment_button = $AilmentButton
@onready var position_button = $PositionButton

func _ready() -> void:
	ailment_button.disabled = true
	position_button.disabled = true
	active_label.text = "Active: Player 1"
