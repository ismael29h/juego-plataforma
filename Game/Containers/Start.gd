extends Button

export var level_initial = ""

func _on_pressed():
	get_tree().paused = false
	MusicGeneral.replay()
# warning-ignore:return_value_discarded
	get_tree().change_scene(level_initial)

