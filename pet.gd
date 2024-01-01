extends Node2D

@onready var vup = $Vup

## if pet is ill, update node status
@onready var drag_plot_1 = $DragPlot1
@onready var drag_plot_2 = $DragPlot2 
@onready var touch_body_1 = $TouchBody1
@onready var touch_body_2 = $TouchBody2
@onready var touch_head_1 = $TouchHead1
@onready var touch_head_2 = $TouchHead2

var drag_plot_pos
var touch_body
var touch_head

func update_node():
    set_deferred("scale", Vector2(float(viewport_size.x)/1000, float(viewport_size.y)/1000))
    
    if vup.ill:
        touch_body_1.hide()
        touch_body_2.show()
        touch_head_1.hide()
        touch_head_2.show()
        touch_body = touch_body_2
        touch_head = touch_head_2
        drag_plot_pos = drag_plot_2.global_position * float(viewport_size.x)/1000
    else:
        touch_body_1.show()
        touch_body_2.hide()
        touch_head_1.show()
        touch_head_2.hide()
        touch_body = touch_body_1
        touch_head = touch_head_1
        drag_plot_pos = drag_plot_1.global_position * float(viewport_size.x)/1000
    pass


var viewport_size   :Vector2

func _ready():
    viewport_size = get_viewport_rect().size

    update_node()
    pass


## Read Dragging Event
@onready var mouse_move_timer = $MouseMoveTimer
var dragging = false
var mouse_pos   :Vector2
var window_pos  :Vector2

func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            dragging = true
            vup.set_raised(true)
        else:
            dragging = false
            vup.set_raised(false)
    
    if event is  InputEventMouseMotion and dragging:
        window_pos = get_tree().get_root().position
        mouse_pos = get_global_mouse_position()
        get_tree().get_root().position = Vector2(window_pos) + mouse_pos - drag_plot_pos
        vup.set_mouse_moving(true)
        mouse_move_timer.start()
    else:
        vup.set_mouse_moving(false)
    pass


func _on_mouse_move_timer_timeout():
    vup.set_mouse_moving(false)
    pass
    
    
## Read Touch Head Event
# when mouse moving horizontally, touch_head is true.
# when mouse moving vertically, touch_head is false.
# when mouse exited touch_head_area and not input in 0.2 seconds, touch_head is false too.
@onready var touch_head_timer = $TouchHeadTimer
var release = true
var touch_head_count = 0
var touch_head_last = -1

func _on_touch_head_input_event(_viewport, event, shape_idx):
    if event is InputEventMouseMotion and not dragging:
        if abs(event.velocity.x) > 10:
            if touch_head_last != -1 and shape_idx != touch_head_last:
                touch_head_count += 1
            else:
                touch_head_last = -1
            
            if touch_head_count > 2:
                touch_head_timer.start()
                vup.set_touch_head(true)
            
            touch_head_last = shape_idx
    pass
    

func _on_touch_head_mouse_stop_or_exit():   
    vup.set_touch_head(false)
    touch_head_count = 0
    touch_head_last = -1
    pass


## Read Touch Body Event
func _on_touch_body_1_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.double_click:
        print('double click ', event)
    pass
