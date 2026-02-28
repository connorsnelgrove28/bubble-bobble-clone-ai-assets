extends Node2D

@export var game_over_scene_path := "res://scenes/GameOver.tscn"
@export var win_scene_path := "res://scenes/win.tscn"
@export var enemy_scene: PackedScene

@export var wrap_bottom_y := 720.0
@export var wrap_top_y := 40.0

var score := 0
var did_win := false

func _ready() -> void:
	$HUD/ScoreLabel.text = "Score: 0"
	$HUD/LivesLabel.text = "Lives: 3"
	spawn_enemies()

func _process(_delta: float) -> void:
	# wrap
	for n in get_tree().get_nodes_in_group("wrap"):
		if n.global_position.y > wrap_bottom_y:
			n.global_position.y = wrap_top_y

	# win (all enemies gone)
	if not did_win and get_tree().get_nodes_in_group("enemies").size() == 0:
		did_win = true
		call_deferred("_go_win")

func _go_win() -> void:
	get_tree().change_scene_to_file(win_scene_path)

func spawn_enemies() -> void:
	if enemy_scene == null:
		return

	var positions = [
		Vector2(120, 520),
		Vector2(760, 520),
		Vector2(200, 360),
		Vector2(680, 360),
		Vector2(440, 200),
	]

	for p in positions:
		var e = enemy_scene.instantiate()
		add_child(e)
		e.global_position = p
		e.add_to_group("wrap")

func add_score(points: int) -> void:
	score += points
	$HUD/ScoreLabel.text = "Score: %d" % score

func update_lives(v: int) -> void:
	$HUD/LivesLabel.text = "Lives: %d" % v

func game_over() -> void:
	call_deferred("_go_game_over")

func _go_game_over() -> void:
	get_tree().change_scene_to_file(game_over_scene_path)
