# Author: Aira Mae E. Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without 
# fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.

extends Node


onready var favorites_file_path = "user://favoritesdirectory.save"

onready var formula_parameters := {
	"ID":null,
	"Name": "",
	"Description":"",
	"MassProducePrice":0,
	"Components": []
}


func _ready():
	$FormulaPageUI/Money/Account.text="PHP "+ Profile.format_money(Profile.money)
	

	
#Loads data to the page
#Task: Called by Formula book when a slot is pressed
func load_formula_parameters(new_formula_parameters: Dictionary):
	formula_parameters = new_formula_parameters
	$FormulaPageControl/FormulaName.text=formula_parameters["Name"]
	$FormulaPageControl/FormulaNote.text= formula_parameters["Description"]
	var index = 0
	while index <5:
		var component_node = "FormulaPageControl/Component"+str(index+1)+"/Name"
		var components = formula_parameters["Components"]
		get_node(component_node).text= components[index]
		index+=1
	$FormulaPageUI/MassProdText.text = "PHP "+str(formula_parameters["MassProducePrice"])
	
	
#Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	#Task: Save
	get_tree().change_scene("res://Scenes/FormulaBook/FormulaBook.tscn")
	

# Formula is deleted from the Formula file
func _on_DeleteFormula_pressed():
	pass # Replace with function body.

# runs when Mass Produce button is clicked
func _on_MassProduce_pressed():
	#Map.add_to_mass_produced(formula_parameters.Name,formula_parameters.Components)
	pass
# runs when Load to Cauldron button is clicked
func _on_LoadCauldron_pressed():
	#Cauldron.load_to_cauldron(formula_parameters.Components)
	pass
