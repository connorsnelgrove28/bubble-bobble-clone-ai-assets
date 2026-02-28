extends CharacterBody2D

@export var speed := 200.0
@export var jump_velocity := -450.0
@export var gravity := 900.0
@export var bubble_scene: PackedScene
@export var lives := 3

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var facing := 1
var invuln := 0.0
var dead := false
var flash_timer := 0.0

func _ready() -> void:
	add_to_group("player")
	add_to_group("wrap")

func _physics_process(delta: float) -> void:
	if dead:
		return

	if invuln > 0.0:
		invuln -= delta
		flash_timer += delta
		if flash_timer > 0.1:
			anim.visible = not anim.visible
			flash_timer = 0.0
	else:
		anim.visible = true

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var dir := Input.get_axis("move_left", "move_right")
	velocity.x = dir * speed

	if dir != 0:
		facing = dir

	if Input.is_action_just_pressed("fire"):
		shoot()

	move_and_slide()

	if not is_on_floor():
		anim.play("jump" if velocity.y < 0 else "fall")
	else:
		if abs(velocity.x) > 1:
			anim.play("run")
			anim.flip_h = velocity.x < 0
		else:
			anim.play("idle")

func shoot() -> void:
	if bubble_scene == null:
		return
	var b = bubble_scene.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position + Vector2(20 * facing, 0)
	b.dir = facing

func take_hit() -> void:
	if dead or invuln > 0.0:
		return

	lives = max(lives - 1, 0)

	var level = get_tree().current_scene
	if level.has_method("update_lives"):
		level.update_lives(lives)

	if lives == 0:
		dead = true
		if level.has_method("game_over"):
			level.game_over()
		return

	invuln = 1.0
	flash_timer = 0.0
