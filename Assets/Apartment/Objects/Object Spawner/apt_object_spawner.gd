extends Marker3D

var uid


func load_details(target: APTGrabObject):
	print(get_parent())
	transform = target.transform
	uid = load(target.UID)


func create():
	var obj = uid.instantiate()
	obj.transform = transform
	print(get_parent())
	get_parent().add_child(obj)
