extends KinematicBody2D

# Vector movimiento
var movement = Vector2.ZERO

export var speed = Vector2(150.0, 150.0)
export var impulse = -3000 # usado al saltar
export var impulse_max = -6000 # máximo impulso hacia arriba que puede llegar
export var gravity = 400
export var rebound = 350

# general
onready var animation = $AnimatedSprite
onready var sound_jump = $sound_jump
onready var camera = $Camera2D

# powerup's
onready var timer_powerup_jump = $TimerPowerUpJump
onready var timer_powerup_fly = $TimerPowerUpFly
onready var animation_player = $AnimationPlayer

# resguardos
var save_impulse
var save_gravity

# si el jugador puede moverse o saltar
var player_free = true


func _ready():
	animation_player.play("player_enter")
	save_impulse = impulse
	save_gravity = gravity


# Retorna -1, 0, 1
func direction():
	var dir = 0
	if player_free:
		dir = Input.get_action_strength("right") - Input.get_action_strength("left")
		if dir == 0:
			animation.play("idle")
		else:
			if dir == -1:
				animation.flip_h = true
			else:
				animation.flip_h = false
			animation.play("walk")
		
	return dir
	

# saltar
func jump():
	if Input.is_action_just_pressed("up") and is_on_floor() and player_free:
		sound_jump.play()
		animation.play("jump")
		impulse_jump()


# Impulso de salto
func impulse_jump():
	movement.y = 0
	movement.y += impulse


# impulsado (ej: golpear la cabeza de un enemigo volador)
func driven():
	movement.y = impulse_max
	
	
# caerse
func fall():
	if not is_on_floor():
		animation.play("jump")
		movement.y += gravity
		movement.y = clamp(movement.y, impulse_max, speed.y)


# tocar el techo
func ceiling():
	if is_on_ceiling():
		movement.y = rebound


# caer al vacío
func fall_void():
	if position.y > camera.limit_bottom:
		respawn()


# volver a empezar
func respawn():
	PlayerData.loss_life()
	animation_player.play("player_exit")
	# Evita que la escena recargue antes de ir al menú de game over
	if PlayerData.lifes != 0:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


# powerup salto
func powerup_jump():
	timer_powerup_jump.start()
	impulse = impulse_max * 0.9


func _on_TimerPowerUp_timeout():
	impulse = save_impulse


# powerup volar
func powerup_fly():
	timer_powerup_fly.start()
	gravity = 200
	animation_player.play("fly")
	impulse_jump()


func _on_TimerPowerUpFly_timeout():
	gravity = save_gravity
	animation_player.play("default")


# entrar al portal
func enter_portal(pos_portal):
	player_free = false
	animation_player.play("portal")
	$Tween.interpolate_property(
		self, # sobre qué nodo
		"global_position", # propiedad a modificarse, formato string
		global_position, # valor inicial, posición del player
		pos_portal, # valor final, el portal en este caso
		0.9, # tiempo de transición
		Tween.TRANS_LINEAR, # forma de transición
		Tween.EASE_IN_OUT # velocidad de transición
	)
	$Tween.start()


#-----------------------------------------------
func _physics_process(_delta):
	# moverse
	movement.x = speed.x * direction()
	jump()
	fall()
	ceiling()
	fall_void()

# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector2.UP) # se encarga de multiplicarlo por delta


# luego de entrar al portal
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "portal":
		animation_player.play("player_exit")
