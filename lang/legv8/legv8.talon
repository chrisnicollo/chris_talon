tag: user.legv8
-
tag(): user.code_imperative
# NOTE: THE COMMENT TAG IS ACTUALLY IMPORTANT
tag(): user.code_comment_line 
tag(): user.code_comment_block_c_like
tag(): user.code_data_bool
tag(): user.code_data_null
tag(): user.code_functions
tag(): user.code_functions_common
tag(): user.code_libraries
tag(): user.code_libraries_gui
tag(): user.code_operators_array
tag(): user.code_operators_assignment
tag(): user.code_operators_bitwise
tag(): user.code_operators_math
# tag(): user.code_operators_pointer


settings():
    # chrisnicollo EDIT START
    # user.code_private_function_formatter = "SNAKE_CASE"
    # user.code_protected_function_formatter = "SNAKE_CASE"
    # user.code_public_function_formatter = "SNAKE_CASE"
    user.code_private_function_formatter = "PUBLIC_CAMEL_CASE"
    user.code_protected_function_formatter = "PUBLIC_CAMEL_CASE"
    user.code_public_function_formatter = "PUBLIC_CAMEL_CASE"
    # chrisnicollo EDIT END
    user.code_private_variable_formatter = "SNAKE_CASE"
    user.code_protected_variable_formatter = "SNAKE_CASE"
    user.code_public_variable_formatter = "SNAKE_CASE"
    # whether or not to use uint_8 style datatypes
    #    user.use_stdint_datatypes = 1


#control flow
#best used with a push like command
#the below example may not work in editors that automatically add the closing bracket
#if so uncomment the two lines and comment out the rest accordingly
push brackets:
    edit.line_end()
    #insert("{")
    #key(enter)
    insert("{}")
    edit.left()
    key(enter)
    key(enter)
    edit.up()

# Declare variables or structs etc.
# Ex. * int myList
<user.c_variable> <phrase>:
    insert("{c_variable} ")
    insert(user.formatted_text(phrase, "PRIVATE_CAMEL_CASE,NO_SPACES"))

<user.c_variable> <user.letter>:
    insert("{c_variable} {letter} ")

# Ex. (int *)
cast to <user.c_cast>: "{c_cast}"
standard cast to <user.stdint_cast>: "{stdint_cast}"
<user.c_types>: "{c_types}"
<user.c_pointers>: "{c_pointers}"
<user.c_keywords>: "{c_keywords}"
<user.c_signed>: "{c_signed}"
standard <user.stdint_types>: "{stdint_types}"
int main:
    user.insert_between("int main(", ")")

toggle includes: user.code_toggle_libraries()
include <user.code_libraries>:
    user.code_insert_library(code_libraries, "")
    key(end enter)


# Actual legv8 commands

label <user.text>: "_{text}"

label <user.formatters> <user.text>:
    text = user.formatted_text(text, formatters)
    "_{text}"
# FIXME: Are these actually called labels?

op <user.legv8_operators>: 
    text = user.formatted_text("{legv8_operators}", "ALL_CAPS")
    "{text} "

op low <user.legv8_operators>: 
    text = user.formatted_text("{legv8_operators}", "ALL_LOWERCASE")
    "{text} "

op <user.formatters> <user.legv8_operators>:
    text = user.formatted_text("{legv8_operators}", formatters)
    "{text} "

reg [<user.formatters>] <user.number_string>:
    formatter = formatters or "ALL_CAPS"
    letter = user.formatted_text("r", formatter)
    "{letter}{number_string}"
    
# mead: "#"
<user.legv8_number_types>: "{legv8_number_types}"

    # result = user.homophones_select(number_small)
    # insert(user.formatted_text(result, formatters))
    # user.homophones_hide()

# <user.formatters> <user.draft_anchor> (through | past) <user.draft_anchor>:
#     user.draft_select(draft_anchor_1, draft_anchor_2, 1)
#     user.formatters_reformat_selection(user.formatters)