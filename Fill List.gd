extends VBoxContainer
#class_name FillList

enum {TOEDGE, CUSTOMEXTENTS}
@export_enum("To Edge", "Custom Amount") var fill_extent: int = 0
@export var extents: float = 0

func _ready() -> void:
	for child in get_children():
		if child is HBoxContainer:
			match fill_extent:
				TOEDGE:
					align_children(child, rect_size.x)
				CUSTOMEXTENTS:
					align_children(child, extents)

# theres a faster way of doing this, and also not involving declaring size twice,
# but its so short that i dont really care

static func align_children(container: HBoxContainer, this_extent: float) -> void:
#	container.set_alignment(BoxContainer.ALIGN_BEGIN)
	var size: float = get_children_size(container.get_children())
	set_separation(container, calc_separation(size, this_extent))

static func get_children_size(children: Array) -> float:
	var size: float
	for child in children:
		size += (child as Control).rect_size.x
	return size

static func calc_separation(size: float, extents: float) -> int:
	return int(extents - size)

static func set_separation(container: BoxContainer, separation: int) -> void:
	container.add_theme_constant_override("separation", separation)
