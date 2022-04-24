# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


extends Node2D
signal back_pressed
var selected_patient = -1
var patient_vaccines = [-1,-1,-1,-1,-1]
var max_vaccine = 0
var pretest = true
var favorite_names = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):

#	pass

#  This method causes the TestingAreaUI to signal to TestController to instance the Lab
#  subsystem and to hide TestingAreaUI
func _on_back_pressed():
	emit_signal("back_pressed")

# This method updates the money and the favorite  and draws TestingAreaUI to screen
func draw():
		favorite_names = get_parent().get_node("TestController").get_favorite_names()
		max_vaccine = len(favorite_names)
		var reagent_overlay = $ReagentHolder.get_node("ReagentOverlay")
		reagent_overlay.set_names(favorite_names)
		get_node("money_bg/money_value").text = "PHP " + Profile.format_money(Profile.money)
		self.show()

#This method sets the selected patient to 0, then shows ReagentOverlay
func _on_patient1_pressed():
	if pretest:
		selected_patient = 0
		$ReagentHolder._on_patient_pressed()
	
#This method sets the selected patient to 1, then shows ReagentOverlay
func _on_patient2_pressed():
	if pretest:
		selected_patient = 1
		$ReagentHolder._on_patient_pressed()
	
#This method sets the selected patient to 2, then shows ReagentOverlay
func _on_patient3_pressed():
	if pretest:
		selected_patient = 2
		$ReagentHolder._on_patient_pressed()
	
#This method sets the selected patient to 3, then shows ReagentOverlay
func _on_patient4_pressed():
	if pretest:
		selected_patient = 3
		$ReagentHolder._on_patient_pressed()

#This method sets the selected patient to 4, then shows ReagentOverlay
func _on_patient5_pressed():
	if pretest:
		selected_patient = 4
		$ReagentHolder._on_patient_pressed()

#This sets the vaccine associated with a patient
func set_vaccine(selected_vaccine: int):
	var patient_reference = $Labels.get_node("p"+str(selected_patient))
	if selected_vaccine == -1 or selected_vaccine > max_vaccine:	
		patient_vaccines[selected_patient] = - 1
		patient_reference.text = "Blank"
	else:
		patient_vaccines[selected_patient] = selected_vaccine
		patient_reference.text = favorite_names[selected_vaccine-1]


#Reset TestingArea to initial State
func _on_reset_pressed():
	pretest  = true
	for x in range(-5):
		patient_vaccines[x] = -1
		$Labels.get_node("p"+str(selected_patient)).text= "Blank"

#Validate whether the player has enough of every bundle to launch the test.
#If not, tell the player yo buy more of a bundle.
#If so, instruct TestController to compute test results
func _on_test_pressed():
	var test_controller = get_parent().get_node("TestController")
	var test_results = test_controller.validate(patient_vaccines)
	var bundle_dict = get_node("/root/Session").mainDict["bundles"]
	if test_results != -1:
		var info_reference = $NotEnoughHolder.get_node("NotEnough")
		var message = "You do not have enough ingredients for this test. Buy more " + bundle_dict[str(test_results)]["bundleName"] + " from the Shop."
		$NotEnoughHolder.get_node("NotEnough").set_message(message)
		$NotEnoughHolder.show_info()
		return
	pretest = false
	$test.disabled = true
