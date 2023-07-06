extends Area2D
#señal personalizada
signal use_carrot


func _on_body_entered(_body):
	PlayerData.sub_carrot()
	emit_signal("use_carrot")
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("use")
	
