extends Area2D

onready var animation = $AnimatedSprite
onready var animation_pickup = $AnimationPlayer
onready var collision = $CollisionShape2D

# tipos de monedas (1)
export(String, "gold", "silver", "bronze") var coin_type


func _ready():
	animation.play()


#func _on_CoinBase_body_entered(body):
func _on_body_entered(_body):
	PlayerData.add_coins(coin_type) # (1)
	collision.set_deferred("disable", true) # evita que se repita la animación
	animation_pickup.play("pickup")




