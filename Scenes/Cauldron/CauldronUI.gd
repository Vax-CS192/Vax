
# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
signal back_to_lab
signal open_formulabook
extends Node2D


func _ready():
	var yellow_scene = preload("res://Scenes/Cauldron/Ingredients/Yellow.tscn")
	var blue_scene = preload("res://Scenes/Cauldron/Ingredients/Blue.tscn")
	var test1 = yellow_scene.instance()
	var test2 = blue_scene.instance()
	test1.set_up("A",80,1000)
	test2.set_up("B",320,1000)
	$Bundles.add_child(test1)
	$Bundles.add_child(test2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var bundle_count = $Bundles.get_child_count()
	var all_bundles = $Bundles.get_children()
	for i in range(0,bundle_count):
		if all_bundles[i].rect_position.y < 321:
			$mix_button.disabled = false
			return
	$mix_button.disabled = true

#  This method causes the CauldronUI to signal to the cauldron controller to instance the Lab
#  subsystem and remove the Cauldron subsystem from memory.
func _on_Back_pressed():
	emit_signal("back_to_lab")

#This method causes the CauldronUI to signal to the cauldron controller to instance the Formulabook
#  subsystem and remove the Cauldron subsystem from memory.
func _on_formulabook_icon_pressed():
	emit_signal("open_formulabook")

