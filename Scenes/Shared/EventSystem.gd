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

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# this function decides which event will run
func startEvent():
	var event = randi() % 10 # get number between 0 - 9 inclusive;
	
	# event = 9
	
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
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price + increase)
	
	#show prompt
	prompt("bundleTaxIncrease: increasing index %s" % indexOfBundle)
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("Reversing bundleTaxIncrease")
	# reverse changes
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price)

func disableTestingArea():
	testingAreaEnabled = false
	
	# show prompt
	prompt("Disabling testArea")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("enable testArea")
	# reverse changes
	testingAreaEnabled = true

func bundleTaxDecrease():
	var numOfBundles = len(session.mainDict["bundles"])
	var indexOfBundle = randi() % numOfBundles
	var decrease = round(rand_range(2000.0, 5000.0))
	var price = int(session.mainDict["bundles"][str(indexOfBundle)]["price"])
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price - decrease)
	
	#show prompt
	prompt("bundleTaxDecrease: increasing index %s" % indexOfBundle)
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("Reversing bundleTaxDecrease")
	# reverse changes
	session.mainDict["bundles"][str(indexOfBundle)]["price"] = str(price)

func shopIsDisabled():
	shopEnabled = false
	
	# show prompt
	prompt("disabling shop")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("enabling shop")
	# reverse changes
	shopEnabled = true

func shopIsFree():
	var bundles: Dictionary = session.mainDict["bundles"]
	var bundlesCopy = bundles.duplicate(true)
	for bundle in bundles:
		bundles[bundle]["price"] = str(0.0)
		
	# show prompt
	prompt("shop is free")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("shop is not free")
	# reverse changes
	bundles = bundlesCopy

func shopPriceIncrease():
	var bundles: Dictionary = session.mainDict["bundles"]
	var bundlesCopy = bundles.duplicate(true)
	var increase = round(rand_range(2000.0, 5000.0))
	for bundle in bundles:
		bundles[bundle]["price"] = str(int(bundles[bundle]["price"]) + increase)
		
	# show prompt
	prompt("shop price increase")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("shop price normal")
	# reverse changes
	bundles = bundlesCopy

func shopPriceDecrease():
	var bundles: Dictionary = session.mainDict["bundles"]
	var bundlesCopy = bundles.duplicate(true)
	var decrease = round(rand_range(2000.0, 5000.0))
	for bundle in bundles:
		bundles[bundle]["price"] = str(int(bundles[bundle]["price"]) - decrease)
		
	# show prompt
	prompt("shop price decrease")
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(150), "timeout")
	
	# show prompt
	prompt("shop price normal")
	# reverse changes
	bundles = bundlesCopy

func moneyIncrease():
	var increase = round(rand_range(1_000_000.0, 5_000_000.0))
	Profile.money += increase
	
	# show prompt
	prompt("money increase")

func moneyDecrease():
	var decrease = round(rand_range(1_000_000.0, 5_000_000.0))
	# check if decrease will make the player lose
	if Profile.money - decrease <= 1_000_000:
		startEvent()
	else:
		Profile.money -= decrease
		
	# show prompt
	prompt("money decrease")
	
# To implement
func disableMapRegion():
	var region = randi() % 17 
	get_node("/root/Session/MapUI").random_region_event(region, true)
	
	prompt("region disabled: %s" % region)
	
	# pauses execution of the function for 150 seconds
	# more info: https://gdscript.com/solutions/godot-timing-tutorial/
	yield(get_tree().create_timer(15), "timeout")
	
	prompt("region enabled: %s" % region)
	
	get_node("/root/Session/MapUI").random_region_event(region, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func prompt(text):
	var event = eventPrompt.instance()
	event.get_node("PopupText").text = text
	var font = event.get_node("PopupText").get_font("font")
	font.size = 100
	session.add_child(event)
