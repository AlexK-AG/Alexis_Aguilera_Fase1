extends Control

const CardScene: PackedScene = preload("res://scenes/Card.tscn")
const BACK_IMAGE: Texture2D = preload("res://assets/backgrounds/card_back.svg")

const TEAM_IMAGES: Array[Texture2D] = [
	preload("res://assets/teams/barca.svg"),
	preload("res://assets/teams/bayern.svg"),
	preload("res://assets/teams/betis.svg"),
	preload("res://assets/teams/boca.svg"),
	preload("res://assets/teams/colombia.svg"),
	preload("res://assets/teams/fluminense.svg"),
	preload("res://assets/teams/inter.svg"),
	preload("res://assets/teams/real.svg"),
]

@onready var grid: GridContainer = %Grid
@onready var moves_label: Label = %MovesLabel
@onready var pairs_label: Label = %PairsLabel
@onready var restart_button: Button = %RestartButton
@onready var win_panel: Panel = %WinPanel
@onready var win_label: Label = %WinLabel
@onready var play_again_button: Button = %PlayAgainButton

var first_card: Card = null
var second_card: Card = null
var moves := 0
var pairs_found := 0
var total_pairs := TEAM_IMAGES.size()
var busy := false

func _ready() -> void:
	randomize()
	restart_button.pressed.connect(start_game)
	play_again_button.pressed.connect(start_game)
	start_game()

func start_game() -> void:
	for c in grid.get_children():
		c.queue_free()
	first_card = null
	second_card = null
	moves = 0
	pairs_found = 0
	busy = false
	win_panel.visible = false
	_update_labels()

	var ids: Array[int] = []
	for i in range(TEAM_IMAGES.size()):
		ids.append(i)
		ids.append(i)
	ids.shuffle()

	for id in ids:
		var card: Card = CardScene.instantiate()
		grid.add_child(card)
		card.setup(id, TEAM_IMAGES[id], BACK_IMAGE)
		card.card_revealed.connect(_on_card_revealed)

func _on_card_revealed(card: Card) -> void:
	if busy:
		return
	if first_card == null:
		first_card = card
		return

	second_card = card
	busy = true
	moves += 1
	_update_labels()

	if first_card.team_id == second_card.team_id:
		first_card.set_matched()
		second_card.set_matched()
		pairs_found += 1
		_update_labels()
		first_card = null
		second_card = null
		busy = false
		if pairs_found >= total_pairs:
			_show_win()
	else:
		var fc := first_card
		var sc := second_card
		await get_tree().create_timer(0.7).timeout
		fc.flip_down()
		sc.flip_down()
		first_card = null
		second_card = null
		busy = false

func _update_labels() -> void:
	moves_label.text = "Movimientos: %d" % moves
	pairs_label.text = "Parejas: %d / %d" % [pairs_found, total_pairs]

func _show_win() -> void:
	win_label.text = "¡Felicidades! Ganaste en %d movimientos." % moves
	win_panel.visible = true
