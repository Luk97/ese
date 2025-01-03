extends Label

var labelFontScaleX=30
var labelFontScaleY=15

func _ready() -> void:
	GameManager.round_updated.connect(set_round_count)

func set_round_count(rounds: int) -> void:
	text = str("Round: ", rounds)

func _process(delta: float) -> void:
	var thisLabelFontSize=min(get_window().size.x / labelFontScaleX, get_window().size.y / labelFontScaleY)
	add_theme_font_size_override("font_size",thisLabelFontSize)
