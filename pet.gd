extends Node2D

@onready var vup = $Vup


## if pet is ill, update node status
@onready var drag_plot_1 = $DragPlot1
@onready var drag_plot_2 = $DragPlot2 
@onready var touch_body_1 = $TouchBody1
@onready var touch_body_2 = $TouchBody2
@onready var touch_head_1 = $TouchHead1
@onready var touch_head_2 = $TouchHead2

var drag_plot
var touch_body
var touch_head

func update_node():
    scale = Vector2(float(viewport_size.x)/1000, float(viewport_size.y)/1000)
    
    if vup.ill:
        touch_body_1.hide()
        touch_body_2.show()
        touch_head_1.hide()
        touch_head_2.show()
        touch_body = touch_body_2
        touch_head = touch_head_2
        drag_plot = drag_plot_2
    else:
        touch_body_1.show()
        touch_body_2.hide()
        touch_head_1.show()
        touch_head_2.hide()
        touch_body = touch_body_1
        touch_head = touch_head_1
        drag_plot = drag_plot_1
    pass


var viewport_size :Vector2
var screen_size   :Vector2

func _ready():
    viewport_size = get_viewport_rect().size
    screen_size = DisplayServer.screen_get_size()

    update_node()
    pass


## Read Dragging Event
var dragging = false

func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            dragging = true


## Read Touch Head Event
var touch_head_count = 0
var touch_head_dff1 = -1

func _on_touch_head_mouse_shape_entered(shape_idx):
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
        vup.set_touch_head(true)
    pass


## Read Touch Body Event
func _on_touch_body_1_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.double_click:
        print('double click ', event)
    pass

