extends Area2D

export var is_trap = false

onready var detector = $RayCast2D

var color = Color.coral


func _ready():
	if is_trap:
		$Sprite.modulate = color
		detector.enabled = true
		rotation_degrees = 180


func _process(_delta):
	if detector.is_colliding():
		detector.set_deferred("enabled", false)
		$AnimationPlayer.play("active")


# Si el jugador toca los pinchos
func _on_body_entered(body):
	#print("Jugador: ", body.name) #visualizar nombre con "name"
	body.respawn()
