# Author: John Henry A. Galino
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without 
# fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.

extends Control

# preload to make loading faster for these scenes
var cutscene = preload("res://Scenes/Cutscenes/Cutscene.tscn")
var virus_0 = preload("res://Scenes/MainMenu/Virus_0.tscn")
var virus_1 = preload("res://Scenes/MainMenu/Virus_1.tscn")
var lab = load("res://Scenes/Lab/Lab.tscn")

export var num_of_viruses = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() # randomize seed for random number
	
	# spawn n viruses 
	for x in range(num_of_viruses + 1):
		# randomly decide which virus to spawn
		var rand_num = randi() % 2
		var vir: Node2D
		
		# parameter to change size of virus randomly
		var vir_scale = rand_range(1,3)
		
		if rand_num == 0:
			vir = virus_0.instance()
		elif rand_num == 1:
			vir = virus_1.instance()
		
		# randomize spawn position of virus
		vir.position.x = rand_range(100, 2800)
		vir.position.y = rand_range(100, 1300)
		
		vir.scale = Vector2(vir_scale,vir_scale)
		# instantiate virus
		add_child_below_node($BackgroundColor, vir)
	
	# load data to check if continue button should be disabled
	Profile.load_data()
	
	# if new game, disable continue button
	if Profile.is_new_game == true:
		# set this to true later
		$CanvasLayer/Buttons/Continue.disabled = false
	else:
		$CanvasLayer/Buttons/Continue.disabled = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# changes scene to Cutscene when new game is pressed
func _on_NewGame_pressed():
	# set new game to true and set money
	Profile.is_new_game = true
	Profile.money = 1_000_000
	get_node("/root/Session").changeSceneTo(self, cutscene.instance())
	PersistentScenes.map.initialize_regions()

# when continue is pressed, go to Lab
# still have to load saved stuff
func _on_Continue_pressed():
	get_node("/root/Session").changeSceneTo(self, lab.instance())

# exit
func _on_Exit_pressed():
	get_tree().quit()
