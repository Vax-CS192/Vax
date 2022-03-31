# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Popup

onready var region_name = $RegionHud/MarginContainer/RegionName
onready var region_hud = $RegionHud/Vaccines/ScrollContainer/VSeparator
var available_vaccines = []
var VaccineScene = preload("res://Scenes/Map/Region Huds/VaccineInstance.tscn")
var lab = preload("res://Scenes/Lab/Lab.tscn")

# function responsible for instantiating a number of VaccineInstance Scene, which highly depends on the availble vaccines 
func _instantiate_vaccine_scenes():
	for i in range(len(available_vaccines)):
		var instantiate = VaccineScene.instance()
		region_hud.add_child(instantiate)
		instantiate._update_name(available_vaccines[i])
	if (available_vaccines.size()>4):
		var instantiate = VaccineScene.instance()
		region_hud.add_child(instantiate)
	show()

# function called whenever the back button is pressed and will change the scene to that of the lab
func _on_BackButton_pressed():
	get_node("/root/Session").hideAndChangeSceneTo(PersistentScenes.map, lab.instance())

# function called whenever the Region 1 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_0_Region_1_pressed():
	region_name.text = "Region 1"
	get_parent().button = 1
	region_information(0)
	_instantiate_vaccine_scenes()

# function called whenever the CAR Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_1_CAR_pressed():
	region_name.text = "CAR"
	get_parent().button = 2
	region_information(1)
	_instantiate_vaccine_scenes()

# function called whenever the Region 2 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_2_Region_2_pressed():
	region_name.text = "Region 2"
	get_parent().button = 3
	region_information(2)
	_instantiate_vaccine_scenes()

# function called whenever the Region 3 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_3_Region_3_pressed():
	region_name.text = "Region 3"
	get_parent().button = 4
	region_information(3)
	_instantiate_vaccine_scenes()

# function called whenever the NCR Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_4_NCR_pressed():
	region_name.text = "NCR"
	get_parent().button = 5
	region_information(4)
	_instantiate_vaccine_scenes()

# function called whenever the Region 4A button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_5_Region_4A_pressed():
	region_name.text = "Region 4A"
	get_parent().button = 6
	region_information(5)
	_instantiate_vaccine_scenes()

# function called whenever the Mimaropa Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_6_Mimaropa_pressed():
	region_name.text = "Mimaropa"
	get_parent().button = 7
	region_information(6)
	_instantiate_vaccine_scenes()

# function called whenever the Region 5 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_7_Region_5_pressed():
	region_name.text = "Region 5"
	get_parent().button = 8
	region_information(7)
	_instantiate_vaccine_scenes()

# function called whenever the Region 6 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_8_Region_6_pressed():
	region_name.text = "Region 6"
	get_parent().button = 9
	region_information(8)
	_instantiate_vaccine_scenes()

# function called whenever the Region 7 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_9_Region_7_pressed():
	region_name.text = "Region 7"
	get_parent().button = 10
	region_information(9)
	_instantiate_vaccine_scenes()

# function called whenever the Region 8 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_10_Region_8_pressed():
	region_name.text = "Region 8"
	get_parent().button = 11
	region_information(10)
	_instantiate_vaccine_scenes()

# function called whenever the Region 9 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_11_Region_9_pressed():
	region_name.text = "Region 9"
	get_parent().button = 12
	region_information(11)
	_instantiate_vaccine_scenes()

# function called whenever the Region 10 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_12_Region_10_pressed():
	region_name.text = "Region 10"
	get_parent().button = 13
	region_information(12)
	_instantiate_vaccine_scenes()

# function called whenever the BARMM Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_13_BARMM_pressed():
	region_name.text = "BARMM"
	get_parent().button = 14
	region_information(13)
	_instantiate_vaccine_scenes()

# function called whenever the Region 11 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_14_Region_11_pressed():
	region_name.text = "Region 11"
	get_parent().button = 15
	region_information(14)
	_instantiate_vaccine_scenes()

# function called whenever the Region 12 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_15_Region_12_pressed():
	region_name.text = "Region 12"
	get_parent().button = 16
	region_information(15)
	_instantiate_vaccine_scenes()

# function called whenever the Region 13 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_16_Region_13_pressed():
	region_name.text = "Region 13"
	get_parent().button = 17
	region_information(16)
	_instantiate_vaccine_scenes()
	
func load_vaccines():
	var save_game = File.new()
	if (save_game.file_exists("user://AvailableVaccines.save")):
		save_game.open("user://AvailableVaccines.save", File.READ)
		var dict = parse_json(save_game.get_line())
		available_vaccines = dict.keys()
		save_game.close()

func delete_vaccines(vaccines):
	var save_game = File.new()
	save_game.open("user://AvailableVaccines.save", File.READ)
	var dict = parse_json(save_game.get_line())
	save_game.close()
	for i in vaccines:
		dict.erase(i)
		available_vaccines.erase(i)
	save_game.store_line(to_json(dict))
	save_game.close()
	if available_vaccines.size() <= 4:
		var last_child = region_hud.get_child(get_child_count()-1)
		last_child.queue_free()
		pass
	save_game.open("user://AvailableVaccines.save", File.WRITE)
	save_game.store_line(to_json(dict))
	save_game.close()

func region_information(region):
	var region_info = get_parent().dict[str(region)]
	get_child(0).update_region_info(region_info["effectivity"])
