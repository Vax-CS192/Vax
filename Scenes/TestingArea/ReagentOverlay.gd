# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#This informs TestingAreaUI that formula 1 was selected, then hides ReagentOverlay
func _on_F1_pressed():
	get_parent().get_parent().set_vaccine(1)
	get_parent().hide()

#This informs TestinGAreaUI that formula 2 was selected, then hides ReagentOverlay
func _on_F2_pressed():
	get_parent().get_parent().set_vaccine(2)
	get_parent().hide()

#This informs TestingAreaUI that formula 3 was selected, then hides ReagentOverlay
func _on_F3_pressed():
	get_parent().get_parent().set_vaccine(3)
	get_parent().hide()

#This informs TestingAreaUI that formula 4 was selected, then hides ReagentOverlay
func _on_F4_pressed():
	get_parent().get_parent().set_vaccine(4)
	get_parent().hide()
	
#This informs TestingAreaUI that formula 5 was selected, then hides ReagentOverlay
func _on_F5_pressed():
	get_parent().get_parent().set_vaccine(5)
	get_parent().hide()
	
#This informs TestingAreaUI that formula 6 was selected, then hides ReagentOverlay
func _on_F6_pressed():
	get_parent().get_parent().set_vaccine(6)
	get_parent().hide()
	
#This informs TestingAreaUI that formula 7 was selected, then hides ReagentOverlay
func _on_F7_pressed():
	get_parent().get_parent().set_vaccine(7)
	get_parent().hide()

#This informs TestingAreaUI that formula 8 was selected, then hides ReagentOverlay
func _on_F8_pressed():
	get_parent().get_parent().set_vaccine(8)
	get_parent().hide()

#This informs TestingAreaUI that formula 9 was selected, then hides ReagentOverlay
func _on_F9_pressed():
	get_parent().get_parent().set_vaccine(9)
	get_parent().hide()

#This informs TestingAreaUI that formula 10 was selected, then hides ReagentOverlay
func _on_F10_pressed():
	get_parent().get_parent().set_vaccine(10)
	get_parent().hide()

#This informs TestingAreaUI that the Blank was selected, then hides ReagentOverlay
func _on_Blank_pressed():
	get_parent().get_parent().set_vaccine(-1)
	get_parent().hide()
