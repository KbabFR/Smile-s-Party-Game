extends Node2D

@export var score_text: RichTextLabel
@export var scoreboard_text: RichTextLabel

var score_value: int = 0

var scoreboard: Dictionary
var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_plus_one_button_down():
	score_value += 1
	scoretext_update()


func scoretext_update():
	score_text.text = "".num_int64(score_value)


func _on_game_over_button_down():
	game_over()


func game_over():
	record_score()
	


func record_score():
	if scoreboard.has(index):
		if scoreboard.get(index) < score_value:
			scoreboard[index] = score_value
	else:
		scoreboard[index] = score_value
	index += 1
	score_value = 0
	scoretext_update()
	scoreboardtext_update()

func scoreboardtext_update():
	var text = []
	if scoreboard.size() > 1:
		var scores = scoreboard.values()
		scores.sort_custom(func(a, b): return a > b)
		if scores.size() > 10: scores.resize(10)
		var penta = scoreboard.duplicate()
		for score in scores:
			text.append("{0}\t{1}".format(["".num_int64(penta.find_key(score)), "".num_int64(score)]))
			penta.erase(penta.find_key(score))
		scoreboard_text.text = "\n".join(text)
	else:
		scoreboard_text.text = "{0}\t{1}".format(["".num_int64(scoreboard.keys()[0]), "".num_int64(scoreboard.values()[0])])
