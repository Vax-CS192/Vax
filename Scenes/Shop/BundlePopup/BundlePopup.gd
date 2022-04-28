# Author: Aira Mae E. Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without 
# fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.

extends Popup

var buy_inactive=preload("res://Assets/Shop/Bundle Popup/Buy Button Inactive.png")
var buy_active=preload("res://Assets/Shop/Bundle Popup/Buy Button.png")

signal bundle_unpressed(path)
signal update_bundle()
var path = ""
var bundleNumber = 0
var bundle_deets={}

func _on_Popup_about_to_show(fp_slot,passed_path,deets):
	#print("updating", fp_slot)
	path=passed_path
	bundleNumber = fp_slot
	bundle_deets=deets
	#update popup details
	update_deets()
	#$ArchivePopupControl/FormulaNote.text=
	#$ArchivePopupControl/Price.text=
	self.popup_centered()

func update_deets():
	$ArchivePopupControl/FormulaName.text=bundle_deets["bundleName"]
	$ArchivePopupControl/FormulaNote.text=bundle_deets["desc"]
	$ArchivePopupControl/Price.text="Php "+bundle_deets["price"]
	var bundle_Dict = get_node("/root/Session").mainDict["bundles"]
	if Profile.money > int(bundle_Dict[str(bundleNumber-1)]["price"]):
		$ArchivePopupControl/BuyButton.texture_normal=buy_active
	else:
		$ArchivePopupControl/BuyButton.texture_normal=buy_inactive
#runs when popup is hidden
func _on_Popup_popup_hide():
	emit_signal("bundle_unpressed",path)
	self.hide() # Replace with function body.

#increase instock number of the formula
func _on_Buy_Button_pressed():
	var bundle_Dict = get_node("/root/Session").mainDict["bundles"]
	if Profile.money > int(bundle_Dict[str(bundleNumber-1)]["price"]):
		bundle_Dict[str(bundleNumber-1)]["inStock"]=str(int(bundle_Dict[str(bundleNumber-1)]["inStock"])+3)
		print("count: ",bundle_Dict[str(bundleNumber-1)]["inStock"])
		
		#save updated name and note
		bundle_Dict[str(bundleNumber-1)]["bundleName"]=$ArchivePopupControl/FormulaName.text
		bundle_Dict[str(bundleNumber-1)]["desc"]=$ArchivePopupControl/FormulaNote.text
		
		#update fund and counter
		Profile.money-=int(bundle_Dict[str(bundleNumber-1)]["price"])
		emit_signal("update_bundle")
	self.hide() # Replace with function body.
