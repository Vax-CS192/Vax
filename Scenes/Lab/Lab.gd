extends Control 

# This function is run at the start of the scene
func _ready():
	# These are used to place the LabBG sprite on the screen regardless
	# of what the size of the screen would be
	$LabBG.position.x = get_viewport_rect().size.x / 2
	$LabBG.position.y = get_viewport_rect().size.y / 4

# change scene when button to FormulaBook is pressed
# subject to change
func _on_Formula1_pressed():
	get_tree().change_scene("res://Scenes/FormulaBook/FormulaBook.tscn")

# change scene when button to FormulaBook is pressed
# subject to change
func _on_Formula2_pressed():
	get_tree().change_scene("res://Scenes/Shop/Shop.tscn")

<<<<<<< HEAD
# change scene when button to FormulaBook is pressed
# subject to change
func _on_BackToMainMenu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn")

# change scene when button to FormulaBook is pressed
# subject to change
func _on_Formula3_pressed():
	get_tree().change_scene("res://Scenes/TestingArea/TestingArea.tscn")

# change scene when button to FormulaBook is pressed
# subject to change
func _on_Formula4_pressed():
	get_tree().change_scene("res://Scenes/Cauldron/Cauldron.tscn")

# change scene when button to Map is pressed
# can't find Map scene though
func _on_Formula5_pressed():
	pass # Replace with function body.
=======
func _on_Formula3_pressed():
	get_tree().change_scene("res://Scenes/Map/map.tscn")
>>>>>>> Cutscene-Map
