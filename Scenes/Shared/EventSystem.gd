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

# DESIGN: The event system craetes random events for the player as added challenges and stuff.
# EventSystem.gd will also be an autoload global since each event can affect multiple systems. 
# Each event possible will be declared here as a function. A timer will be created which will
# run a random number generator after some time. The random number generated will decide which 
# event will happen to the player.

extends Node

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	timer.start(600) # set timer for 10 mins

func startEvent():
	var event = randi() % 10 # get number between 0 - 9 inclusive
	
	# match event
	match event:
		0: return
		_: return

# TODO: what events should i use?

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
