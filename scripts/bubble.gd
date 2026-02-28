extends Area2D

@export var speed := 200.0
@export var float_speed := 60.0
@export var lifetime := 3.0
@export var escape_time := 6.0
@export var pop_points := 100
@export var top_y := 50.0
@export var left_x := 50.0
@export var right_x := 1250.0

var dir := 1
var float_up := false
var t := 0.0

var trapped: CharacterBody2D = null
var trapped_time := 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	t += delta
	if t > 0.5:
		float_up = true

	# move
	if float_up:
		global_position.y -= float_speed * delta
	else:
		global_position.x += dir * speed * delta

	# stop at ceiling (do NOT pop)
	if global_position.y <= top_y:
		global_position.y = top_y
		float_up = false

	# stop at sides (do NOT pop)
	if global_position.x <= left_x:
		global_position.x = left_x
	if global_position.x >= right_x:
		global_position.x = right_x

	# keep trapped enemy stuck to bubble
	if trapped:
		trapped_time += delta
		trapped.global_position = global_position

		if trapped_time >= escape_time:
			_release_enemy()
			queue_free()
			return

	# bubble lifetime
	if t > lifetime:
		if trapped:
			_release_enemy()
		queue_free()

func _on_body_entered(body: Node) -> void:
	if trapped == null and body.is_in_group("enemies"):
		_capture(body)
		return

	if trapped != null and body.is_in_group("player"):
		var level = get_tree().current_scene
		if level.has_method("add_score"):
			level.add_score(pop_points)
		trapped.queue_free()
		queue_free()

func _capture(body: Node) -> void:
	trapped = body as CharacterBody2D
	trapped_time = 0.0
	trapped.set_physics_process(false)
	trapped.velocity = Vector2.ZERO

	var cs := trapped.get_node_or_null("CollisionShape2D")
	if cs:
		cs.set_deferred("disabled", true)

	var hb := trapped.get_node_or_null("HurtBox")
	if hb == null:
		hb = trapped.get_node_or_null("Hurtbox")
	if hb:
		hb.set_deferred("monitoring", false)
		var hb_cs := hb.get_node_or_null("CollisionShape2D")
		if hb_cs:
			hb_cs.set_deferred("disabled", true)

func _release_enemy() -> void:
	if trapped == null:
		return

	trapped.set_physics_process(true)

	var cs := trapped.get_node_or_null("CollisionShape2D")
	if cs:
		cs.set_deferred("disabled", false)

	var hb := trapped.get_node_or_null("HurtBox")
	if hb == null:
		hb = trapped.get_node_or_null("Hurtbox")
	if hb:
		hb.set_deferred("monitoring", true)
		var hb_cs := hb.get_node_or_null("CollisionShape2D")
		if hb_cs:
			hb_cs.set_deferred("disabled", false)
