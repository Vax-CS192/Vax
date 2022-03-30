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

extends Node

# This class provides methods to generate Symptoms and Bundles
class_name VirusGenerator

# letters that compose the symptoms and bundles
var alphabet = {
	"0": "t",
	"1": "a",
	"2": "c",
	"3": "g",
}

# generate Symptom. This returns a string made of "t", "a", "c", and "g" with
# parameter length
func generateSymptom(length: int) -> String:
	randomize()
	var symp = ""
	for i in range(length):
		var random = round(rand_range(0.0, 3.0))
		symp += alphabet.get(String(random))
	return symp

# generate bundles. baseSymp is the actual symptom, while genBund1, genBund2, and
# genBund3 are derived from it. baseSymp is supposed to be the bundle that cures
# the symptom by 100%, which is why it is the symptom as well. genBund1, genBund2, and
# genBund3 are bundles with less efficiency than baseSymp
func generateBundleSequence(base: String) -> String:
	randomize()
	var lengthOfBaseRetained = round(rand_range(1,9))
	var genBund1 = base.substr(0,lengthOfBaseRetained) \
					+ generateSymptom(10 - lengthOfBaseRetained)
	return genBund1
	
func generateBundle(id: int, key: int, price: float, bundleName: String, 
	desc: String, sequence: String) -> Dictionary:
		return	{
			"id": id,
			"symptom": key,
			"price": price,
			"bundleName": bundleName,
			"desc": desc,
			"sequence": sequence
			}
