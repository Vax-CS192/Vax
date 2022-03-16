# Author: John Henry A. Galino
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without 
# fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.

extends Control 

# preload to make main menu scene and template pop-up switch faster
var mainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn")
var templatePopUp = preload("res://Scenes/Lab/TemplatePopUp.tscn")

# This function is run at the start of the scene
func _ready():
	# Since we need to connect signals from the instantiated ButtonContainer,
	# we have to manually get a reference to those buttons using code and
	# connect the signals to this script manually
	var cauldronButton = get_node("ButtonContainer/Cauldron")
	var shopButton = get_node("ButtonContainer/Shop")
	var mapButton = get_node("ButtonContainer/Map")
	var testButton = get_node("ButtonContainer/Testing")
	
	cauldronButton.connect("pressed", self, "_on_cauldronButton_pressed")
	shopButton.connect("pressed", self, "_on_shopButton_pressed")
	mapButton.connect("pressed", self, "_on_mapButton_pressed")
	testButton.connect("pressed", self, "_on_testButton_presed")
	
	# if new game, then start timer
	if Profile.is_new_game == true:
		$Timer.start()

# change scene when button to FormulaBook is pressed
# subject to change
func _on_BackToMainMenu_pressed():
	Profile.save_data()
	get_tree().change_scene_to(mainMenu)

# change scene to Cauldron when cauldron button is pressed
func _on_cauldronButton_pressed():
	get_tree().change_scene("res://Scenes/Cauldron/Cauldron.tscn")

# changes scene to shop when shop button is pressed
func _on_shopButton_pressed():
	get_tree().change_scene("res://Scenes/Shop/Shop.tscn")
	
# changes scene to Map when map button is pressed
func _on_mapButton_pressed():
	get_tree().change_scene("res://Scenes/Map/MapUI.tscn")

# change scene to Testing when Test button is pressed
func _on_testButton_presed():
	get_tree().change_scene("res://Scenes/TestingArea/TestingArea.tscn")

# this function runs every frame
func _process(delta):
	# sets money on screen
	$Money/money.text = "PHP " + Profile.format_money(Profile.money)

# after 0.5 seconds, instantiate template popup
func _on_Timer_timeout():
	templatePopUp = templatePopUp.instance()
	add_child(templatePopUp)
