# Author: Aira Mae Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.


extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize() #will be needed to randomize bundle names
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# The bundle names and font color are set here.
func _process(delta):
	#Set Bundle Names
	$ShopControl/Bundle1/Name.text="One"
	$ShopControl/Bundle2/Name.text="Two"
	$ShopControl/Bundle3/Name.text="Three"
	$ShopControl/Bundle4/Name.text="Four"
	$ShopControl/Bundle5/Name.text="Five"
	$ShopControl/Bundle6/Name.text="Six"
	$ShopControl/Bundle7/Name.text="Seven"
	$ShopControl/Bundle8/Name.text="Eight"
	$ShopControl/Bundle9/Name.text="Nine"
	$ShopControl/Bundle10/Name.text="Ten"
	$ShopControl/Bundle11/Name.text="Eleven"
	$ShopControl/Bundle12/Name.text="Twelve"
	$ShopControl/Bundle13/Name.text="Thirteen"

	#Set name colors to compliment tables 
	$ShopControl/Bundle9/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle10/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle11/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle12/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle13/Name.set("custom_colors/font_color",Color(1,1,1,1))

#Go to Lab Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Lab/Lab.tscn")
