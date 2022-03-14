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


extends Control

export var is_occupied=false	#Variable to store state of the archive slot

#preload the icons of the occupied and empty formula
var occupied_icon=preload("res://Assets/Formula Book/Occupied Formula.png")
var empty_icon=preload("res://Assets/Formula Book/Empty Formula.png")



# Called when the node enters the scene tree for the first time.
# The default state of a formula slot is empty.
func _ready():
	is_occupied=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
# If there is previously saved formula, the icon will be set accordingly
func _process(delta):
	get_node(".").texture_normal=empty_icon
	if is_occupied==true:
		get_node(".").texture_normal=occupied_icon
		

#Go to corresponding Cauldron Subsystem when the button is pressed	
func _on_Formula_pressed():
	#Task: change details of formula depending on the formula selected
	if is_occupied==true:
		get_tree().change_scene("res://Scenes/FormulaBook/Formula Page/FormulaPage.tscn")
