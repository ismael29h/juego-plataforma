extends KinematicBody2D


onready var animation = $AnimatedSprite
onready var detector_void = $RayCast2D
onready var detector_wall = $RayCast2D2

export var speed = 100.0

var gravity = 150.0
var movement = Vector2.ZERO


func walk():
	detector_collision()
	animation.play("walk")
	movement.x = speed


func fall():
	movement.y = gravity
	animation.play("fall")


func detector_collision():
	# si no está colisionando, dará la media vuelta
	if not detector_void.is_colliding() or detector_wall.is_colliding():
		speed *= -1
		# visible en el inspector
		detector_void.position.x *= -1 # lo coloca del otro lado
		detector_wall.position.x *= -1
		detector_wall.scale *= -1 # invierte la "flecha"
		animation.flip_h = !animation.flip_h # cambio de dirección de la animación


#------------------------------------------------
func _physics_process(_delta):
	if is_on_floor():
		walk()
	else:
		fall()
# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector2.UP)


func _on_Area2D_body_entered(body):
	body.respawn()
