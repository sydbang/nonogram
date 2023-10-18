extends Node2D

var CaseSize = 34

var boardTileMap : TileMap
var labelRows: Control
var labelCols: Control
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
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 1, 1, 0, 0, 1, 1, 0, 1],
	[0, 1, 1, 0, 0, 0, 1, 0, 0, 0],
	[1, 0, 0, 1, 1, 0, 1, 1, 1, 1],
	[0, 0, 1, 1, 0, 0, 1, 1, 0, 0]
]
	
func _ready():
	boardTileMap = $BoardTileMap
	labelCols = $LabelCols
	labelRows = $LabelRows
	generate_board()
	

func generate_board():
	for x in range(int(boardSize.x)):
		for y in range(int(boardSize.y)):
			boardTileMap.set_cell(0, Vector2i(x, y), map[y][x], Vector2i(0, 0), 0)
	
	setBoardPosition()
	
	getRowData()
	getColData()
	
	printRowData()
	printColData()
	centerBoard()
	
func setBoardPosition():
	var rect = boardTileMap.get_used_rect()
	var position = boardTileMap.position
	var center = get_viewport().get_visible_rect().size / 2
	var endpoint = Vector2(rect.end)
	position = center - ((endpoint / 2) * (CaseSize))
	boardTileMap.position = position 
	
func centerBoard():
	var hSize = 0
	var vSize = 0
	var rect = boardTileMap.get_used_rect().size 

	for child in $LabelRows.get_children():
		var childRectSize = child.size
		if childRectSize.x > hSize:
			hSize = childRectSize.x
			
	hSize = (hSize * 2) + (rect.x * 2 * CaseSize)
	print(hSize)
	for child in $LabelCols.get_children():
		var childRectSize = child.size
		if childRectSize.y > vSize:
			vSize = childRectSize.y

	vSize = (vSize * 2) + (rect.y*2*CaseSize)
	print(vSize)
	
func printRowData():
	for y in range(int(boardSize.y)):
		var printText = ""
		var l = labelInstance.instantiate()
		for chain in HValues[y]:
			printText += str(chain) + " "
		if printText.length() == 0 :
			printText = "0 "
		l.text = printText
		var lRectMinPosition = l.position
		lRectMinPosition.y = (y - 1) * CaseSize
		l.position.y = lRectMinPosition.y
		labelRows.add_child(l)
	labelRows.position.x = boardTileMap.position.x - 30
	labelRows.position.y = boardTileMap.position.y

func printColData():
	for x in range(int(boardSize.x)):
		var printText = ""
		var l = labelInstance.instantiate()
		for chain in VValues[x]:
			printText += str(chain) + "\n"
		if printText.length() == 0 :
			printText = "0\n"
		l.text = printText
		var lRectPosition = l.position
		lRectPosition.x = (x - 1) * CaseSize
		l.position = lRectPosition
		labelCols.add_child(l)
	labelCols.position.x = boardTileMap.position.x
	labelCols.position.y = boardTileMap.position.y - 40

	
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
		
	#print("Hvalues, ", HValues)
	
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
	#print("Vvalues, ", VValues)
