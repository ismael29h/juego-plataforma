extends Area2D

onready var animation = $AnimationPlayer
onready var detector = $CollisionShape2D


func _on_body_entered(body):
	powerup(body)
	detector.set_deferred("disable", true)
	animation.play("use")


func powerup(_body):
	pass # será sobreescrito por los scripts "hijos"




