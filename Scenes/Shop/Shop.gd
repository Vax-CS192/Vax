extends Node


func _ready():
	randomize()

func _process(delta):
	#Set Bundle Names
	$ShopControl/Bundle1/Name.text="One"
	$ShopControl/Bundle2/Name.text="Two"
	$ShopControl/Bundle3/Name.text="Three"
	$ShopControl/Bundle4/Name.text="Four"
	$ShopControl/Bundle5/Name.text="Five"
	$ShopControl/Bundle6/Name.text="Six"
	$ShopControl/Bundle7/Name.text="Seven"
	$ShopControl/Bundle8/Name.text="Eight"
	$ShopControl/Bundle9/Name.text="Nine"
	$ShopControl/Bundle10/Name.text="Ten"
	$ShopControl/Bundle11/Name.text="Eleven"
	$ShopControl/Bundle12/Name.text="Twelve"
	$ShopControl/Bundle13/Name.text="Thirteen"

	#Set name colors to compliment tables 
	$ShopControl/Bundle9/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle10/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle11/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle12/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle13/Name.set("custom_colors/font_color",Color(1,1,1,1))
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Lab/Lab.tscn")
