extends "res://Game/Objects/Items/PowerUpBase.gd"


func _ready():
	pass


func powerup(body):
	body.powerup_jump()
