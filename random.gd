extends AnimationTree

func _ready():
    randomize()
    update_event()
    pass


func update_event():
    update_default_event()
    update_touch_head_event()
    update_raised_event()
    pass


func update_raised_event():
    var normal_event = get_event_2()
    match normal_event:
        "event1":
            self["parameters/rasied/normal/conditions/normal_raised_d_1"] = true
            self["parameters/rasied/normal/conditions/normal_raised_d_2"] = false
        "event2":
            self["parameters/rasied/normal/conditions/normal_raised_d_1"] = false
            self["parameters/rasied/normal/conditions/normal_raised_d_2"] = true
    pass


func update_touch_head_event():
    var happy_event = get_event_3()
    match happy_event:
        "event1":
            self["parameters/touch_head/normal/conditions/normal_touch_head_A"] = true
            self["parameters/touch_head/normal/conditions/normal_touch_head_B"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_C"] = false
        "event2":
            self["parameters/touch_head/normal/conditions/normal_touch_head_A"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_B"] = true
            self["parameters/touch_head/normal/conditions/normal_touch_head_C"] = false
        "event3":
            self["parameters/touch_head/normal/conditions/normal_touch_head_A"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_B"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_C"] = true
    
    
    var ill_event = get_event_3()
    match ill_event:
        "event1":
            self["parameters/touch_head/ill/conditions/ill_touch_head_A"] = true
            self["parameters/touch_head/ill/conditions/ill_touch_head_B"] = false
            self["parameters/touch_head/ill/conditions/ill_touch_head_C"] = false
        "event2":
            self["parameters/touch_head/ill/conditions/ill_touch_head_A"] = false
            self["parameters/touch_head/ill/conditions/ill_touch_head_B"] = true
            self["parameters/touch_head/ill/conditions/ill_touch_head_C"] = false
        "event3":
            self["parameters/touch_head/ill/conditions/ill_touch_head_A"] = false
            self["parameters/touch_head/ill/conditions/ill_touch_head_B"] = false
            self["parameters/touch_head/ill/conditions/ill_touch_head_C"] = true
        
    
    var normal_event = get_event_3()
    match normal_event:
        "event1":
            self["parameters/touch_head/normal/conditions/normal_touch_head_A"] = true
            self["parameters/touch_head/normal/conditions/normal_touch_head_B"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_C"] = false
        "event1":
            self["parameters/touch_head/normal/conditions/normal_touch_head_A"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_B"] = true
            self["parameters/touch_head/normal/conditions/normal_touch_head_C"] = false
        "event1":
            self["parameters/touch_head/normal/conditions/normal_touch_head_A"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_B"] = false
            self["parameters/touch_head/normal/conditions/normal_touch_head_C"] = true
    pass
            

func update_default_event():
    var happy_event = get_event_3()
    match happy_event:
        "event1":
            self["parameters/default/happy/conditions/happy_default_1"] = true
            self["parameters/default/happy/conditions/happy_default_2"] = false
            self["parameters/default/happy/conditions/happy_default_3"] = false
        "event2":
            self["parameters/default/happy/conditions/happy_default_1"] = false
            self["parameters/default/happy/conditions/happy_default_2"] = true
            self["parameters/default/happy/conditions/happy_default_3"] = false
        "event3":
            self["parameters/default/happy/conditions/happy_default_1"] = false
            self["parameters/default/happy/conditions/happy_default_2"] = false
            self["parameters/default/happy/conditions/happy_default_3"] = true
    
    
    var ill_event = get_event_2()
    match ill_event:
        "event1":
            self["parameters/default/ill/conditions/ill_default_1"] = true
            self["parameters/default/ill/conditions/ill_default_2"] = false
        "event2":
            self["parameters/default/ill/conditions/ill_default_1"] = false
            self["parameters/default/ill/conditions/ill_default_2"] = true
    
    
    var normal_event = get_event_2()
    #var normal_event = get_event_3()
    match normal_event:
        "event1":
            self["parameters/default/normal/conditions/normal_default_1"]   = true
            self["parameters/default/normal/conditions/normal_default_2"]   = false
            self["parameters/default/normal/conditions/normal_default_3"]   = false
        "event2":
            self["parameters/default/normal/conditions/normal_default_1"]   = false
            self["parameters/default/normal/conditions/normal_default_2"]   = true
            self["parameters/default/normal/conditions/normal_default_3"]   = false
        #"event3":
            #self["parameters/default/normal/conditions/normal_default_1"]   = false
            #self["parameters/default/normal/conditions/normal_default_2"]   = false
            #self["parameters/default/normal/conditions/normal_default_3"]   = true
    
    
    var poorcondition_event = get_event_2()
    match poorcondition_event:
        "event1":
            self["parameters/default/poorcondition/conditions/poorcondition_default_1"] = true
            self["parameters/default/poorcondition/conditions/poorcondition_default_2"] = false
        "event2":
            self["parameters/default/poorcondition/conditions/poorcondition_default_1"] = false
            self["parameters/default/poorcondition/conditions/poorcondition_default_2"] = true
    pass
    

# 获取2个随机事件中的一个
func get_event_2():
    var random_float = randf()
    if random_float < 0.5:      return "event1"
    else:                       return "event2"


# 获取3个随机事件中的一个
func get_event_3():
    var random_float = randf()
    if random_float < 0.34:     return "event1"
    elif random_float < 0.68:   return "event2"
    else:                       return "event3"
