extends Node
signal update_data()
signal game_over()


var lifes = 3
var carrots = 0
var coin_gold = 0
var coin_silver = 0
var coin_bronze = 0
var current_level = "" # error mío, este es el nivel de reinicio
var score = 0
var record = 0


# al morir
func loss_life():
	lifes -= 1
	if lifes < 1:
		emit_signal("game_over")
	emit_signal("update_data")


# al tomar una zanahoria
func sub_carrot():
	carrots -= 1
	emit_signal("update_data")


# actualizar número de zanahorias por nivel
func update_carrot(num):
	carrots = num
	emit_signal("update_data")


# al tomar una moneda
func add_coins(coin):
	match coin:
		"gold":
			coin_gold += 1
		"silver":
			coin_silver += 1
		"bronze":
			coin_bronze += 1
		_:
			pass
	emit_signal("update_data")


# resetear en caso de game over
func reset():
	coin_gold = 0
	coin_silver = 0
	coin_bronze = 0	
	lifes = 3
	#score = 0 no hace falta


# puntajes
func generate_score():
	var score_gold = coin_gold * 10
	var score_silver = coin_silver * 5
	var score_bronze = coin_bronze * 2
	score = score_gold + score_silver + score_bronze
	if score > record:
		record = score # Récord del total jugado
	return score
