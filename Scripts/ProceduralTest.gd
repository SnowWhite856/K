extends Node3D

@export var RoomSize : Vector2

var wall : PackedScene = preload("res://Scene/wall.tscn")
var floor : PackedScene = preload("res://Scene/floor.tscn")
@export var to : Node3D

var wallSize : Vector3
var floorSize : Vector3

func _ready() -> void:
	CreateWalls()
	CreateFloor()

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		DeleteChildren()
		CreateWalls()
		CreateFloor()

func DeleteChildren() -> void:
	for child in to.get_children():
		child.queue_free()

func CreateFloor() -> void:
	var floorX1 = floor.instantiate()
	floorSize = floorX1.get_node("Floor").mesh.get_aabb().size
	
	var floorCountX = max(1, int(RoomSize.x / floorSize.x))
	var floorScaleX = (RoomSize.x / floorCountX) / floorSize.x
	
	var floorCountY = max(1, int(RoomSize.y / floorSize.x))
	var floorScaleY = (RoomSize.y / floorCountY) / floorSize.x
	
	for i in floorCountX:
		for j in floorCountY:
			floorX1 = floor.instantiate()
			floorX1.position = position + Vector3(-RoomSize.x / 2 + floorSize.x * floorScaleX / 2 + i * floorScaleX * floorSize.x, -wallSize.z / 2, -RoomSize.y / 2 + floorSize.x * floorScaleY / 2 + j * floorScaleY * floorSize.x)
			floorX1.scale = Vector3(floorScaleX, 1, floorScaleY)
			to.add_child(floorX1)

func CreateWalls() -> void:
	var wallX1 = wall.instantiate()
	wallSize = wallX1.get_node("Wall").mesh.get_aabb().size
	
	var wallCount = max(1, int(RoomSize.x / wallSize.x))
	var sscale = (RoomSize.x / wallCount) / wallSize.x
	#wall x
	for i in wallCount:
		wallX1 = wall.instantiate()
		wallX1.rotation = Vector3(0, deg_to_rad(90), 0)
		wallX1.position = position + Vector3(-RoomSize.x / 2 + wallSize.x * sscale / 2 + i * sscale * wallSize.x, 0, -RoomSize.y / 2)
		wallX1.scale = Vector3(sscale, 1, 1)
		to.add_child(wallX1)
	
	for i in wallCount:
		wallX1 = wall.instantiate()
		wallX1.rotation = Vector3(0, deg_to_rad(90), 0)
		wallX1.position = position + Vector3(-RoomSize.x / 2 + wallSize.x * sscale / 2 + i * sscale * wallSize.x, 0, +RoomSize.y / 2)
		wallX1.scale = Vector3(sscale, 1, 1)
		to.add_child(wallX1)
	
	wallCount = max(1, int(RoomSize.y / wallSize.x))
	sscale = (RoomSize.y / wallCount) / wallSize.x
	
	#wall y
	for i in wallCount:
		wallX1 = wall.instantiate()
		wallX1.position = position + Vector3(-RoomSize.x / 2, 0, -RoomSize.y / 2 + wallSize.x * sscale / 2 + i * sscale * wallSize.x)
		wallX1.scale = Vector3(sscale, 1, 1)
		to.add_child(wallX1)
		
	for i in wallCount:
		wallX1 = wall.instantiate()
		wallX1.position = position + Vector3(+RoomSize.x / 2, 0, -RoomSize.y / 2 + wallSize.x * sscale / 2 + i * sscale * wallSize.x)
		wallX1.scale = Vector3(sscale, 1, 1)
		to.add_child(wallX1)
