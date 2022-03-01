extends Node

onready var message = $CutsceneUI/Dialogue/DialogueBox/MarginContainer/Message
onready var tween = $Tween
onready var next_button = $CutsceneUI/Dialogue/NextDialogue
onready var sprite_list = [$CutsceneUI/Earth, $CutsceneUI/Viruses, $CutsceneUI/Sickness, $CutsceneUI/Death, $CutsceneUI/Prevention, $CutsceneUI/Corruption, $CutsceneUI/Research]

# ENUMS
enum State {
	READY,
	READING,
	DONE
}

# Declare member variables here.
var counter = 0
var gameStart = true
const CHAR_READ_RATE = 0.05

# Declare List Variables here
var message_list = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam posuere, nibh quis faucibus fermentum, arcu orci semper ante, a sollicitudin urna mi eget nisl.", "Nullam ultrices ultricies enim, sit amet congue nisl volutpat ac. Donec facilisis elementum vestibulum. Donec tincidunt malesuada elementum.", "Cras ut placerat sem, ut tincidunt orci. Aenean aliquam eros tortor, in sodales lorem commodo vitae. Vestibulum finibus felis erat, non eleifend lacus malesuada volutpat.", "Ut suscipit ullamcorper tempor. Etiam pharetra metus quis fringilla egestas. Fusce vitae nisi ac metus tristique pellentesque id vitae purus. Maecenas quis mi facilisis, elementum neque in, gravida ligula.", "Sed at cursus leo. Maecenas quis dictum quam, nec scelerisque diam.", "Aenean efficitur viverra justo. Quisque feugiat sit amet tellus a bibendum. Proin auctor massa urna, ut tempor sapien lobortis ut. Aliquam ut odio nec massa auctor posuere.", "Duis eget laoreet ex. Etiam vel condimentum risus. Vestibulum maximus arcu eget ullamcorper laoreet. Nullam et urna quis diam tincidunt commodo.", "Nam molestie urna ac justo tristique, eu varius augue facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis rutrum nisl, at bibendum nisi ornare eget."]

# Declare string variables here

# Other variables
var current_state = State.READY

# Called when the node enters the scene tree for the first time.
func _ready():
	next_button.hide()
	
func show_message(new_message):
	gameStart = false;
	message.text = new_message
	state_change(State.READING)
	$Tween.interpolate_property(message, "percent_visible", 0.0, 1.0, len(message_list[counter]) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func state_change(next_state):
	current_state = next_state
		
func _on_NextDialogue_pressed():
	if counter == 6:
		get_tree().change_scene("res://Scenes/Cutscenes/PresidentInput.tscn")
	else:
		if current_state == State.DONE:
			counter += 1
			message.text = ""
			next_button.hide()
			current_state = State.READY

func _on_Tween_tween_all_completed():
	next_button.show()
	state_change(State.DONE)

func update_sprites():
	if counter == 1:
		sprite_list[counter].show()
	elif counter == 2:
		sprite_list[0].hide()
		sprite_list[1].hide()
		sprite_list[counter].show()
	elif counter > 2:
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
