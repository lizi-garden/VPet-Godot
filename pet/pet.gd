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
    
    # Touch Body Timer
    touch_body_timer_l2r.connect("timeout", func(): touch_body_l2r = false)
    touch_body_timer_r2l.connect("timeout", func(): touch_body_r2l = false)
    touch_body_timer_u2d.connect("timeout", func(): touch_body_u2d = false)
    touch_body_timer_u2d.connect("timeout", func(): touch_body_d2u = false)

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
            Input.set_default_cursor_shape(Input.CURSOR_DRAG)
            vup.set_raised(true)
        else:
            dragging = false
            Input.set_default_cursor_shape(Input.CURSOR_ARROW)
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
# When mouse moving horizontally, set touch_head true.
# When mouse moving vertically, set touch_head false.
# When mouse exited touch_head_area and not input in 0.2 seconds, set touch_head false too.
@onready var touch_head_timer = $TouchHeadTimer
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
                Input.set_default_cursor_shape(Input.CURSOR_MOVE)
                vup.set_touch_head(true)
            
            touch_head_last = shape_idx
    pass
    

func _on_touch_head_mouse_stop_or_exit():   
    Input.set_default_cursor_shape(Input.CURSOR_ARROW)
    vup.set_touch_head(false)
    touch_head_count = 0
    touch_head_last = -1
    pass


## Read Touch Body Event
@onready var touch_body_timer = $TouchBodyTimer/Timer
@onready var touch_body_timer_l2r = $TouchBodyTimer/L2R
@onready var touch_body_timer_r2l = $TouchBodyTimer/R2L
@onready var touch_body_timer_u2d = $TouchBodyTimer/U2D
@onready var touch_body_timer_d2u = $TouchBodyTimer/D2U

# Touch Body
var touch_body_count = 0
var touch_body_last = -1

# Touch Body Turn
var touch_body_turn_count = 0
var touch_body_turn_last = -1

# Velocity Direction
var touch_body_l2r = false:
    set(value):
        touch_body_l2r = value
        touch_body_timer_l2r.start()

var touch_body_r2l = false:
    set(value):
        touch_body_r2l = value
        touch_body_timer_r2l.start()

var touch_body_u2d = false:
    set(value):
        touch_body_u2d = value
        touch_body_timer_u2d.start()

var touch_body_d2u = false:
    set(value):
        touch_body_d2u = value
        touch_body_timer_d2u.start()
        
func _on_touch_body_input_event(_viewport, event, shape_idx):
    if event is InputEventMouseMotion:
        if event.velocity.x > 50:   touch_body_l2r = true
        if event.velocity.x < -50:  touch_body_r2l = true
        if event.velocity.y > 50:   touch_body_u2d = true
        if event.velocity.y < -50:  touch_body_d2u = true
    
    if touch_body_l2r and touch_body_r2l and touch_body_u2d and touch_body_d2u:
        if touch_body_turn_last != -1 and shape_idx != touch_body_turn_last:
            touch_body_turn_count += 1
        else:
            touch_body_turn_last = -1
            
        if touch_body_turn_count > 4:
            touch_body_timer.start()
            Input.set_default_cursor_shape(Input.CURSOR_MOVE)
            vup.set_touch_body_turn(true)
        
        touch_body_turn_last = shape_idx
        pass
    elif touch_body_l2r or touch_body_r2l or touch_body_u2d or touch_body_d2u:
        if touch_body_last != -1 and shape_idx != touch_body_last:
            touch_body_count += 1
        else:
            touch_body_last = -1
            
        if touch_body_count > 4:
            touch_body_timer.start()
            Input.set_default_cursor_shape(Input.CURSOR_MOVE)
            vup.set_touch_body(true)
        
        touch_body_last = shape_idx
        pass
    
    pass


func _on_touch_body_mouse_stop_or_exit():
    Input.set_default_cursor_shape(Input.CURSOR_ARROW)
    
    # Touch Body
    vup.set_touch_body(false)
    touch_body_count = 0
    touch_body_last = -1
    
    # Touch Body Turn
    vup.set_touch_body_turn(false)
    touch_body_turn_count = 0
    touch_body_turn_last = -1
    pass


## Read Shutdown Event
func shutdown():
    vup.set_shutdown(true)
    pass
