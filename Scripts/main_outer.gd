extends Control

var PlayerEntity
var EnemyEntity
@onready var player_skill_box = $PlayerSkillBox
const ENTITY = preload("res://entity.tscn")
const Enemy = preload("res://Mobs/Enemy.tres")

func _ready():
	PlayerEntity = ENTITY.instantiate()
	add_child(PlayerEntity)
	PlayerEntity.LoadEntity(PlayerEntity)
	PlayerEntity.position = Vector2(200,350)
	player_skill_box.initiate(PlayerEntity)
	
	EnemyEntity = ENTITY.instantiate()
	add_child(EnemyEntity)
	EnemyEntity.LoadEntity(Enemy)
	EnemyEntity.position = Vector2(900,350)
