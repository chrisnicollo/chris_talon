# Note: The below noise to click code was based on
# https://github.com/tpensyl/knausj_talon/blob/3b3572a7/tpensyl/pop-click.py#L1
from talon import noise, ctrl

def left_click(active: bool):
    print("left click")
    ctrl.mouse_click(button=0, hold=16000)
    # Note: Can remove the hold command, and it will still work
    # The hold command is used in the original talon in mouse.py
    # ctrl.mouse_click(button=0, hold=16000)


#noise.register("hiss", on_pop)
# FIXME: Uncomment the next line to get left click without eye tracker
# noise.register("pop", left_click)