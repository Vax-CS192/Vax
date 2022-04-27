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
signal bundle_unpressed(path)
signal update_bundle()
var path = ""
var bundleNumber = 0

func _on_Popup_about_to_show(fp_slot,passed_path,bundle_deets):
	#print("updating", fp_slot)
	path=passed_path
	bundleNumber = fp_slot

	#update popup details
	$ArchivePopupControl/FormulaName.text=bundle_deets["bundleName"]
	$ArchivePopupControl/FormulaNote.text=bundle_deets["desc"]
	$ArchivePopupControl/Price.text=bundle_deets["price"]
	#$ArchivePopupControl/FormulaNote.text=
	#$ArchivePopupControl/Price.text=
	self.popup_centered()

#runs when popup is hidden
func _on_Popup_popup_hide():
	emit_signal("bundle_unpressed",path)
	self.hide() # Replace with function body.

#increase instock number of the formula
func _on_Buy_Button_pressed():
	var bundle_Dict = get_node("/root/Session").mainDict["bundles"]
	bundle_Dict[str(bundleNumber-1)]["inStock"]=str(int(bundle_Dict[str(bundleNumber-1)]["inStock"])+3)
	
	#save updated name and note
	bundle_Dict[str(bundleNumber-1)]["bundleName"]=$ArchivePopupControl/FormulaName.text
	bundle_Dict[str(bundleNumber-1)]["desc"]=$ArchivePopupControl/FormulaNote.text
	
	#update fund and counter
	Profile.money-=int(bundle_Dict[str(bundleNumber-1)]["price"])
	emit_signal("update_bundle")
	self.hide() # Replace with function body.
