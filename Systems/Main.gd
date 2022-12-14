extends Node

var license: Dictionary = {
	"name" : "GNU GPLv3",
	"content" : ""
}

var stage_to_load: String = ""

var stocks = 1

var players = 2
var player_data = [["TestFighter", false], ["TestFighter", true]]

var winner = -1

## Determines if solids should be visible
var debug = OS.is_debug_build()

signal debug_changed(value: bool)

func _init():
	var read = FileAccess.open("res://LICENSE", FileAccess.READ)
	license["content"] = read.get_as_text()
	var license_string = "SuperTuxBrawl is provided under the GNU General Public License version 3 or above. For more information, see the license file that came with your distribution"
	
	print("SuperTuxBrawl is provided under the GNU General Public License version 3 or above.
For more information, go to Settings > License in game, see the license file that came with your distribution of SuperTuxBrawl or see the online version at https://github.com/tulip-sudo/supertuxbrawl/blob/main/LICENSE\n")

func _process(delta):
	if Input.is_action_just_pressed("debug_toggle"):
		print("Toggling debug")
		toggle_debug()

func load_stage(stage_name: String, is_custom_stage: bool = false):
	stage_to_load = ("user://CustomStages/" if is_custom_stage else "res://Stages/") + stage_name + ".tscn"
	get_tree().change_scene_to_file("res://Systems/MatchManager.tscn")

func toggle_debug():
	debug = !debug
	emit_signal("debug_changed", debug)
