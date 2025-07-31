extends Node3D

var vertices: Array = []
var edges: Array = []

var multimesh_instance: MultiMeshInstance3D
var wireframe_mesh_instance: MeshInstance3D

func _ready():
	# Example data, replace with your actual vertices and edges
	vertices = [
		Vector3(0, 0, 0),
		Vector3(1, 0, 0),
		Vector3(1, 1, 0),
		Vector3(0, 1, 0)
	]
	edges = [
		Vector2i(0, 1),
		Vector2i(1, 2),
		Vector2i(2, 3),
		Vector2i(3, 0),
		Vector2i(0, 2)
	]
	
	_create_wireframe_mesh()
	_create_vertex_spheres()

func GetSliceMesh():
	_create_wireframe_mesh()
	_create_vertex_spheres()
	
func _create_wireframe_mesh():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_LINES)
	
	var dark_blue = Color(0, 0, 0.5)
	
	for e in edges:
		if e.x >= 0 and e.y >= 0 and e.x < vertices.size() and e.y < vertices.size():
			st.set_color(dark_blue)
			st.add_vertex(vertices[e.x])
			st.set_color(dark_blue)
			st.add_vertex(vertices[e.y])
	
	var im = ImmediateMesh.new()
	im = st.commit(im)  # build ImmediateMesh from SurfaceTool
	
	if wireframe_mesh_instance:
		wireframe_mesh_instance.mesh = im
	else:
		wireframe_mesh_instance = MeshInstance3D.new()
		wireframe_mesh_instance.name = "Wireframe"
		wireframe_mesh_instance.mesh = im
		add_child(wireframe_mesh_instance)

func _create_vertex_spheres():
	if multimesh_instance:
		multimesh_instance.queue_free()

	multimesh_instance = MultiMeshInstance3D.new()
	multimesh_instance.name = "VertexSpheres"

	var multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.instance_count = vertices.size()

	var sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = 0.05
	sphere_mesh.height = 0.05
	sphere_mesh.radial_segments = 8
	sphere_mesh.rings = 6

	# Assign material directly to the mesh
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.5, 0, 0)  # Dark Red
	mat.metallic = 0
	mat.roughness = 0.5
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	sphere_mesh.material = mat

	multimesh.mesh = sphere_mesh
	multimesh_instance.multimesh = multimesh

	for i in range(vertices.size()):
		var xform = Transform3D.IDENTITY
		xform.origin = vertices[i]
		multimesh.set_instance_transform(i, xform)

	add_child(multimesh_instance)
