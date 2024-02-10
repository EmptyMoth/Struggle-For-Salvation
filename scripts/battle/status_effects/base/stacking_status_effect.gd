class_name StackingStatusEffect
extends AbstractStatusEffect


signal changed_stack_count(new_stack_count: int)

var stack_count: int :
	set(count):
		stack_count = count
		if stack_count <= 0:
			expired.emit(self)
			return
		changed_stack_count.emit(stack_count)


func _init(character: Character, count: int = 0) -> void:
	super(character)
	stack_count = count


func reduce() -> void:
	stack_count -= 1


func reduce_by(count: int) -> void:
	stack_count -= count


func add_stack_count(count: int) -> void:
	stack_count += count
