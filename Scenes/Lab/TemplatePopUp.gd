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

extends TextureRect


onready var session = get_node("/root/Session")
signal pressedYesInTemplate


# Called when the node enters the scene tree for the first time.
func _ready():
	# when pressedYesInTemplate is emitted, call templateAddBundles in Session
	self.connect("pressedYesInTemplate", get_node("/root/Session"), "templateAddBundles")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# called when yes is pressed in template pop-up
func _on_Yes_pressed():
	# Deduct money
	Profile.money -= 500_000
	Profile.is_new_game = false
	# Add bundles to player
	# TODO
	emit_signal("pressedYesInTemplate")
	$".".queue_free()

# called when no is pressed
func _on_No_pressed():
	# Destroy self
	Profile.is_new_game = false
	$".".queue_free()
