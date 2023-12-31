extends Node2D

@onready var vup = $Vup
@onready var drag_plot = $DragPlot1
@onready var touch_body_1 = $TouchBody1
@onready var touch_body_2 = $TouchBody2
@onready var touch_head_1 = $TouchHead1
@onready var touch_head_2 = $TouchHead2


var viewport_width
var viewport_height


func _ready():
    vup.width = ProjectSettings.get_setting("display/window/size/viewport_width")
    vup.height = ProjectSettings.get_setting("display/window/size/viewport_height")
    vup.update_sprite()
    
    viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
    viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")
    
    update_event_node()
    pass


func update_node():
    touch_body_1.scale = Vector2(viewport_width/1000, viewport_height/1000)
    touch_body_2.scale = Vector2(viewport_width/1000, viewport_height/1000)
    touch_body_1.position = Vector2(viewport_width/2, viewport_height*3/4)
    touch_head_1.position = Vector2(viewport_width/2, viewport_height/4)


func update_event_node():
    if vup.ill:
        touch_body_1.hide()
        touch_body_2.show()
        touch_head_1.hide()
        touch_head_2.show()
        drag_plot = $DragPlot2
    else:
        touch_body_1.show()
        touch_body_2.hide()
        touch_head_1.show()
        touch_head_2.hide()
        drag_plot = $DragPlot2
    pass


## Read Touch Head Event
var touch_head_count = 0
var touch_head_dff1 = -1

func _on_touch_head_1_mouse_shape_entered(shape_idx):
    if vup.touch_head:
        return
    
    if shape_idx == touch_head_dff1:
        touch_head_count = 0
        touch_head_dff1 = -1
    
    if touch_head_count < 3:
        touch_head_count += 1
        touch_head_dff1 = shape_idx
    else:
        touch_head_count = 0
        touch_head_dff1 = -1
        vup.touch_head = true
    pass


## Read Touch Body Event
func _on_touch_body_1_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.double_click:
        print('double click ', event)
    pass

