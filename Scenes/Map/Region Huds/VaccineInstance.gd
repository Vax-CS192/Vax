# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Control

onready var vaccine_name = $MarginContainer/Label
onready var check_box = $CheckBox

var active = false

# function that has one argument and will use that argument to update the text field for the vaccine_name of our VaccineInstance scene
func _update_name(name):
	vaccine_name.text = name

# function that checks whenever the checkbox is toggled together with the current state of the active variable to make a decision of sending an increment or decrement of the counter variable of the RegionHud script
func _on_CheckBox_toggled(button_pressed):
	var region_hud = get_parent().get_parent().get_parent().get_parent()
	if !active:
		region_hud.counter += 1
		region_hud.add_vaccine(vaccine_name.text)
		active = true
	else:
		region_hud.counter -= 1
		region_hud.remove_vaccine(vaccine_name.text)
		active = false
