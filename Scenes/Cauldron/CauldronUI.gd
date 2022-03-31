
# Author: Jeremy Vincent Yu
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
signal back_to_lab
signal open_formulabook
extends Node2D
var yellow_scene
var blue_scene
var red_scene
var violet_scene
var green_scene

func _ready():
	yellow_scene = preload("res://Scenes/Cauldron/Ingredients/Yellow.tscn")
	blue_scene = preload("res://Scenes/Cauldron/Ingredients/Blue.tscn")
	red_scene = preload("res://Scenes/Cauldron/Ingredients/Red.tscn")
	violet_scene = preload("res://Scenes/Cauldron/Ingredients/Violet.tscn")
	green_scene = preload("res://Scenes/Cauldron/Ingredients/Green.tscn")
	var group_width = 600
	var formula_depth = 1200
	for x in range(4):
		var yellow = yellow_scene.instance()
		var blue = blue_scene.instance() 
		var red = red_scene.instance() 
		var violet = violet_scene.instance() 
		var green = green_scene.instance() 
		yellow.set_up("Y",80+x*group_width,formula_depth)
		$Bundles.add_child(yellow)
		blue.set_up("B",200+x*group_width,formula_depth)
		$Bundles.add_child(blue)
		red.set_up("R",320+x*group_width,formula_depth)
		$Bundles.add_child(red)
		violet.set_up("V",440+x*group_width,formula_depth)
		$Bundles.add_child(violet)
		green.set_up("G",560+x*group_width,formula_depth)
		$Bundles.add_child(green)
		
#Change the names of ingredients to reflect what is in the bundles
func draw():
	var bundle_dict = get_node("/root/Session").mainDict["bundles"]
	var all_ingredients = $Bundles.get_children()
	for x in range(20):
		all_ingredients[x].set_name(bundle_dict[str(x)]["bundleName"])
		self.show()
# Check whether the mix button should be enabled every frame
# Also, update money in real time
func _process(_delta):
	get_node("money_bg/money_value").text = "PHP "+ Profile.format_money(Profile.money)
	var all_bundles = $Bundles.get_children()
	var total_selected = 0;
	for every_bundle in all_bundles:
		if every_bundle.rect_position.y < 441:
			total_selected += 1
	if total_selected > 0 and total_selected<6:
		$mix_button.disabled = false
		return
	$mix_button.disabled = true

#  This method causes the CauldronUI to signal to the cauldron controller to instance the Lab
#  subsystem and remove the Cauldron subsystem from memory.
func _on_Back_pressed():
	emit_signal("back_to_lab")

#This method causes the CauldronUI to signal to the cauldron controller to instance the Formulabook
#  subsystem and remove the Cauldron subsystem from memory.
func _on_formulabook_icon_pressed():
	emit_signal("open_formulabook")

#This forwards all releevant information to the CauldronController.
func confirm(name,description):
	var cauldron_controller = get_parent().get_node("CauldronController")
	var five_array = []
	var counter = 0
	for ingredient in $Bundles.get_children():
		if ingredient.included:
			five_array.append(str(counter))
		counter += 1
	var remaining_blanks = 5 - len(five_array)
	for x in range(remaining_blanks):
		five_array.append(str(-1))
	cauldron_controller.add_to_formulabook(name,description,five_array)
#Propagate the MixPopup's signal to the individual bundles
func reset():
	var all_bundles = $Bundles.get_children()
	for bundle in all_bundles:
		bundle.reset()
		
#Selects an ingredient and puts it on the working area
func select_ingredient(bundle_id):
	var all_bundles = $Bundles.get_children()
	all_bundles[int(bundle_id)].select()
