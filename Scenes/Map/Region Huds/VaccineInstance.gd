# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Control

onready var vaccine_name = $MarginContainer/Label
onready var check_box = $CheckBox

var active = false
signal add_counter
signal subtract_counter

# Called when the node enters the scene tree for the first time.
func _ready():
	if check_box.pressed == true:
		print("fuck")
	pass # Replace with function body.


func _update_name(name):
	vaccine_name.text = name


func _on_CheckBox_toggled(button_pressed):
	if !active:
		get_parent().get_parent().get_parent().get_parent().counter += 1
		active = true
	else:
		get_parent().get_parent().get_parent().get_parent().counter -= 1
		active = false
