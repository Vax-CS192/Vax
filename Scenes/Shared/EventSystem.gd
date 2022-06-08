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

# DESIGN: The event system creates random events for the player as added challenges and stuff.
# EventSystem.gd will also be an autoload global since the event system is always active. 
# Each event possible will be declared here as a function. A timer will be created in Session which 
# will run a random number generator after some time. The random number generated will decide which 
# event will happen to the player.

extends Node

onready var session = get_node("/root/Session")
var shopEnabled = true
var testingAreaEnabled = true
var eventPrompt = preload("res://Scenes/Shared/Event.tscn")
var ind = 9

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func changeInd():
	ind = 10

# this function decides which event will run
func startEvent():
	var event = randi() % ind # get number between 0 - 8 inclusive;
	
	# print("doing event: %s" % event)
	
	# match event
	match event:
		0: bundleTaxIncrease()
		1: disableTestingArea()
		2: bundleTaxDecrease()
		3: shopIsDisabled()
		4: shopIsFree()
		5: shopPriceIncrease()
		6: shopPriceDecrease()
		7: moneyIncrease()
		8: moneyDecrease()
		9: disableMapRegion()

func bundleTaxIncrease():
	var numOfBundles = len(session.mainDict["bundles"])
	var indexOfBundle = randi() % numOfBundles
	var increase = round(rand_range(2000.0, 5000.0))
	var price = int(session.mainDict["bundles"][str(indexOfBundle)]["price"])
	var nameOfBundle = str(session.mainDict["bundles"][str(indexOfBundle)]["bundleName"])
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price + increase)
	
	#show prompt
	prompt("Bundle %s's price has been increased" % nameOfBundle)
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(100), "timeout")
	
	# show prompt
	prompt("Bundle %s's price has returned to normal" % nameOfBundle)
	# reverse changes
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price)

func disableTestingArea():
	testingAreaEnabled = false
	
	# show prompt
	prompt("Testing Area will be disabled!")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(30), "timeout")
	
	# show prompt
	prompt("Testing Area is back to normal.")
	# reverse changes
	testingAreaEnabled = true

func bundleTaxDecrease():
	var numOfBundles = len(session.mainDict["bundles"])
	var indexOfBundle = randi() % numOfBundles
	var decrease = round(rand_range(2000.0, 5000.0))
	var price = int(session.mainDict["bundles"][str(indexOfBundle)]["price"])
	var nameOfBundle = str(session.mainDict["bundles"][str(indexOfBundle)]["bundleName"])
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price - decrease)
	
	#show prompt
	prompt("Bundle %s's price has been decreased" % nameOfBundle)
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(100), "timeout")
	
	# show prompt
	prompt("Bundle %s's price has returned to normal" % nameOfBundle)
	# reverse changes
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price)

func shopIsDisabled():
	shopEnabled = false
	
	# show prompt
	prompt("Shop will be disabled!")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(30), "timeout")
	
	# show prompt
	prompt("Shop is now back to normal.")
	# reverse changes
	shopEnabled = true

func shopIsFree():
	var bundles: Dictionary = session.mainDict["bundles"]
	var bundlesCopy = bundles.duplicate(true)
	for bundle in bundles:
		bundles[bundle]["price"] = str(0.0)
		
	# show prompt
	prompt("Everything in the shop is free!")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(60), "timeout")
	
	# show prompt
	prompt("Shop has returned to normal.")
	# reverse changes
	bundles = bundlesCopy

func shopPriceIncrease():
	var bundles: Dictionary = session.mainDict["bundles"]
	var bundlesCopy = bundles.duplicate(true)
	var increase = round(rand_range(2000.0, 5000.0))
	for bundle in bundles:
		bundles[bundle]["price"] = str(int(bundles[bundle]["price"]) + increase)
		
	# show prompt
	prompt("Prices in the shop has increased!")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(100), "timeout")
	
	# show prompt
	prompt("Shop prices have returned to normal.")
	# reverse changes
	bundles = bundlesCopy

func shopPriceDecrease():
	var bundles: Dictionary = session.mainDict["bundles"]
	var bundlesCopy = bundles.duplicate(true)
	var decrease = round(rand_range(2000.0, 5000.0))
	for bundle in bundles:
		bundles[bundle]["price"] = str(int(bundles[bundle]["price"]) - decrease)
		
	# show prompt
	prompt("Prices in the shop has decreased!")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(100), "timeout")
	
	# show prompt
	prompt("Shop prices have returned to normal.")
	# reverse changes
	bundles = bundlesCopy

func moneyIncrease():
	var increase = round(rand_range(1_000_000.0, 5_000_000.0))
	Profile.money += increase
	
	# show prompt
	prompt("Your money increases.")

func moneyDecrease():
	var decrease = round(rand_range(1_000_000.0, 5_000_000.0))
	# check if decrease will make the player lose
	if Profile.money - decrease <= 1_000_000:
		startEvent()
	else:
		Profile.money -= decrease
		
	# show prompt
	prompt("Your money decreases.")
	
# To implement
func disableMapRegion():
	var region = randi() % 17
	var random_adder = randi() % 20
	var region_name = get_node("/root/Session/MapUI").random_region_event(region, true, random_adder)
	

	prompt("%s will be disabled!" % region_name)

	
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(60), "timeout")
	

	prompt("%s is now ok." % region_name)

	
	get_node("/root/Session/MapUI").random_region_event(region, false, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func prompt(text):
	if !get_node("/root/Session").has_node("MainMenu"):
		var event = eventPrompt.instance()
		event.get_node("PopupText").text = text
		var font = event.get_node("PopupText").get_font("font")
		session.add_child(event)
