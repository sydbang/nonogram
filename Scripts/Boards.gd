extends Node2D

var boardTileMap : TileMap
var labelInstance: PackedScene = load("res://Scenes/LineLabel.tscn")

var boardSize : Vector2 = Vector2(10, 10)
var HValues: Array = []
var VValues: Array = []
var map: Array = [
	[0, 0, 1, 1, 0, 0, 1, 1, 0, 1],
	[0, 1, 1, 1, 0, 1, 1, 1, 0, 0],
	[1, 0, 1, 0, 1, 0, 1, 1, 0, 1],
	[0, 0, 1, 1, 0, 0, 1, 1, 1, 0],
	[1, 0, 0, 1, 1, 0, 1, 0, 0, 1],
	[0, 0, 1, 0, 1, 0, 1, 0, 0, 1],
	[0, 0, 1, 1, 0, 0, 1, 1, 0, 1],
	[0, 1, 1, 0, 0, 0, 1, 0, 0, 0],
	[1, 0, 0, 1, 1, 0, 1, 1, 1, 1],
	[0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
]
	
func _ready():
	boardTileMap = $BoardTileMap
	generate_board()
	

func generate_board():
	for x in range(int(boardSize.x)):
		for y in range(int(boardSize.y)):
			boardTileMap.set_cell(0, Vector2i(x, y), map[y][x], Vector2i(0, 0), 0)
	getRowData()
	getColData()
	
	printRowData()
	
func printRowData():
	for y in range(int(boardSize.y)):
		for chain in HValues[y]:
			print(chain)
	
func getRowData():
	var chain = 0
	for y in range(int(boardSize.y)):
		HValues.append([])
		for x in range(int(boardSize.x)):
			
			if boardTileMap.get_cell_source_id(0, Vector2i(x,y)) == 0:
				if chain > 0:
					HValues[y].append(chain)
						
					#print("y: ", y, " = ", chain)
					chain = 0
			else :
				chain += 1
		if chain > 0:
			HValues[y].append(chain)
			#print("y: ", y, " = ", chain)
			chain = 0
		
	print("Hvalues, ", HValues)
	
func getColData():
	var chain = 0
	for x in range(int(boardSize.x)):
		VValues.append([])
		for y in range(int(boardSize.y)):
			if boardTileMap.get_cell_source_id(0, Vector2i(x,y)) == 0:
				if chain > 0:
					VValues[x].append(chain)
					#print("x: ", x, " = ", chain)
					chain = 0
			else :
				chain += 1
		if chain > 0:
			VValues[x].append(chain)
			#print("x: ", x, " = ", chain)
			chain = 0
	print("Vvalues, ", VValues)
