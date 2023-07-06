extends Control


func _ready():
	$Score.text = "Puntaje: {s}".format({"s":PlayerData.generate_score()})
	$Record.text = "Récord: {r}".format({"r":PlayerData.record})
	PlayerData.reset()


func _on_Menu_pressed():
	MusicGeneral.replay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Containers/MainMenu.tscn")
