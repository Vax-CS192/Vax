extends Node2D


onready var message = $WinCutsceneUI/Dialogue/DialogueBox/MarginContainer/Message
onready var tween = $Tween
onready var next_button = $WinCutsceneUI/Dialogue/NextDialogue
onready var sprite_list = [$"WinCutsceneUI/Herd Immunity", $WinCutsceneUI/International, $WinCutsceneUI/Caught, $WinCutsceneUI/Earth]

# ENUMS for the state when updating text in the dialogue box
enum State {
	READY,
	READING,
	DONE
}

# Declare member variables here.
var counter = 0
var gameStart = true
const CHAR_READ_RATE = 0.0125

# Declare List Variables here
var message_list = ["Through your efforts in creating a vaccine for the virus with the Philippines as a staging area, the Philippine population has achieved total herd immunity. ", "Early preparations for mass-production and ethical mass-distribution will now proceed on an international scale.", "Corrupt politicians, particularly President %s, have now been removed from power and are now promptly facing numerous charges of corruption amidst the pandemic." % Profile.president_name, "Although many people were lost in the way during the vaccine’s creation, humanity has survived thanks to your competence and efficiency. Through the success of your vaccine creation in the Philippines, you have saved the world!"]

# Declare string variables here

# Other variables
var mainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn")
var current_state = State.READY

# Called when the node enters the scene tree for the first time.
func _ready():
	next_button.hide()

# function responsible for showing the running text on the dialogue box
func show_message(new_message):
	gameStart = false;
	message.text = new_message
	state_change(State.READING)
	$Tween.interpolate_property(message, "percent_visible", 0.0, 1.0, len(message_list[counter]) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

# function with input argument which is the next state that the dialogue box will take
func state_change(next_state):
	current_state = next_state

# This changes the current dialogue message to the next message of the story
func _on_NextDialogue_pressed():
	if counter == 3:
		get_node("/root/Session").changeSceneTo(self, mainMenu.instance())
		get_node("root/Session").remove_child(self)
	else:
		if current_state == State.DONE:
			counter += 1
			message.text = ""
			next_button.hide()
			current_state = State.READY

# checks for tween signal completion
func _on_Tween_tween_all_completed():
	next_button.show()
	state_change(State.DONE)

# function respnsible for updating the sprite that is shown on the screen
func update_sprites():
	if counter > 0:
		sprite_list[counter-1].hide()
		sprite_list[counter].show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_sprites()
	match current_state:
		State.READY:
			show_message(message_list[counter])
		State.READING:
			pass
		State.DONE:
			pass
