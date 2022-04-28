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
var cauldronLoad = preload("res://Scenes/Cauldron/Cauldron.tscn")
var testingAreaLoad = preload("res://Scenes/TestingArea/TestingArea.tscn")
var mapLoad = preload("res://Scenes/Map/MapUI.tscn")
var shopLoad = preload("res://Scenes/Shop/Shop.tscn")
var formulaBookLoad = preload("res://Scenes/FormulaBook/FormulaBook.tscn")
var cauldron
var map
var shop
var formulaBook
var testingArea


# Called when the node enters the scene tree for the first time.
func _ready():
	cauldron = cauldronLoad.instance()
	testingArea = testingAreaLoad.instance()
	map = mapLoad.instance()
	shop = shopLoad.instance()
	formulaBook = formulaBookLoad.instance()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# this function runs when the Session node enters into the SceneTree. It adds
# instanced subsystems as children to Session
func addPersistentScenesToSceneTree():
	map.hide()
	shop.hide()
	get_node("/root/Session").add_child(cauldron)
	get_node("/root/Session").add_child(testingArea)
	get_node("/root/Session").add_child(map)
	get_node("/root/Session").add_child(shop)
	get_node("/root/Session").add_child(formulaBook)
	
