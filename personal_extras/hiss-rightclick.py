from talon import Module, actions, noise, cron, scope
from talon_plugins import eye_mouse

# Note: The below noise to click code was based on 
# https://github.com/tpensyl/knausj_talon/blob/3b3572a7/tpensyl/pop-click.py#L1
from talon import noise, ctrl

def right_click(active: bool):
    print("right click")
    ctrl.mouse_click(button=1, hold=16000)

# Note: The below hiss to drag code comes from https://github.com/AndrewDant/andrew_talon/blob/main/hiss_drag.py
# FIXME: get hiss handler to work to both click and drag
min_hiss_time = "150ms"
ongoing_hiss = False

mod = Module()

@mod.action_class
class UserActions:
    def noise_hiss_start():
        """Invoked when the user starts hissing (potentially while speaking)"""
        print("hiss start")
        global ongoing_hiss
        ongoing_hiss = True

        cron.after(min_hiss_time, validate_hiss)

    def noise_hiss_stop():
        """Invoked when the user finishes hissing (potentially while speaking)"""
        print("hiss stop")
        global ongoing_hiss
        ongoing_hiss = False

        actions.mouse_release(0)


def validate_hiss():
    if ongoing_hiss:
        actions.mouse_drag(0)


def hiss_handler(active):
    sleep_mode = "sleep" in scope.get("mode")
    # aegis says this api will definitely change!
    active_eyetracker = eye_mouse.mouse.attached_tracker is not None

    #if active_eyetracker and not sleep_mode:
    if True:
        if active:
            #right_click(active)
            actions.user.noise_hiss_start()
        else:
            actions.user.noise_hiss_stop()


# register the handler to the noise
# FIXME: Uncomment the next line to get right click without eye tracker
# noise.register("hiss", right_click)

# register the handler to the noise
#noise.register("hiss", right_click)


'''
# Old version for just a single click
from talon import noise, ctrl

def right_click(active: bool):
    ctrl.mouse_click(button=0)


#noise.register("hiss", on_pop)
#noise.register("hiss", right_click)
'''
