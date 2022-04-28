# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends VirusGenerator

onready var money_amount = $Money/Account

var button = 0
var region_file = File.new()
var dict

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	money_amount.text = "PHP %s" % [Profile.format_money(Profile.money)]

func disable_region():
	$Buttons.get_child(button).disabled = true

func enable_region(region_index):
	$Buttons.get_child(region_index + 1).disabled = false

func mass_produced_vaccines(vaccineName, bundleSequences):
	var save_game = File.new()
	if not save_game.file_exists("user://AvailableVaccines.save"):
		var dict = {}
		dict[vaccineName] = bundleSequences
		save_game.open("user://AvailableVaccines.save", File.WRITE)
		save_game.store_line(to_json(dict))
		save_game.close()
	else:
		save_game.open("user://AvailableVaccines.save", File.READ)
		var dict = parse_json(save_game.get_line())
		save_game.close()
		save_game.open("user://AvailableVaccines.save", File.WRITE)
		dict[vaccineName] = bundleSequences
		save_game.store_line(to_json(dict))
		save_game.close()
	pass

func init_map():
	$RegionHudPopup.load_vaccines()
	region_file.open("user://Regions.save", File.READ)
	dict = parse_json(region_file.get_line())
	var regionButtons = $Buttons.get_children()
	for i in range(17):
		regionButtons[i+1].disabled = dict[str(i)]["disabled"]
	region_file.close()
	get_node("Timers").initialize()

func initialize_regions():
	var save_game = File.new()
	var outer_dict = {}
	
	for i in range(17):
		var in_dict = {}
		var sequences  = []
		var effectivity = []
		in_dict["disabled"] = false
		in_dict["waitTime"] = OS.get_unix_time()
		in_dict["collect"] = false
		for j in range(5):
			var symptom = generateSymptom(10)
			var base = get_parent().mainDict["symptoms"][str(j)]
			var unmatched = 0
			for k in range(symptom.length()):
				if symptom[k] != base[k]:
					unmatched += 1
			var efficacy = (float(unmatched) / float(symptom.length())) * 72
			sequences.append(symptom)
			effectivity.append(efficacy)
		in_dict["initsequences"] = sequences
		in_dict["effectivity"] = effectivity
		in_dict["vaccinesDeployed"] = []
		in_dict["reward"] = 0
		outer_dict[i] = in_dict
	save_game.open("user://Regions.save", File.WRITE)
	save_game.store_line(to_json(outer_dict))
	save_game.close()

func update_regions_file(VaccinesDeployed):
	var bundleDict = get_parent().mainDict["bundles"]
	var vaccines = []
	for i in VaccinesDeployed:
		var vaccine = []
		for j in i:
			if j != "-1":
				vaccine.append(bundleDict[str(int(j))]["sequence"])
			else:
				vaccine.append("zzzzzzzzzz")
		vaccines.append(vaccine)
	dict[str(button-1)]["vaccinesDeployed"] = vaccines
	dict[str(button-1)]["disabled"] = true
	dict[str(button-1)]["waitTime"] = OS.get_unix_time() + 10
	dict[str(button-1)]["collect"] = true
	efficacy(vaccines, str(button-1))
	save_dict()
	
func save_dict():
	var save_game = File.new()
	save_game.open("user://Regions.save", File.WRITE)
	save_game.store_line(to_json(dict))
	save_game.close()

func get_dict_info(key):
	return dict[str(key)]

func update_dict_info(key, val):
	dict[key] = val
	save_dict()

func efficacy(vaccines, region):
	var effectivity = [0, 0, 0, 0, 0]
	var regionSequence = dict[region]["initsequences"]
	var RegionStat = dict[region]["effectivity"]
	
	for vaccine in vaccines:
		for i in range(len(vaccine)):
			var counter = 0.0
			for j in range(len(vaccine[i])):
				if vaccine[i][j] == regionSequence[i][j]:
					counter += 1
			effectivity[i] += (counter/len(vaccine[i]))
	
	var sum = 0.0
	for i in range(5):
		RegionStat[i] -= (effectivity[i] * 7)
		sum += (effectivity[i] * 0.25)
	
	dict[region]["effectivity"] = RegionStat 
	dict[region]["reward"] = sum * 1000000
	

