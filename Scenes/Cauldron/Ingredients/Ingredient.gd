#Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# My code uses some of the basic principles from, but not the exact code of, the script at https://generalistprogrammer.com/godot/godot-drag-and-drop-tutorial/
# Therefore, my code is so different from the script at that site that, arguably, it cannot be considered a derivative of that site's script.
# Nonetheless, for completeness, here is the citation for that site:
# Guilfoyle, Paul. Generalist Programmer. Last Accessed: March 12, 2022

extends TextureButton

var selected = false
var origin_x = 0
var origin_y = 0
var master_window
var first_time = true
export var included = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Find master window as soon as ingredient is ready
func _ready():
	master_window = get_viewport()
	
# Update the Ingredient's position if it has been selected; offsets make it so that the bottle's center
# rather than the top left follows the cursor
func _process(_delta):
	if selected:
		var new_position = master_window.get_mouse_position()
		self.rect_position = Vector2(new_position.x-140, new_position.y-130)
#	pass


func _on_button_down():
	selected = true


func _on_button_up():
	selected = false
	
	
	#Case where user successfully dragged out of inventory
	if (not included) and (self.rect_position.y < 321 ) :
		self.rect_position = Vector2(origin_x,320)
		included = true
	
	#Case where user succcessfully dragged out of working area
	elif included and (self.rect_position.y > 600):
		self.rect_position = Vector2(origin_x,origin_y)
		included = false
		
	#Case where user failed to drag out of inventory
	elif not included:
		self.rect_position = Vector2(origin_x,origin_y)
		
	#Case where user failed to drag out of working area
	elif included:
		self.rect_position = Vector2(origin_x,320)

func set_up(formula_name, x_pos, y_pos):
	$my_name.set_text(formula_name)
	self.rect_position = Vector2(x_pos,y_pos)
	origin_x = x_pos
	origin_y = y_pos

