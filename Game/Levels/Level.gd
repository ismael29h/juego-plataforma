extends Node
signal open_portal

onready var cloud_move = $ParallaxBackground/ParallaxLayer2

var carrots = 0
var container_carrots

export var current_level = ""


func _ready():
# warning-ignore:return_value_discarded
	PlayerData.connect("game_over", self, "_game_over")
	container_carrots = get_node_or_null("Carrots")
	if container_carrots != null:
		carrots_level()


# zanahorias por nivel
func carrots_level():
	carrots = container_carrots.get_child_count()
	PlayerData.update_carrot(carrots)
	for carrot in container_carrots.get_children():
		carrot.connect("use_carrot",self,"remaining_carrots")


# zanahorias restantes
func remaining_carrots():
	carrots -= 1
	if carrots == 0:
		emit_signal("open_portal")


# movimiento nubes de fondo
func _process(_delta):
	cloud_move.motion_offset.x -= -8


# se acabó el juego
func _game_over():
	PlayerData.current_level = current_level
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Containers/MenuGaneOver.tscn")
