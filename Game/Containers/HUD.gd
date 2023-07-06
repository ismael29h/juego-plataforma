extends Control

onready var tag_life = $ContainerLife/Label
onready var tag_carrot = $ContainerCarrot/Label
onready var tag_gold = $ContainerCoinGold/Label
onready var tag_silver = $ContainerCoinSilver/Label
onready var tag_bronze = $ContainerCoinBronze/Label


func _ready():
# warning-ignore:return_value_discarded
	PlayerData.connect("update_data", self, "update_hud")
	update_hud()


func update_hud():
	# "Data %s" % 13 -> "Data 13"
	tag_life.text = "%s" % PlayerData.lifes
	tag_carrot.text = "%s" % PlayerData.carrots
	tag_gold.text = "%s" % PlayerData.coin_gold
	tag_silver.text = "%s" % PlayerData.coin_silver
	tag_bronze.text = "%s" % PlayerData.coin_bronze
