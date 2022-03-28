# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Popup

onready var region_name = $RegionHud/MarginContainer/RegionName
onready var region_hud = $RegionHud/Vaccines/ScrollContainer/VSeparator
var available_vaccines = ["NGALAN", "MARAHUYO", "PAYZER", "SAYA", "SIGLA", "LIGAYA", "MANAWARI", "J&J"]
var VaccineScene = preload("res://Scenes/Map/Region Huds/VaccineInstance.tscn")
var lab = preload("res://Scenes/Lab/Lab.tscn")

# function responsible for instantiating a number of VaccineInstance Scene, which highly depends on the availble vaccines 
func _instantiate_vaccine_scenes():
	for i in range(len(available_vaccines)):
		var instantiate = VaccineScene.instance()
		region_hud.add_child(instantiate)
		instantiate._update_name(available_vaccines[i])
	show()

# function called whenever the back button is pressed and will change the scene to that of the lab
func _on_BackButton_pressed():
	get_node("/root/Session").hideAndChangeSceneTo(PersistentScenes.map, lab.instance())

# function called whenever the Region 1 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_0_Region_1_pressed():
	region_name.text = "Region 1"
	_instantiate_vaccine_scenes()

# function called whenever the CAR Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_1_CAR_pressed():
	region_name.text = "CAR"
	_instantiate_vaccine_scenes()

# function called whenever the Region 2 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_2_Region_2_pressed():
	region_name.text = "Region 2"
	_instantiate_vaccine_scenes()

# function called whenever the Region 3 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_3_Region_3_pressed():
	region_name.text = "Region 3"
	_instantiate_vaccine_scenes()

# function called whenever the NCR Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_4_NCR_pressed():
	region_name.text = "NCR"
	_instantiate_vaccine_scenes()

# function called whenever the Region 4A button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_5_Region_4A_pressed():
	region_name.text = "Region 4A"
	_instantiate_vaccine_scenes()

# function called whenever the Mimaropa Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_6_Mimaropa_pressed():
	region_name.text = "Mimaropa"
	_instantiate_vaccine_scenes()

# function called whenever the Region 5 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_7_Region_5_pressed():
	region_name.text = "Region 5"
	_instantiate_vaccine_scenes()

# function called whenever the Region 6 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_8_Region_6_pressed():
	region_name.text = "Region 6"
	_instantiate_vaccine_scenes()

# function called whenever the Region 7 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_9_Region_7_pressed():
	region_name.text = "Region 7"
	_instantiate_vaccine_scenes()

# function called whenever the Region 8 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_10_Region_8_pressed():
	region_name.text = "Region 8"
	_instantiate_vaccine_scenes()

# function called whenever the Region 9 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_11_Region_9_pressed():
	region_name.text = "Region 9"
	_instantiate_vaccine_scenes()

# function called whenever the Region 10 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_12_Region_10_pressed():
	region_name.text = "Region 10"
	_instantiate_vaccine_scenes()

# function called whenever the BARMM Region button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_13_BARMM_pressed():
	region_name.text = "BARMM"
	_instantiate_vaccine_scenes()

# function called whenever the Region 11 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_14_Region_11_pressed():
	region_name.text = "Region 11"
	_instantiate_vaccine_scenes()

# function called whenever the Region 12 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_15_Region_12_pressed():
	region_name.text = "Region 12"
	_instantiate_vaccine_scenes()

# function called whenever the Region 13 button is pressed and will show the region hud popup containing info about the region as well as the deployable vaccines that are available
func _on_16_Region_13_pressed():
	region_name.text = "Region 13"
	_instantiate_vaccine_scenes()
