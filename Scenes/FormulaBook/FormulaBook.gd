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

# Called every frame. 'delta' is the elapsed time since the previous frame.
# The formula name and state are set here.
func _process(delta):
	#Set Formula State and Name
	$FormulaBookControl/Formula1.is_occupied=true
	get_node("FormulaBookControl/Formula1/Name").text="NGALAN"
	$FormulaBookControl/Formula2.is_occupied=true
	get_node("FormulaBookControl/Formula2/Name").text="MARAHUYO"
	$FormulaBookControl/Formula3.is_occupied=true
	get_node("FormulaBookControl/Formula3/Name").text="PAYZER"
	$FormulaBookControl/Formula4.is_occupied=true
	get_node("FormulaBookControl/Formula4/Name").text="SAYA"
	$FormulaBookControl/Formula5.is_occupied=true
	get_node("FormulaBookControl/Formula5/Name").text="SIGLA"
	$FormulaBookControl/Formula6.is_occupied=true
	get_node("FormulaBookControl/Formula6/Name").text="LIGAYA"
	$FormulaBookControl/Formula7.is_occupied=true
	get_node("FormulaBookControl/Formula7/Name").text="MANAWARI"
	$FormulaBookControl/Formula8.is_occupied=true
	get_node("FormulaBookControl/Formula8/Name").text="J&J"


#Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Cauldron/Cauldron.tscn")

func _on_ArchiveIcon_pressed():
	get_tree().change_scene("res://Scenes/FormulaBook/Archive Page/ArchivePage.tscn")
