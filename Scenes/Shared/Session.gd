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

var mainDict = {}

# This signal is used to signify to PersistentScenes to add the persistent
# subsystems as children to session
signal entered

# Called when the node enters the scene tree for the first time.
func _ready():
	# temporary for testing only. delete on final product
	generateVirusAndBundles()
	
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
	
func generateVirusAndBundles():
	var bundles = {}
	var baseSymp0 = generateSymptom(10)
	var baseSymp1 = generateSymptom(10)
	var baseSymp2 = generateSymptom(10)
	var baseSymp3 = generateSymptom(10)
	var baseSymp4 = generateSymptom(10)
	var virus = {
		0: baseSymp0,
		1: baseSymp1,
		2: baseSymp2,
		3: baseSymp3,
		4: baseSymp4
	}
	
	var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o",
					"p","q","r","s","t"]
	
	mainDict = {
		"symptoms": virus
	}
	
	# generate bundles from virus
	var bundleID = 0
	for key in virus.keys():
		for letter in letters:
			if bundleID % 4 == 0:
				bundles[bundleID] = generateBundle(bundleID, key, 0.0,
												letter, "", virus[key])
			else:
				bundles[bundleID] = generateBundle(bundleID, key, 0.0,
									letter, "", generateBundleSequence(virus[key]))
			bundleID += 1
			
	# add bundles to mainDict
	mainDict["bundles"] = bundles
	#print(mainDict["bundles"])
