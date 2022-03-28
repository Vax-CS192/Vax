# Author: Aira Mae Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.


extends Node

var lab = preload("res://Scenes/Lab/Lab.tscn")

# Called when the node enters the scene tree for the first time.
#Bundle name, and color as well as Popup name are set here
func _ready():
	#randomize() #will be needed to randomize bundle names
	#Set Bundle Names
	$ShopControl/Bundle1/Bundle/Name.text="One"	
	$ShopControl/Bundle2/Bundle/Name.text="Two"
	$ShopControl/Bundle3/Bundle/Name.text="Three"
	$ShopControl/Bundle4/Bundle/Name.text="Four"
	$ShopControl/Bundle5/Bundle/Name.text="Five"
	$ShopControl/Bundle6/Bundle/Name.text="Six"
	$ShopControl/Bundle7/Bundle/Name.text="Seven"
	$ShopControl/Bundle8/Bundle/Name.text="Eight"
	$ShopControl/Bundle9/Bundle/Name.text="Nine"
	$ShopControl/Bundle10/Bundle/Name.text="Ten"
	$ShopControl/Bundle11/Bundle/Name.text="Eleven"
	$ShopControl/Bundle12/Bundle/Name.text="Twelve"
	$ShopControl/Bundle13/Bundle/Name.text="Thirteen"

	#Set name colors to compliment tables 
	$ShopControl/Bundle9/Bundle/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle10/Bundle/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle11/Bundle/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle12/Bundle/Name.set("custom_colors/font_color",Color(1,1,1,1))
	$ShopControl/Bundle13/Bundle/Name.set("custom_colors/font_color",Color(1,1,1,1))
	
	#Set PopupNames - Task: Create a function that fills up the popup details
	$ShopControl/Bundle1/Popup/ArchivePopupControl/FormulaName.text="One"
	$ShopControl/Bundle2/Popup/ArchivePopupControl/FormulaName.text="Two"
	$ShopControl/Bundle3/Popup/ArchivePopupControl/FormulaName.text="Three"
	$ShopControl/Bundle4/Popup/ArchivePopupControl/FormulaName.text="Four"
	$ShopControl/Bundle5/Popup/ArchivePopupControl/FormulaName.text="Five"
	$ShopControl/Bundle6/Popup/ArchivePopupControl/FormulaName.text="Six"
	$ShopControl/Bundle7/Popup/ArchivePopupControl/FormulaName.text="Seven"
	$ShopControl/Bundle8/Popup/ArchivePopupControl/FormulaName.text="Eight"
	$ShopControl/Bundle9/Popup/ArchivePopupControl/FormulaName.text="Nine"
	$ShopControl/Bundle10/Popup/ArchivePopupControl/FormulaName.text="Ten"
	$ShopControl/Bundle11/Popup/ArchivePopupControl/FormulaName.text="Eleven"
	$ShopControl/Bundle12/Popup/ArchivePopupControl/FormulaName.text="Twelve"
	$ShopControl/Bundle13/Popup/ArchivePopupControl/FormulaName.text="Thirteen"


#Go to Lab Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_node("/root/Session").hideAndChangeSceneTo(PersistentScenes.shop, lab.instance())


