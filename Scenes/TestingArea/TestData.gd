extends Node
var testing_area_data = {}
var pretest = false
var testing = false
var test_done = false
var demo = true
var waiting_time = 1800
var starting_time = -1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Check for the demo flag to see if waiting time should be reduced, then loa data 
func _ready():
	if demo:
		waiting_time = 6
	var current_time = OS.get_unix_time();
	var persistent_data = File.new()
	if not persistent_data.file_exists("user://testing_area.save"):
		print("Trying to set pretest to true")
		pretest = true
		print("Pretest is now",pretest)
		return
	persistent_data.open("user://testing_area.save",File.READ)
	testing_area_data = parse_json(persistent_data.get_line())
	persistent_data.close()
	if testing_area_data["testing"] == str(true):
		testing = true
		if current_time - int(testing_area_data["start_time"]) > waiting_time:
			testing = false
			test_done = true
			starting_time = int(testing_area_data["start_time"])
	elif testing_area_data["pretest"] == str(true):
		pretest = true
	elif testing_area_data["test_done"] == str(true):
		test_done = true
	else:
		pretest = true
		
#Persistence logic to be called when the game is being saved
func save_data(timer_ctime,pretest,testing,test_done):
	var persistent_data = File.new()
	testing_area_data["start_time"] = str(timer_ctime)
	testing_area_data["pretest"] = str(pretest)
	testing_area_data["testing"] =str(testing)
	testing_area_data["test_done"] = str(test_done)
	persistent_data.open("user://testing_area.save", File.WRITE)
	persistent_data.store_line(to_json(testing_area_data))
	persistent_data.close()

#Persistence logic to be called when the game is being loaded
	
#Load a particular property from file. Could be pretest, testing, test_done, or test_results 
func load_property(x):
	if x == "testing":
		return testing
	elif x == "pretest":
		return pretest
	elif x == "test_done":
		return test_done
	elif x == "test_results":
		return testing_area_data[x]
	elif x == "start_time":
		return int(testing_area_data["start_time"])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
