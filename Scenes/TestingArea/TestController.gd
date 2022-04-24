# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


extends Node
var favorites
var favorite_names = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#This changes the scene to the Lab.
func _on_TestingAreaUI_back_pressed():
		var testingarea_subsystem = get_parent()
		testingarea_subsystem.get_node("TestingAreaUI").hide()
		var lab_subsystem = preload("res://Scenes/Lab/Lab.tscn")
		get_parent().get_parent().add_child(lab_subsystem.instance())

#This draws TestingAreaUI
func draw():
	favorites = PersistentScenes.formulaBook.get_curr_favorites() #refresh copy of favorites
	favorite_names.clear()
	for favorite in favorites:
		if favorite["ID"] != null:
			favorite_names.append(favorite["ID"])
		else:
			break
	var testingarea_subsystem = get_parent()
	var testingarea_ui = testingarea_subsystem.get_node("TestingAreaUI")
	testingarea_ui.draw()

#This returns a list of the favorites' names
func get_favorite_names():
	return favorite_names

# This validates, based on a provided list of vaccines, 
# whether the player has enough of each bundle to perform the test
# If yes, this returns 0, else it returns -1
#If no, return the bundleID of the bundle to buy more of
func validate(patient_vaccines):
	var vaccine_decompositions = []
	var required_counter  = []
	var bundle_dict = get_node("/root/Session").mainDict["bundles"]
	for _x in range(20):
		required_counter.append(0)
	for vaccine in patient_vaccines:
		if vaccine == -1:
			 continue
		vaccine_decompositions.append(favorites[vaccine-1]["Components"])
	for decomposition in vaccine_decompositions:
		for element in decomposition:
			if int(element) != -1:
				required_counter[int(element)] += 1
	for x in range(20):
		if required_counter[x] >  int(bundle_dict[str(x)]["inStock"]):
			return x
	return -1
