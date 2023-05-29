app: putty_terminal
-
# Set tags
tag(): terminal
# tag(): user.tabs
tag(): user.generic_unix_shell
# tag(): user.git
# tag(): user.kubectl
tag(): user.file_manager
tag(): user.anaconda
tag(): user.git

module load [<user.text>]: 
    insert("module load ")
    insert(user.text or "")
module spyder [<user.text>]: 
    insert("module spyder ")
    insert(user.text or "")