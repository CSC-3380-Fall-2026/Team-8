extends Node
var party_members: Array = []
func add_member(character: Node) -> void:
	party_members.append(character)
func get_member(index: int) -> Node:
	if index >= 0 and index < party_members.size():
		return party_members[index]
	return null
func _ready() -> void:
	add_member($Player1)
	add_member($Player2)
