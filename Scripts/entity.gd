extends Control

@export var HealthNode:Node
@export var AttackNode:Node
@onready var entity_sprite = $EntitySprite
@onready var health_bar = $HealthBar
# Target
var CurrentTarget:Array

#Stats
var Str:int
var Dex:int
var Int:int


func _ready():
	entity_sprite.play("Idle")

func _process(delta):
	health_bar.value = HealthNode.CurrentHP/HealthNode.MaxHP

func LoadEntity(TargetRes):
	# This if statement is meant to check if
	#something has the players stats. If it does, it flips
	#the sprite since they'll likely be an enemy.
	# But this testing thing I made might be using 
	# two players as neither of them flip, and I can't
	# figure out how to get it right. 
	if TargetRes == PlayerStats:
		entity_sprite.flip_h = true
	Str = TargetRes.Str
	Dex = TargetRes.Dex
	Int = TargetRes.Int
	
	
	# for some reason these lines cause errors I have
	# no idea how to remove
	HealthNode.MaxHP = TargetRes.MaxHP 
	HealthNode.CurrentHP = TargetRes.MaxHP
	
	AttackNode.LoadSkills(TargetRes.Skills)
	HealthNode.Death.connect(Death)

func ReceivedDamage(amount, type):
	HealthNode.TakeDamage(amount,type)

func Death(): 
	queue_free()


func _on_entity_sprite_animation_finished():
	if HealthNode.currentHealth > 0:
		entity_sprite.play("Idle")
