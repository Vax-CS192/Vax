# Author: Aira Mae Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.
 
extends Node2D

signal bundle_pressed
signal bundle_unpressed

var open_bundle = preload("res://Assets/Shop/Destructible Objects Sprite Sheet - Opened.png")
var closed_bundle = preload("res://Assets/Shop/Destructible Objects Sprite Sheet - Normal.png")
onready var bundle_Dict = get_node("/root/Session").mainDict["bundles"]

# Called when the node enters the scene tree for the first time.
# Bundle name, and color as well as Popup name are set here.
func _ready():
	#randomize() #will be needed to randomize bundle names
	#Set Bundle Names

	set_bundle_deets()

#Syncs money
func _process(delta):
	$Coin/money.text="PHP "+ Profile.format_money(Profile.money)

#Setcounter and name
#Task: call a signal to  enable this function whenever a counter is updated
func set_bundle_deets():
	for i in range(20):
		var bundle_deets = bundle_Dict[str(i)]#Task: ask if 1- index or zero-iondex
		var name_path = "ShopControl/Bundle"+str(i+1)+"/Name"
		get_node(name_path).text =bundle_deets["bundleName"]

		var counter_path = "ShopControl/Bundle"+str(i+1)+"/Counter"
		get_node(counter_path).text =bundle_deets["inStock"]
		
#Go to Lab Subsystem when the button is pressed	
func _on_BackButton_pressed():
	var shop_subsystem = get_parent()
	shop_subsystem.get_node("Shop").hide()
	var lab_subsystem = preload("res://Scenes/Lab/Lab.tscn")
	get_parent().get_parent().add_child(lab_subsystem.instance())

#When bundle is pressed shop 
func _on_BundleIcon_pressed(fp_slot):
	var bundle_Dict = get_node("/root/Session").mainDict["bundles"]
	#print(bundle_Dict)
	var bundle_deets = bundle_Dict[str(fp_slot-1)]#Task: ask if 1- index or zero-iondex
	var path = "ShopControl/Bundle"+str(fp_slot)
	_on_Popup_bundle_pressed(path)
	$Popup._on_Popup_about_to_show(fp_slot,path,bundle_deets)

func _on_Bundle1_pressed():
	_on_BundleIcon_pressed(1)

func _on_Bundle2_pressed():
	_on_BundleIcon_pressed(2)

func _on_Bundle3_pressed():
	_on_BundleIcon_pressed(3)

func _on_Bundle4_pressed():
	_on_BundleIcon_pressed(4)
	
func _on_Bundle5_pressed():
	_on_BundleIcon_pressed(5)

func _on_Bundle6_pressed():
	_on_BundleIcon_pressed(6)

func _on_Bundle7_pressed():
	_on_BundleIcon_pressed(7)

func _on_Bundle8_pressed():
	_on_BundleIcon_pressed(8)

func _on_Bundle9_pressed():
	_on_BundleIcon_pressed(9)

func _on_Bundle10_pressed():
	_on_BundleIcon_pressed(10)

func _on_Bundle11_pressed():
	_on_BundleIcon_pressed(11)

func _on_Bundle12_pressed():
	_on_BundleIcon_pressed(12)

func _on_Bundle13_pressed():
	_on_BundleIcon_pressed(13)

func _on_Bundle14_pressed():
	_on_BundleIcon_pressed(14)

func _on_Bundle15_pressed():
	_on_BundleIcon_pressed(15)

func _on_Bundle16_pressed():
	_on_BundleIcon_pressed(16)

func _on_Bundle17_pressed():
	_on_BundleIcon_pressed(17)

func _on_Bundle18_pressed():
	_on_BundleIcon_pressed(18)

func _on_Bundle19_pressed():
	_on_BundleIcon_pressed(19)

func _on_Bundle20_pressed():
	_on_BundleIcon_pressed(20)

#Changes bundle icon to opened once popup is opened
func _on_Popup_bundle_pressed(path):
	get_node(path).texture_normal=open_bundle
	
#Changes bundle icon to normal once popup is closed
func _on_Popup_bundle_unpressed(path):
	get_node(path).texture_normal=closed_bundle
