# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends Node2D

var counter = 0
onready var deploy_button = $Buttons/DeployButton
var vaccines = []
onready var child_vaccines = get_node("Vaccines/ScrollContainer/VSeparator")

# called whenever the deploy button is pressed, which basically calls the _close_and_deploy function
func _on_DeployButton_pressed():
	get_parent().get_parent().disable_region()
	get_parent().delete_vaccines(vaccines)
	_close_and_deploy()

# called whenever the close button is pressed, which basically calls the _close_and_deploy function
func _on_CloseButton_pressed():
	_close_and_deploy()

# function responsible for closing all child instance of the Vseparator node in the scene, it then hides the region hud
func _close_and_deploy():
	delete_vaccines()
	get_parent().hide()
	counter = 0;

func _process(delta):
	if counter == 0:
		deploy_button.disabled = true
	else:
		deploy_button.disabled = false

func delete_vaccines():
	for node in child_vaccines.get_children():
		child_vaccines.remove_child(node)
		node.queue_free()

func add_vaccine(vaccineName):
	vaccines.append(vaccineName)

func remove_vaccine(vaccineName):
	vaccines.erase(vaccineName)
