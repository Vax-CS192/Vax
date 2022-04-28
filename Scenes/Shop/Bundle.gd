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

extends TextureButton
var open_bundle = preload("res://Assets/Shop/Destructible Objects Sprite Sheet - Opened.png")
var closed_bundle = preload("res://Assets/Shop/Destructible Objects Sprite Sheet - Normal.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Popup_bundle_unpressed()

func _on_Shop_bundle_pressed():
	self.texture_normal=open_bundle


func _on_Popup_bundle_unpressed():
	self.texture_normal=closed_bundle
