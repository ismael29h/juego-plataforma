extends StaticBody2D

onready var animation = $AnimationPlayer


func _ready():
	animation.play("idle")


func _on_Ejection_body_entered(body):
	body.driven()
	animation.play("ejection") # incluye el sonido
