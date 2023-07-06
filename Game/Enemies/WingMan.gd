extends Area2D


var head = false # si pisó la cabeza


onready var c_damage = $CollisionDamage
onready var c_jump = $Area2D/CollisionJump
onready var animation = $AnimationPlayer


#func disable_colliders(colliders):
	#for collider in colliders:
		#collider.set_deferred("disable", true)
		#collider.set_deferred("visible", false)


func _on_Area2D_body_entered(body):
	#disable_colliders([c_damage, c_jump])
	c_damage.set_deferred("disable", true)
	c_jump.set_deferred("disable", true)
	animation.stop()
	animation.play("die") # el audio está manejado por AnimationPlayer
	body.driven()


func _on_WingMan_body_entered(body):
#func _on_body_entered(body): #-> no me funciona así
	body.respawn()
