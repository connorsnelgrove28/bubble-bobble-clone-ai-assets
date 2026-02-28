extends Control

@export var main_scene_path := "res://scenes/Main.tscn"

func _ready() -> void:
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().change_scene_to_file(main_scene_path)
