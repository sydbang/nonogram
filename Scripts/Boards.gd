extends Node2D

var boardTileMap : TileMap
var boardSize : Vector2 = Vector2(10, 10)
# Called when the node enters the scene tree for the first time.
func _ready():
	boardTileMap = $BoardTileMap
	generate_board()

func generate_board():
	for x in range(int(boardSize.x)):
		for y in range(int(boardSize.y)):
			boardTileMap.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0), 0)

