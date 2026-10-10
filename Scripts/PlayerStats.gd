extends Node

var MaxHP:float
var CurrentHP:float
var Str:int = 10
var Int:int = 4
var Dex:int = 3

var Skills:Array[Resource]

 # Likely will be removed later
var Experience:int      
var Level:int

func _ready():
	for skill in ["res://Skills/Attack.tres","res://Skills/S_Attack.tres"]:
		var CurrentSkill = load(skill)
		Skills.append(CurrentSkill)
