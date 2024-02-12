extends Node2D

@onready var setting = $InputSettings

var setting_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		if !setting_open:
			setting.visible = true
			setting_open = true
		else:
			setting.visible = false
			setting_open = false
