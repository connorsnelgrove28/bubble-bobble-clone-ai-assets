extends CharacterBody2D

@export var speed := 100.0
@export var gravity := 900.0

var dir := -1
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	add_to_group("enemies")
	add_to_group("wrap")
	anim.play("slime")
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = dir * speed
	move_and_slide()

	if is_on_wall():
		dir *= -1
		anim.flip_h = dir > 0

func _on_hurtbox_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("take_hit"):
		body.take_hit()
