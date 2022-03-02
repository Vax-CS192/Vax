extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Title.margin_top = -500 # needed to place the title above the middle
	# The values used in computing for margin_top and margin_left were obtained
	# through trial-and-error
	$Buttons.margin_top = (get_viewport_rect().size.y / 5) 
	$Buttons.margin_left = $Buttons.rect_size.x/6.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGame_pressed():
	pass # Go to Cutscene

# when continue is pressed, go to Lab
# still have to load saved stuff
func _on_Continue_pressed():
	get_tree().change_scene("res://Scenes/Lab/Lab.tscn")

# exit
func _on_Exit_pressed():
	get_tree().quit()
