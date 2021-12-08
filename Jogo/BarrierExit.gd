extends TileMap

func _ready():
	visible = true

func _on_Bruxinha_next_level():
	queue_free()
