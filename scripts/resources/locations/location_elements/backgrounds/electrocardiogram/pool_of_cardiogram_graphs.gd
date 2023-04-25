class_name PoolOfCardiogramGraphs
extends Resource


@export var pool_of_cardiogram_graphs: Array[PackedVector2Array]


func get_random_graph() -> PackedVector2Array:
	return pool_of_cardiogram_graphs.pick_random()
