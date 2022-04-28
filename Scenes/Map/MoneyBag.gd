extends Button

# Declare member variables here. Examples:
var value = 300000
var region = 100
onready var MapUI = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_MoneyBag_pressed():
	Profile.money += value
	MapUI.dict[region]["collect"] = false
	MapUI.dict[region]["disabled"] = false
	MapUI.enable_region(region)
	MapUI.get_child(4).get_child(region).first = false
	MapUI.save_dict()
	queue_free()

func set_value(newVal, index):
	value = newVal
	region = index
