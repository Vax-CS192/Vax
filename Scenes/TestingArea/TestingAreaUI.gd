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
		var reagent_overlay = $ReagentHolder.get_node("ReagentHolder/ReagentOverlay")
		
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
	if selected_vaccine <= max_vaccine:
		patient_vaccines[selected_patient] = selected_vaccine
	else:	
		patient_vaccines[selected_patient] = - 1
		patient_reference.text = "Blank"

#Reset TestingArea to initial State
func _on_reset_pressed():
	pretest  = true
	for x in range(-5):
		patient_vaccines[x] = -1
		$Labels.get_node("p"+str(selected_patient)).text= "Blank"
