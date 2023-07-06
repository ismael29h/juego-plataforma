extends Area2D

export var speed = 500

onready var animation = $AnimatedSprite

# la posición debe ser global
# o el rayo se distorsionará conforme la nube se mueva
var my_pos = Vector2.ZERO


func _ready():
	global_position = my_pos # (x, y)
	
	animation.play("lighting")


func _process(delta):
	global_position.y += speed * delta


func create(pos):
	my_pos = pos


func destroy():
	queue_free()


func _on_Lighting_body_entered(body):
	if body.is_in_group("player"): # el grupo permite manejar varios jugadores
		body.respawn()
	destroy()


# si sale del viewport o la vista del jugador
func _on_VisibilityNotifier2D_screen_exited():
	destroy()
