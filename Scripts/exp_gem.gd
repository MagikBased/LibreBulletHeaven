extends Area2D

@export var experience = 1

var target = null
var speed = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	if experience < 5:
		pass
	elif experience <= 25:
		pass
	else:
		pass

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position,speed)
		speed += 2 * delta

func collect():
	collision.call_deferred("set","disabled",true)
	sprite.visible = false
	queue_free()
	return experience
