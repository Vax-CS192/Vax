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
# The sequence in the bundle are arrays of 4 randomly generated DNA strings with 
# the first item in the array being the actual symptom
# 
#
# The structure of mainDict will be as follows
# {
#	"symptoms": {
#				 "0": <random string>,
#				 "1": <random string>,
#				 "2": <random string>,
#				 "3": <random string>,
#				 "4": <random string>
#				},
#	"bundles":	{
#				 "0": {
#					<bundle>
#					},
#				 ...
#				}
# }
#
# The structure of each bundle is as follows
# {
#	"id": id -> identifier for bundle,
#	"symptom": key -> what symptom it is trying to cure,
#	"price": price -> price of bundle,
#	"inStock": inStock -> number of stock of the bundle,
#	"bundleName": bundleName -> the bundle's name,
#	"desc": desc -> player-generated description,
#	"sequence": sequence -> sequence that's used to compute how effective the bundle is,
# }
var mainDict = {}

# This signal is used to signify to PersistentScenes to add the persistent
# subsystems as children to session
signal entered

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# instantiate mainMenu and add it as children
	mainMenu = mainMenu.instance()
	self.add_child(mainMenu)
	
	# set timer's time. The timer should start on lab instantiation. The lab should check if timer
	# is ongoing or not
	$EventTimer.wait_time = 300
	$EventTimer.connect("timeout", get_node("/root/Session"), "callEventSystem")

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
	print("generating virus and bundles")
	var bundles = {}
	var baseSymp0 = generateSymptom(10)
	var baseSymp1 = generateSymptom(10)
	var baseSymp2 = generateSymptom(10)
	var baseSymp3 = generateSymptom(10)
	var baseSymp4 = generateSymptom(10)
	var virus = {
		"0": baseSymp0,
		"1": baseSymp1,
		"2": baseSymp2,
		"3": baseSymp3,
		"4": baseSymp4
	}
	
	var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o",
					"p","q","r","s","t"]
	
	mainDict = {
		"symptoms": virus
	}
	
	# generate bundles from virus. for each symptom, generate 4 bundles
	var bundleID = 0
	for key in virus.keys():
		for n in range(4):
			# the first bundle for each symptom should cure that syptom perfectly, else
			# the bundle is modified 
			if bundleID % 4 == 0:
				bundles[str(bundleID)] = generateBundle(str(bundleID), # id
														str(key), # symptom
														str(round(rand_range(5000.0, 10000.0))), # price
														"0", # inStock
														letters[int(key)*4+n], # bundleName
														"Add description", # desc
														virus[key]) #sequence
			else:
				bundles[str(bundleID)] = generateBundle(str(bundleID), 
														str(key),
														str(round(rand_range(5000.0, 10000.0))), 
														"0",
														letters[int(key)*4+n], 
														"Add description", 
														generateBundleSequence(virus[key]))
			bundleID += 1
	
	var bundles2 = {}
	while len(bundles2) < 20:
		for key in bundles.keys():
			var newKey = randi() % 20
			if not(str(newKey) in bundles2.keys()):
				bundles2[str(newKey)] = bundles[key]
				bundles2[str(newKey)]["bundleName"] = letters[int(newKey)]
	# add bundles to mainDict
	mainDict["bundles"] = bundles2
	
# this function gives the player a number of bundles and a formula since they pressed Yes in the template pop-up
# this function simply changes the inStock property of the bundles in maindDict.bundles
# For now, give 5 bundles to the player
func templateAddBundles():
	
	# Add bundles
	var availableBundles = mainDict["bundles"]
	var formulaBook = get_node("/root/Session/FormulaBook")
	
	for i in range(5):
		var indexOfBundle = randi() % 20
		var playerStock = availableBundles[str(indexOfBundle)]["inStock"]
		playerStock = str(int(playerStock) + 1)
		
	formulaBook.add_to_formulabook("Template Formula","",[
											str(randi()%20),
											str(randi()%20),
											str(randi()%20),
											str(randi()%20),
											str(randi()%20),
											])
	
	
func saveVirusAndBundles():
	# print("saving virus and bundles")
	var save_game = File.new()
	save_game.open("user://virus&bundles.save", File.WRITE)
	save_game.store_line(to_json(mainDict))
	save_game.close()
	
func loadVirusAndBundles():
	# print("loading virus and bundles")
	var save_game = File.new()
	if not save_game.file_exists("user://virus&bundles.save"):
		return
	else:
		save_game.open("user://virus&bundles.save", File.READ)
		mainDict = parse_json(save_game.get_line())
		# print(mainDict)
		save_game.close()

# when EventTimer timeouts, call a random event.
func callEventSystem():
	EventSystem.startEvent()
