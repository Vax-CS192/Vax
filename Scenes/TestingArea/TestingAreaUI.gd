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
var testing = false
var test_done = false
var favorite_names = []
var demo = false
var waiting_time = 1800
var timer_ctime = 0
var first_draw = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func first_draw_init():
	if demo :
		waiting_time = 15
	var testcontroller = get_parent().get_node("TestController")
	pretest = testcontroller.load_property("pretest")
	testing = testcontroller.load_property("testing")
	test_done = testcontroller.load_property("test_done")
	if testing:
		$test.disabled = true
		$patient1.disabled = true
		$patient2.disabled = true
		$patient3.disabled = true
		$patient4.disabled = true
		$patient5.disabled = true  
		$Cooldown.start(waiting_time - (OS.get_unix_time() - testcontroller.load_property("start_time")))
		$TimeLeft.show()
		
	timer_ctime = OS.get_unix_time()
#Format Time into MM		
func format_time(some_time):
	var discretized = int(some_time)
	var minutes_left = int(discretized/60)
	var seconds_left = discretized%60
	var pad_seconds = ""
	var pad_minutes = ""
	if seconds_left <10:
		pad_seconds = "0"
	if minutes_left <10:
		pad_minutes = "0"
	return pad_minutes + str(minutes_left)+":"+pad_seconds+str(seconds_left)

#If in testing stage, update counter on every frame.
func _process(_delta):
	if testing:
		$TimeLeft.text = format_time($Cooldown.get_time_left())
#	pass

#  This method causes the TestingAreaUI to signal to TestController to instance the Lab
#  subsystem and to hide TestingAreaUI
func _on_back_pressed():
	var testcontroller = get_parent().get_node("TestController") 
	testcontroller.save_data(timer_ctime,pretest,testing,test_done)
	emit_signal("back_pressed")

# This method updates the money and the favorite  and draws TestingAreaUI to screen
func draw():
		if first_draw:
			first_draw_init()
			first_draw = false
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
	testing = false
	test_done = false
	$TimeLeft.hide()
	for x in range(5):
		patient_vaccines[x] = -1
		$Labels.get_node("p"+str(x)).text= "Blank"
	$test.disabled = false
	$patient1.disabled = false
	$patient2.disabled = false
	$patient3.disabled = false
	$patient4.disabled = false
	$patient5.disabled = false
	
#Validate whether the player has enough of every bundle to launch the test.
#If not, tell the player yo buy more of a bundle.
#If so, instruct TestController to compute test results and make the appropriate deductions
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
	testing = true
	$test.disabled = true
	$patient1.disabled = true
	$patient2.disabled = true
	$patient3.disabled = true
	$patient4.disabled = true
	$patient5.disabled = true
	test_controller.execute_test(patient_vaccines)
	$Cooldown.start(waiting_time)
	$TimeLeft.show()
	timer_ctime = OS.get_unix_time()

#Switch to post-test state after timeout
func _on_Cooldown_timeout():
	testing = false
	test_done = true
	$Cooldown.stop()
	$TimeLeft.hide()
	$patient1.disabled = false
	$patient2.disabled = false
	$patient3.disabled = false
	$patient4.disabled = false
	$patient5.disabled = false
	
