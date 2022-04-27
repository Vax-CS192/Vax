extends Button


# Declare member variables here. Examples:
var value = 300000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_MoneyBag_pressed():
	Profile.money += value
	get_parent().remove_child(self)

func set_value(newVal):
	value = newVal
