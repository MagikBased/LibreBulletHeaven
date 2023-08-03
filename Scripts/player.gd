extends CharacterBody2D

var move_speed = 40.0


func _physics_process(_delta):
	movement()
	
func movement():
	var mov = Input.get_vector("left","right","up","down")
	velocity = mov.normalized()*move_speed
	move_and_slide()
