extends TextureButton
class_name Card

signal card_revealed(card: Card)

var team_id: int = -1
var front_texture: Texture2D
var back_texture: Texture2D
var is_flipped := false
var is_matched := false
var can_click := true

func setup(id: int, front_tex: Texture2D, back_tex: Texture2D) -> void:
	team_id = id
	front_texture = front_tex
	back_texture = back_tex
	texture_normal = back_tex
	ignore_texture_size = true
	stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED

func _ready() -> void:
	pivot_offset = size / 2.0
	resized.connect(func(): pivot_offset = size / 2.0)
	pressed.connect(_on_pressed)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_pressed() -> void:
	if not can_click or is_flipped or is_matched:
		return
	flip_up()
	card_revealed.emit(self)

func flip_up() -> void:
	is_flipped = true
	can_click = false
	_animate_flip(front_texture, false)

func flip_down() -> void:
	is_flipped = false
	_animate_flip(back_texture, true)

func _animate_flip(new_texture: Texture2D, enable_click_after: bool) -> void:
	var tw := create_tween()
	tw.tween_property(self, "scale:x", 0.0, 0.12).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tw.tween_callback(func(): texture_normal = new_texture)
	tw.tween_property(self, "scale:x", 1.0, 0.12).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if enable_click_after:
		tw.tween_callback(func(): can_click = true)

func set_matched() -> void:
	is_matched = true
	can_click = false
	var tw := create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.35).set_trans(Tween.TRANS_SINE)
	tw.parallel().tween_property(self, "scale", Vector2(0.7, 0.7), 0.35).set_trans(Tween.TRANS_SINE)
	tw.tween_callback(func(): visible = false)
