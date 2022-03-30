# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Node

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
func _on_CauldronUI_back_to_lab():
		var cauldron_subsystem = get_parent()
		cauldron_subsystem.get_node("CauldronUI").hide()
		var lab_subsystem = preload("res://Scenes/Lab/Lab.tscn")
		get_parent().get_parent().add_child(lab_subsystem.instance())

#This changes the scene to the Formulabook.
func _on_CauldronUI_open_formulabook():
		var cauldron_subsystem = get_parent()
		cauldron_subsystem.get_node("CauldronUI").hide()
		var formulabook_subsystem = get_parent().get_parent().get_node("FormulaBook")
		formulabook_subsystem.show()

# Load specified bundles into cauldron		
func load_to_cauldron(five_array):
	var cauldron_subsystem = get_parent()
	var cauldron_ui = cauldron_subsystem.get_node("CauldronUI")
	cauldron_ui.reset()
	for x in range(5):
		if five_array[x] == -1:
			break
		cauldron_ui.select_ingredient(five_array[x])
	cauldron_ui.show()
	
# Reset the CauldronUI and draw it to the screen
func draw():
	var cauldron_subsystem = get_parent()
	var cauldron_ui = cauldron_subsystem.get_node("CauldronUI")
	cauldron_ui.reset()
	cauldron_ui.show()
	cauldron_ui.draw()
	
func add_to_formulabook(name, description,five_array):
	var formulabook_subsystem = get_parent().get_parent().get_node("FormulaBook")
	formulabook_subsystem.add_to_formulabook(name, description, five_array)
	
