extends Node2D

@onready var vup = $Vup

## If pet is ill, update node status
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
    var viewport_size = get_viewport_rect().size
    set_deferred("scale", Vector2(float(viewport_size.x)/500, float(viewport_size.y)/500))
    
    if vup.current_action == vup.Mood.ILL:
        touch_body_1.hide()
        touch_body_2.show()
        touch_head_1.hide()
        touch_head_2.show()
        touch_body = touch_body_2
        touch_head = touch_head_2
        drag_plot_pos = drag_plot_2.global_position * float(viewport_size.x)/500
    else:
        touch_body_1.show()
        touch_body_2.hide()
        touch_head_1.show()
        touch_head_2.hide()
        touch_body = touch_body_1
        touch_head = touch_head_1
        drag_plot_pos = drag_plot_1.global_position * float(viewport_size.x)/500


func _ready():
    update_node()


func _unhandled_input(event):
    idle_unhandled_input(event)
    raised_unhandled_input(event)


## Read Idle Event
@onready var idle_handler_delay_timer = $HandlerDelayTimer/Idle

func idle_unhandled_input(_event):
    idle_handler_delay_timer.start()
    if vup.current_action == vup.Action.IDLE:
        vup.idle(false)


# Handler Delay Idle
func _on_handler_delay_idle_timeout():
    vup.idle(true)


## Read Raised Event
@onready var raised_handler_delay_timer = $HandlerDelayTimer/Raised
@onready var raised_unhandler_timer = $UnhandledTimer/Raised

var dragging = false
            
var mouse_pos   :Vector2
var window_pos  :Vector2

func raised_unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            if raised_handler_delay_timer.time_left == 0 and not dragging:
                raised_handler_delay_timer.start()
            
        else:
            raised_unhandler_timer.start()
            if dragging:
                dragging = false
                Input.set_default_cursor_shape(Input.CURSOR_ARROW)
                vup.raised_stop(false)

    
    if event is InputEventMouseMotion and dragging:
            window_pos = get_tree().get_root().position
            mouse_pos = get_global_mouse_position()
            get_tree().get_root().position = Vector2(window_pos) + mouse_pos - drag_plot_pos
            raised_unhandler_timer.start()
            vup.raised_moving()


# Handler Delay Raised
func _on_handler_delay_raised_timeout():
    dragging = true
    Input.set_default_cursor_shape(Input.CURSOR_DRAG)
    
    window_pos = get_tree().get_root().position
    mouse_pos = get_global_mouse_position()
    get_tree().get_root().position = Vector2(window_pos) + mouse_pos - drag_plot_pos
    raised_unhandler_timer.start()
    vup.raised_moving()


# Unhandled Raised
func _on_unhandled_raised_timeout():
    if dragging:
        vup.raised_stop(true)
    else:
        raised_handler_delay_timer.stop()
        raised_handler_delay_timer.wait_time = 1.0


## Read Touch Head Event
@onready var touch_head_unhandler_timer = $UnhandledTimer/TouchHead

var touch_head_count = 0
var touch_head_last = -1

func _on_touch_head_input_event(_viewport, event, shape_idx):
    if event is InputEventMouseMotion and not dragging:
        if abs(event.velocity.x) > 10:
            if touch_head_last != -1 and shape_idx != touch_head_last:
                touch_head_unhandler_timer.start()
                touch_head_count += 1
                

            if touch_head_count > 2:
                touch_head_unhandler_timer.start()
                Input.set_default_cursor_shape(Input.CURSOR_MOVE)
                vup.touch_head(true)
            
            touch_head_last = shape_idx


# Unhandled Touch Head Event
func _on_unhandled_touch_head_timeout():
    touch_head_count = 0
    touch_head_last = -1
    
    if vup.current_action == vup.Action.TOUCHHEAD:
        vup.touch_head(false)
        Input.set_default_cursor_shape(Input.CURSOR_ARROW)


## Read Touch Body Event
@onready var touch_body_unhandler_timer = $UnhandledTimer/TouchBody

var touch_body_count = 0
var touch_body_last = -1

func _on_touch_body_input_event(shape_idx):
    if touch_body_last != -1 and shape_idx != touch_body_last:
        touch_body_count += 1
        touch_body_unhandler_timer.start()
            
    if touch_body_count > 4:
        touch_body_unhandler_timer.start()
        Input.set_default_cursor_shape(Input.CURSOR_MOVE)
        vup.touch_body(true)
            
    touch_body_last = shape_idx


# Unhandled Touch Body Event
func _on_unhandled_touch_body_timeout():
    touch_body_count = 0
    touch_body_last = -1
    
    if vup.current_action == vup.Action.TOUCHBODY:
        vup.touch_body(false)
        Input.set_default_cursor_shape(Input.CURSOR_ARROW)


## Read Happy Turn Event
@onready var happy_turn_unhandler_timer = $UnhandledTimer/HappyTurn

var happy_turn_count = 0
var happy_turn_sum = 0
var happy_turn_last = -1

func _on_happy_turn_input_event(shape_idx):
    if happy_turn_last != -1 and shape_idx != happy_turn_last:
        happy_turn_unhandler_timer.start()
        happy_turn_count += 1
        happy_turn_sum += shape_idx
            
    if happy_turn_count > 4:
        # 6 = 0 + 1 + 2 + 3, sum of 4 shape_idx
        if happy_turn_sum == 6:
            happy_turn_unhandler_timer.start()
            Input.set_default_cursor_shape(Input.CURSOR_MOVE)
            vup.happy_turn(true)
        else:
            happy_turn_sum = 0
    
    happy_turn_last = shape_idx


# Unhandled Happy Turn Event
func _on_unhandled_happy_turn_timeout():
    happy_turn_count = 0
    happy_turn_sum = 0
    happy_turn_last = -1
    
    if vup.current_action == vup.Action.HAPPYTURN:
        vup.happy_turn(false)
        Input.set_default_cursor_shape(Input.CURSOR_ARROW)

