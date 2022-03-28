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

extends VirusGenerator

# We need to load a new scene when we want to switch to that scene.
# Why not preload? Preload caused some unexpected errors so I think load is good
# enough for now
var mainMenu = load("res://Scenes/MainMenu/MainMenu.tscn")

# We generate bundles using the inherited method generateBundles.
# These bundles are arrays of 4 randomly generated DNA strings with the
# first item in the array being the actual symptom
var bundles1 = generateBundles()
var bundles2 = generateBundles()
var bundles3 = generateBundles()
var bundles4 = generateBundles()
var bundles5 = generateBundles()

# This signal is used to signify to PersistentScenes to add the persistent
# subsystems as children to session
signal entered

# Called when the node enters the scene tree for the first time.
func _ready():
	# on ready, connect the entered signal to PersistentScenes, then emit the
	# signal to add the persistent scenes to session
	self.connect("entered", get_node("/root/PersistentScenes"), "_on_ready_Session")
	emit_signal("entered")
	# instantiate mainMenu and add it as children
	mainMenu = mainMenu.instance()
	self.add_child(mainMenu)


# this function changes the scene for susbsytems that don't need to be persistent
# currentScene: the current scene
# nextScene: instance of the scene to go to
func changeSceneTo(currentScene: Node, nextScene: CanvasItem):
	nextScene.show()
	currentScene.queue_free()
	self.add_child(nextScene)

# this function changes the scene for subsystems that need to be persistent
# current: the current scene whose root node implements CanvasItem
# nextScene: an instance of the scene to go to
func hideAndChangeSceneTo(current: CanvasItem, nextScene: Node):
	current.hide() 
	self.add_child(nextScene)
	

