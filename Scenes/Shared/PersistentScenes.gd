# Author: John Henry A. Galino
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without 
# fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.

extends Node


# preload scenes to be instantiated
var cauldron = preload("res://Scenes/Cauldron/Cauldron.tscn")
var testingArea = preload("res://Scenes/TestingArea/TestingArea.tscn")
var map = preload("res://Scenes/Map/MapUI.tscn")
var shop = preload("res://Scenes/Shop/Shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	cauldron = cauldron.instance()
	testingArea = testingArea.instance()
	map = map.instance()
	shop = shop.instance()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# this function runs when the Session node enters into the SceneTree. It adds
# instanced subsystems as children to Session
func _on_ready_Session():
	map.hide()
	shop.hide()
	get_node("/root/Session").add_child(cauldron)
	get_node("/root/Session").add_child(testingArea)
	get_node("/root/Session").add_child(map)
	get_node("/root/Session").add_child(shop)
	
