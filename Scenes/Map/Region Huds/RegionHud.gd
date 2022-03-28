# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Node2D

var counter = 0
onready var deploy_button = $Buttons/DeployButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_DeployButton_pressed():
	counter = 0;
	_close_and_deploy()

func _on_CloseButton_pressed():
	_close_and_deploy()

func _close_and_deploy():
	var vaccines = get_node("Vaccines/ScrollContainer/VSeparator")
	for node in vaccines.get_children():
		vaccines.remove_child(node)
		node.queue_free()
	get_parent().hide()

func _process(delta):
	if counter == 0:
		deploy_button.disabled = true
	else:
		deploy_button.disabled = false


