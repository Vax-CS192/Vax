extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cauldron = preload("res://Scenes/Cauldron/Cauldron.tscn")
var testingArea = preload("res://Scenes/TestingArea/TestingArea.tscn")
var map = preload("res://Scenes/Map/MapUI.tscn")
var shop = preload("res://Scenes/Shop/Shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	cauldron = cauldron.instance()
	testingArea = testingArea.instance()
	map = map.instance()
	shop = shop.instance()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ready_Session():
	map.hide()
	shop.hide()
	get_node("/root/Session").add_child(cauldron)
	get_node("/root/Session").add_child(testingArea)
	get_node("/root/Session").add_child(map)
	get_node("/root/Session").add_child(shop)
	
