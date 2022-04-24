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

# generateBundleSequnce returns a sequence that is randomly altered from the base
func generateBundleSequence(base: String) -> String:
	randomize()
	var lengthOfBaseRetained = round(rand_range(1,9))
	var genBund1 = base.substr(0,lengthOfBaseRetained) \
					+ generateSymptom(10 - lengthOfBaseRetained)
	return genBund1

# generateBundle returns a dictionary that represents a bundle
func generateBundle(id: String, key: String, price: String, inStock: String, bundleName: String, 
	desc: String, sequence: String) -> Dictionary:
		return	{
			"id": id,
			"symptom": key,
			"price": price,
			"inStock": inStock,
			"bundleName": bundleName,
			"desc": desc,
			"sequence": sequence,
			}
