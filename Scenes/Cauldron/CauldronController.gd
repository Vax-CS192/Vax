# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lab = preload("res://Scenes/Lab/Lab.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#This changes the scene to the Lab.
func _on_CauldronUI_back_to_lab():
	get_node("/root/Session").hideAndChangeSceneTo(PersistentScenes.cauldron, lab.instance())

#This changes the scene to the Formulabook.
func _on_CauldronUI_open_formulabook():
	get_tree().change_scene("res://Scenes/FormulaBook/FormulaBook.tscn")

#Reload the Cauldron to reset the UI
func _on_CauldronUI_reset():
	get_tree().change_scene("res://Scenes/Cauldron/Cauldron.tscn")
