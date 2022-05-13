# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


extends Node
var favorites
var favorite_names = []
var patient_data ={}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var test_data = get_parent().get_node("TestData")
	patient_data = test_data.load_property("patient_data")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#This changes the scene to the Lab.
func _on_TestingAreaUI_back_pressed():
		var testingarea_subsystem = get_parent()
		testingarea_subsystem.get_node("TestingAreaUI").hide()
		var lab_subsystem = preload("res://Scenes/Lab/Lab.tscn")
		get_parent().get_parent().add_child(lab_subsystem.instance())

#This configures then draws TestingAreaUI; It also manipulates the favorite_names class variable
func draw():
	favorites = PersistentScenes.formulaBook.get_curr_favorites() #refresh copy of favorites
	favorite_names.clear()
	for favorite in favorites:
		if favorite["ID"] != null:
			favorite_names.append(favorite["ID"])
		else:
			break
	var testingarea_subsystem = get_parent()
	var testingarea_ui = testingarea_subsystem.get_node("TestingAreaUI")
	testingarea_ui.draw()

#This returns a list of the favorites' names
func get_favorite_names():
	return favorite_names

# This validates, based on a provided list of vaccines, 
# whether the player has enough of each bundle to perform the test
# If yes, this returns 0, else it returns -1
#If no, return the bundleID of the bundle to buy more of
func validate(patient_vaccines):
	var vaccine_decompositions = []
	var required_counter  = []
	var bundle_dict = get_node("/root/Session").mainDict["bundles"]
	var deficiencies = []
	for _x in range(20):
		required_counter.append(0)
	for vaccine in patient_vaccines:
		if vaccine == -1:
			 continue
		vaccine_decompositions.append(favorites[vaccine-1]["Components"])

	for decomposition in vaccine_decompositions:
		for element in decomposition:
			if int(element) != -1:
				required_counter[int(element)] += 1
	for x in range(20):
		if required_counter[x] >  int(bundle_dict[str(x)]["inStock"]):
			deficiencies.append(x)
	return deficiencies

#Test Virus against Main Virus
func severity(bundle_id, symptom_id):
		randomize()
		var sev
		var bundle_dict = get_node("/root/Session").mainDict["bundles"]
		var virus = get_node("/root/Session").mainDict["symptoms"]
		var symptom_sequence = virus[symptom_id]
		var bundle_sequence = bundle_dict[bundle_id]["sequence"]
		var similar_characters = 0
		for index in range(len(symptom_sequence)):
			if symptom_sequence[index] == bundle_sequence[index]:
				similar_characters += 1
		var similarity = int(100*(similar_characters/len(symptom_sequence)))
		return int(0.8*(100 - similarity) +0.2 *rand_range(0,100))

#Execute a Test, and save both the results and vaccine names in PatientData
func execute_test(patient_vaccines):
	randomize()
	var vaccine_decompositions = []
	var vaccine_names = []
	var required_counter  = []
	var bundle_dict = get_node("/root/Session").mainDict["bundles"]
	for _x in range(20):
		required_counter.append(0)
	for vaccine in patient_vaccines:
		if vaccine == -1:
			vaccine_decompositions.append([])
			vaccine_names.append("Blank")
			continue
		vaccine_decompositions.append(favorites[vaccine-1]["Components"])
		vaccine_names.append(favorites[vaccine-1]["ID"])
	for decomposition in vaccine_decompositions:
		for element in decomposition:
			if int(element) != -1:
				required_counter[int(element)] += 1
	for x in range(20):
		bundle_dict[str(x)]["inStock"] = str(int(bundle_dict[str(x)]["inStock"]) - required_counter[x])
	for patient_id in range(5):
		var severity_parameters = {}
		for x in range(5):
			severity_parameters[str(x)] = str(int(80+0.2 *rand_range(0,100)))
			#print(severity_parameters)
		for bundle in vaccine_decompositions[patient_id]:
			if bundle == str(-1):
				continue
			var targeted_symptom = bundle_dict[str(bundle)]["symptom"]
			var symptom_severity = severity(bundle,targeted_symptom)
			if symptom_severity < int(severity_parameters[targeted_symptom]):
					severity_parameters[targeted_symptom] = str(symptom_severity)
		patient_data[str(patient_id)] = severity_parameters
		patient_data[str(10+patient_id)] = vaccine_names[patient_id]

	
#Pass data to TestData DAO for storage
func save_data(timer_ctime,pretest,testing,test_done):
	var test_data = get_parent().get_node("TestData")
	test_data.save_data(timer_ctime,pretest,testing,test_done,patient_data)


#Retrieve Data from TestData DAO
func load_property(x):
	var test_data = get_parent().get_node("TestData")
	return test_data.load_property(x)

#Release a Patient's Test Data
func get_results(x):
	return patient_data[str(x)]
	
#Recall a Patient's Vaccine Name
func get_vaccine_name(x):
	return patient_data[str(10+x)]
