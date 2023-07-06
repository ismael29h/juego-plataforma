extends Area2D

# conviene modificarlo desde la escena instanciada
export var next_level = "" # ruta al siguiente nivel

var active = false


func _ready():
# warning-ignore:return_value_discarded
	get_parent().connect("open_portal", self, "play_animation")


func _on_body_entered(body):
	if active:
		# no se puede llamar directamente a animationplayer
		body.enter_portal(global_position)
		#yiedl, "pausará" el código hasta que haya pasado 1 seg
		yield(get_tree().create_timer(1.0), "timeout")
		enter_next_level()


# siguiente nivel
func enter_next_level():
	#get_tree() árbol
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)


func play_animation():
	active = true
	$AnimatedSprite.play("portal")
	$AnimationPlayer.play("active")
