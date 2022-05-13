# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Node

onready var message = $CutsceneUI/Dialogue/DialogueBox/MarginContainer/Message
onready var tween = $Tween
onready var next_button = $CutsceneUI/Dialogue/NextDialogue
onready var sprite_list = [$CutsceneUI/Earth, $CutsceneUI/Viruses, $CutsceneUI/Sickness, $CutsceneUI/Death, $CutsceneUI/Prevention, $CutsceneUI/Corruption, $CutsceneUI/Research]
var president_input = load("res://Scenes/Cutscenes/PresidentInput.tscn")

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
var message_list = ["At present, the world was at a state of tranquility. Conflicts between nations became a thing of the past, the dream of world peace had already been achieved, and every person living in the planet contently lived in peace and prosperity. ", "Until...", "A virus of unknown origin suddenly began to rise into prominence and set a panic to nations globally. Governments left and right failed to properly contain the spread of the virus and not before long, ", "the said virus had already been considered by health officials as a global pandemic.", "Governments and health organizations began observing the effects and symptoms of the virus itself. They found that the most usual of which were bodily fatigue, non-stop coughing, and intense fevers. ", "They preemptively concluded that the virus was non-lethal.", "While the said organizations were confident that the virus was indeed non-lethal, recent infection cases have begun proving otherwise. The virus, either from a mutation or out of sheer incompetence,", "had been found out to actually be deadly, bringing death in its wake and sending the public into further chaos.", "While scientists had postulated that measures to mitigate the severity of the virus’ symptoms (having proper weight, exercising, eating healthy foods, etc.) were effective in combatting the virus itself,", "they have soon backed down on those sentiments after much evidence had suggested no effect at all. They concluded that the only hope for humanity’s survival is the creation of a vaccine against the disease.", "With the production of vaccines in mind, politicians have begun swarming at the idea of manipulating and exploiting the vaccine for their own personal gain, be it from a global monopoly to boost their respective economies", "or by colluding with scientists themselves to hide further information about the nature of the virus.", "As a world-renowned vaccinologist, you have been tasked to research and work on a vaccine to combat against the deadly symptoms of the global pandemic. The country of the Philippines will serve as your primary staging area for this great task.", "The fate of the world as well as humanity’s survival is in your hands. Good luck!"]

# Declare string variables here

# Other variables
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
	if counter == 13:
		get_node("/root/Session").changeSceneTo(self, president_input.instance())
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
	if counter == 2:
		sprite_list[1].show()
	elif counter == 4:
		sprite_list[0].hide()
		sprite_list[1].hide()
		sprite_list[2].show()
	elif counter > 5:
		sprite_list[(counter/2)-1].hide()
		sprite_list[counter/2].show()
	pass
	
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
