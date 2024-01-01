extends Node2D

@onready var animation_tree = $AnimationTree
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var happy           = false
@export var ill             = false
@export var normal          = true
@export var poor_condition  = false


@export var drink       = false
@export var gift        = false
@export var idle        = false
@export var move        = false
@export var music       = false
@export var pinch       = false
@export var raised      = false
@export var say         = false
@export var sleep       = false
@export var state       = false
@export var switch      = false
@export var think       = false
@export var touch_body  = false
@export var touch_head  = false
@export var work        = false
@export var shutdown    = false


func _process(_delta):
    # set status
    set_happy(happy)
    set_ill(ill)
    set_normal(normal)
    set_poor_condition(poor_condition)
    pass


func set_raised(value):
    raised = value
    animation_tree["parameters/conditions/is_rasied"]                           = value
    animation_tree["parameters/rasied/happy/conditions/is_released"]            = !value
    animation_tree["parameters/rasied/ill/conditions/is_released"]              = !value
    animation_tree["parameters/rasied/normal/conditions/is_released"]           = !value
    animation_tree["parameters/rasied/poorcondition/conditions/is_released"]    = !value
    pass


func set_touch_head(value):
    touch_head = value
    animation_tree["parameters/conditions/is_touch_head"] = value
    pass
    

func set_happy(value):
    happy = value
    animation_tree["parameters/start_up/conditions/is_happy"]   = value
    animation_tree["parameters/default/conditions/is_happy"]    = value
    animation_tree["parameters/rasied/conditions/is_happy"]     = value
    animation_tree["parameters/touch_head/conditions/is_happy"] = value
    pass


func set_ill(value):
    ill = value
    animation_tree["parameters/start_up/conditions/is_ill"]     = value
    animation_tree["parameters/default/conditions/is_ill"]      = value
    animation_tree["parameters/rasied/conditions/is_ill"]       = value
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


func _on_animation_finished(anim_name):
    match anim_name:
        var value when value.contains("touch_head"):
            set_touch_head(false)
            animation_tree.update_touch_head_event()
    pass
