extends StaticBody2D



func _on_Area2D_body_entered(_body):
	$AnimationPlayer.play("break") # llamando directamente cuesta más memoria
	

func platform_break():
	$CollisionPolygon2D.set_deferred("disable", true)
	$Area2D/CollisionShape2D.set_deferred("disable", true)
	
