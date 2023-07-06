extends Node

onready var watch_player = $Sprite/RayCast2D
#onready var rays = "res://Game/Particles/Lighting.tscn" # (alternativa)

export var rays: PackedScene # paquete de escenas

#onready var shot = $Sprite/Positions # (No funciona, los nodos no siguen al sprite (1)
onready var positions = [$Sprite/Center, $Sprite/Left, $Sprite/Right]
onready var sfx_ray = $Ray
onready var time = $Timer

var shot = true

#func _ready():
	#print(owner.name) # Level 1	
	
func _process(_delta):
	if watch_player.is_colliding() and shot:
		shock()
		shot = false
		time.start() # cadencia de disparo (2)


func shock():
	sfx_ray.play()
	#for pos in shot.get_children(): # sus nodos hijos (1)
	for pos in positions:
		var now_ray = rays.instance()
		now_ray.create(pos.global_position)
		add_child(now_ray)
		#owner.get_node("Rays").add_child(now_ray) 
		# ver en escena "remoto" en tiempo de ejecución creando un nodo llamado "Rays", 
		# se 'guardan" los rayos allí si no son destruidos


func _on_Timer_timeout(): # (2)
	shot = true
