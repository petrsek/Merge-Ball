class_name ScoreLabel
extends Label
## Label with added functionality to count score

@export var score_mult_timer: Timer ## Handles expiration of score multiplier
var score: float = 0.0 ## The current score
@export var score_coef: float = 50.0 ## Coefficient by which the level is multiplied to get score gain
var score_mult: float = 1.0 ## Score multiplier for multiple merges in a row
@export var max_score_mult: float = 5.0 ## Limit amount for the [member ScoreLabel.score_mult]

func _ready() -> void:
	UpdateText()

## Updates the score shown to the current score
func UpdateText() -> void:
	text = "Score: %d" % score
	
## Handles addition of score
func _on_balls_merged(level: int) -> void:
	# level + 1 because of level 0
	score += float(level + 1) * score_coef * score_mult 
	score_mult_timer.start()
	score_mult = clampf(score_mult + 1, 1.0, 5.0)
	UpdateText()
	

## Resets multiplier
func _on_score_mult_timer_timeout() -> void:
	score_mult = 1.0
