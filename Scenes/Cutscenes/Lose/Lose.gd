extends Node2D


onready var message = $LoseCutsceneUI/Dialogue/DialogueBox/MarginContainer/Message
onready var tween = $Tween
onready var next_button = $LoseCutsceneUI/Dialogue/NextDialogue
onready var sprite_list = [$LoseCutsceneUI/Phil, $LoseCutsceneUI/suspend, $"LoseCutsceneUI/You Lose"]

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
var message_list = ["The majority of the Philippine population has succumbed to the virus, leaving only a small fraction of people to sustain the entirety of the nation. ", "Because of this, your research for a vaccine has been promptly suspended, turning you into a laughingstock in the vaccinology community. ", "Not only did you fail the Philippines and its people, but you have also failed the world."]

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
	if counter == 2:
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
