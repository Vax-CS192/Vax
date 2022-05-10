# Author: Aira Mae Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Control

export var is_occupied=false	#Variable to store state of the archive slot
export var is_pressed=false
export var is_disabled=false

#preload the icons of the occupied and empty formula
var occupied_icon=preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Mini Occupied.png")
var empty_icon=preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Mini Not Occupied.png")
var icon_toggle = 1

# Called when the node enters the scene tree for the first time.
# The default state of a formula slot is empty.
func _ready():
	is_occupied=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If there is previously saved formula, the icon will be set accordingly
func _process(delta):
	if is_occupied==true or (is_pressed==true and is_disabled==false):
		get_node(".").texture_normal=occupied_icon
	else:
		get_node(".").texture_normal=empty_icon
