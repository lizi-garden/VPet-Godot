extends Node2D

@onready var animation_tree = $AnimationTree

@export_group("parameters")
@export_subgroup("status")
@export var happy           = true
@export var ill             = false
@export var normal          = false
@export var poor_condition  = false


@export_subgroup("other")
@export var drink       = false
@export var gift        = false
@export var idle        = false
@export var move        = false
@export var music       = false
@export var pinch       = false
@export var say         = false
@export var sleep       = false
@export var state       = false
@export var switch      = false
@export var think       = false
@export var work        = false
@export var shutdown    = false


func _process(_delta):
    # set status
    set_happy(happy)
    set_ill(ill)
    set_normal(normal)
    set_poor_condition(poor_condition)
    pass
    

@export_subgroup("touch_body")
@export var touch_body      = false
@export var touch_body_turn = false
func set_touch_body(value):
    touch_body = value
    animation_tree["parameters/conditions/is_touch_body"]                               = value
    animation_tree["parameters/touch_body/happy/conditions/is_not_turn"]                = value
    animation_tree["parameters/touch_body/happy/not_turn/conditions/is_not_touch_body"] = !value
    animation_tree["parameters/touch_body/ill/conditions/is_not_touch_body"]            = !value
    pass

func set_touch_body_turn(value):
    touch_body_turn = value
    animation_tree["parameters/conditions/is_touch_body"]                       = value
    animation_tree["parameters/touch_body/happy/turn/conditions/is_not_turn"]   = !value
    animation_tree["parameters/touch_body/happy/conditions/is_not_turn"]        = !value
    animation_tree["parameters/touch_body/happy/conditions/is_turn"]            = value
    pass


@export_subgroup("raised")
@export var raised          = false
@export var mouse_moving    = false
func set_raised(value):
    raised = value
    animation_tree["parameters/conditions/is_rasied"]                           = value
    animation_tree["parameters/rasied/happy/conditions/is_released"]            = !value
    animation_tree["parameters/rasied/ill/conditions/is_released"]              = !value
    animation_tree["parameters/rasied/normal/conditions/is_released"]           = !value
    animation_tree["parameters/rasied/poorcondition/conditions/is_released"]    = !value
    pass
    
func set_mouse_moving(value):
    mouse_moving = value
    animation_tree["parameters/rasied/happy/conditions/is_mouse_moving"]        = value
    animation_tree["parameters/rasied/happy/conditions/is_mouse_stop"]          = !value
    animation_tree["parameters/rasied/ill/conditions/is_mouse_moving"]          = value
    animation_tree["parameters/rasied/ill/conditions/is_mouse_stop"]            = !value
    animation_tree["parameters/rasied/normal/conditions/is_mouse_moving"]       = value
    animation_tree["parameters/rasied/normal/conditions/is_mouse_stop"]         = !value
    animation_tree["parameters/rasied/poorcondition/conditions/is_mouse_moving"]= value
    animation_tree["parameters/rasied/poorcondition/conditions/is_mouse_stop"]  = !value
    pass


@export_subgroup("touch_head")
@export var touch_head  = false
func set_touch_head(value):
    touch_head = value
    animation_tree["parameters/conditions/is_touch_head"] = value
    animation_tree["parameters/touch_head/conditions/is_not_touch_head"] = !value
    pass
    

func set_happy(value):
    happy = value
    animation_tree["parameters/start_up/conditions/is_happy"]   = value
    animation_tree["parameters/default/conditions/is_happy"]    = value
    animation_tree["parameters/rasied/conditions/is_happy"]     = value
    animation_tree["parameters/touch_body/conditions/is_happy"] = value
    animation_tree["parameters/touch_head/conditions/is_happy"] = value
    pass


func set_ill(value):
    ill = value
    animation_tree["parameters/start_up/conditions/is_ill"]     = value
    animation_tree["parameters/default/conditions/is_ill"]      = value
    animation_tree["parameters/rasied/conditions/is_ill"]       = value
    animation_tree["parameters/touch_body/conditions/is_ill"]   = value
    animation_tree["parameters/touch_head/conditions/is_ill"]   = value
    pass


func set_normal(value):
    normal = value
    animation_tree["parameters/start_up/conditions/normal"]     = value
    animation_tree["parameters/default/conditions/normal"]      = value
    animation_tree["parameters/rasied/conditions/normal"]       = value
    animation_tree["parameters/touch_head/conditions/normal"]   = value
    pass


func set_poor_condition(value):
    poor_condition = value
    animation_tree["parameters/start_up/conditions/is_poorcondition"]   = value
    animation_tree["parameters/rasied/conditions/is_poorcondition"]     = value
    animation_tree["parameters/default/conditions/is_poorcondition"]    = value
    pass


func _on_animation_started(anim_name):
    match anim_name:
        var value when value.contains("_C"):
            animation_tree.update_default_event()
        var value when value.contains("normal_raised_s_A"):
            animation_tree.update_raised_event()
        var value when value.contains("happy_touch_body_A1") or value.contains("happy_touch_body_Turn_A1"):
            animation_tree.update_touch_body_event()
    pass
