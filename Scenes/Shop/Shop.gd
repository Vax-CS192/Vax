extends Node
export (PackedScene) var Bundle1
export (PackedScene) var Bundle2
export (PackedScene) var Bundle3
export (PackedScene) var Bundle4
export (PackedScene) var Bundle5
export (PackedScene) var Bundle6


func _ready():
	randomize()

func _process(delta):
	#Set Bundle Names
	get_node("ShopControl/Bundle1/Label").text = "Blue"
	get_node("ShopControl/Bundle2/Label").text = "Brown"
	get_node("ShopControl/Bundle3/Label").text = "Gray"
	get_node("ShopControl/Bundle4/Label").text = "Green"
	get_node("ShopControl/Bundle5/Label").text = "Purple"
	get_node("ShopControl/Bundle6/Label").text = "Red"


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Lab/Lab.tscn")
