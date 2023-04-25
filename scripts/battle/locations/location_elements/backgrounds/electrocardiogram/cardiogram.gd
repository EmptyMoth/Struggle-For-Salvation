extends Node2D


@export var pool_of_graphs: PoolOfCardiogramGraphs = null

var WAITING_TIME_FOR_NEXT_GRAPH: float = 5


func _ready() -> void:
	while is_instance_valid(self):
		for cardiogram_graph in get_children():
			if not cardiogram_graph is CardiogramGraph:
				continue
			var random_graph: PackedVector2Array = pool_of_graphs.get_random_graph()
			cardiogram_graph.play_animation_of_drawing_graph(random_graph)
			await cardiogram_graph.graph_has_been_drawn
			await get_tree().create_timer(WAITING_TIME_FOR_NEXT_GRAPH, false).timeout
