extends Control
# "Pause Mode" debe ser "Process" en las interfaces

func _ready():
	visible = false


func _input(event):
	if event.is_action_pressed("Pause"):
		visible = not visible
		get_tree().paused = not get_tree().paused


# Sobre el nodo "MenuPause"
func _on_Continue_pressed():
	get_tree().paused = false
	visible = false


func _on_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Containers/MainMenu.tscn")
