app: notepad
-

tag(): user.tabs
tag(): user.find_and_replace
# chrisnicollo EDIT START: add windows 11 notepad dictation fix
settings():
    # Always paste to insert since the new notepad is slow
    user.paste_to_insert_threshold = 0
# chrisnicollo EDIT END