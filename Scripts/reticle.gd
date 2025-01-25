extends Sprite2D

var reticle_distance : float = 100  # distance from player to reticle
@onready var player = get_parent()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	var mouse_position = get_global_mouse_position()
	var direction_to_mouse = (mouse_position - player.global_position).normalized()

	global_position = player.global_position + direction_to_mouse * reticle_distance
