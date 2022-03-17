# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends LineEdit

# variable that is a new instance of a StyleBoxFlat which will be applied on the LineInput of the scene 
var my_style = StyleBoxFlat.new()

func _ready():
	my_style.set_bg_color(Color(1,1,1,1))
	my_style.corner_radius_bottom_left = 75
	my_style.corner_radius_bottom_right = 75
	my_style.corner_radius_top_left = 75
	my_style.corner_radius_top_right = 75
	set("custom_styles/normal", my_style)
