code.language: c
-
tag(): user.code_imperative

tag(): user.code_comment_line
tag(): user.code_comment_block_c_like
tag(): user.code_data_bool
tag(): user.code_data_null
tag(): user.code_functions
tag(): user.code_functions_common
tag(): user.code_libraries
tag(): user.code_operators_array
tag(): user.code_operators_assignment
tag(): user.code_operators_bitwise
tag(): user.code_operators_math
tag(): user.code_operators_pointer

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

# NOTE: migrated from generic, as they were only used here, though once cpp support is added, perhaps these should be migrated to a tag together with the commands below
state include: insert("#include ")
state include system: user.insert_between("#include <", ">")
state include local: user.insert_between('#include "', '"')
state type deaf: insert("typedef ")
state type deaf struct: user.insert_snippet_by_name("typedefStructDeclaration")

# XXX - create a preprocessor tag for these, as they will match cpp, etc
state define: "#define "
state (undefine | undeaf): "#undef "
state if (define | deaf): "#ifdef "
[state] define <user.text>$:
    "#define {user.formatted_text(text, 'ALL_CAPS,SNAKE_CASE')}"
[state] (undefine | undeaf) <user.text>$:
    "#undef {user.formatted_text(text, 'ALL_CAPS,SNAKE_CASE')}"
[state] if (define | deaf) <user.text>$:
    "#ifdef {user.formatted_text(text, 'ALL_CAPS,SNAKE_CASE')}"

# XXX - preprocessor instead of pre?
state pre if: "#if "
state error: "#error "
state pre else if: "#elif "
state pre end: "#endif "
state pragma: "#pragma "
state default: "default:\nbreak;"

#control flow
#best used with a push like command
#the below example may not work in editors that automatically add the closing brace
#if so uncomment the two lines and comment out the rest accordingly
push braces:
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

# chrisnicollo EDIT START
<user.c_variable> <user.letter>: insert("{c_variable} {letter}")

# Note that you can use phrase rather than user.text (but phrase doesn't allow you to use custom vocabulary)

class <user.text>:
    className = user.formatted_text(text, "PUBLIC_CAMEL_CASE,NO_SPACES")
    insert("class {className}")
    
<user.c_variable> funky <user.text>:
    functionName = user.formatted_text(text, "PUBLIC_CAMEL_CASE")
    insert("{c_variable} {functionName}()")
    edit.left()

static <user.c_variable> funky <user.text>:
    functionName = user.formatted_text(text, "PUBLIC_CAMEL_CASE")
    insert("static {c_variable} {functionName}()")
    edit.left()   

<self.c_pointers>+ <user.text>:
    insert("{c_pointers}")
    insert(user.formatted_text(text, "PRIVATE_CAMEL_CASE,NO_SPACES"))

# [state] new <user.c_variable> [<user.text>]: "new {c_variable} {user.formatted_text(text or '', 'camel')}"
[state] new <user.c_variable>: "new {c_variable}"

state new: "new "

scope standard:    
    insert("std::")

# FIXME: consider making a list of common scopes 

scope [{user.formatters}] <user.text>:
    insert("{user.formatted_text(text, formatters or 'PUBLIC_CAMEL_CASE')}::")
    
constant: "const "
see out: "cout"
see in: "cin"
op insertion: " << "
op extraction: " >> "
end line: "endl"
sempush: ";\n"
# chrisnicollo EDIT END

# Ex. (int *)
cast to <user.c_cast>: "{c_cast}"
standard cast to <user.stdint_cast>: "{stdint_cast}"
<user.c_types>: "{c_types}"
<user.c_pointers>: "{c_pointers}"
<user.c_keywords>: "{c_keywords}"
<user.c_signed>: "{c_signed} "
standard <user.stdint_types>: "{stdint_types}"
int main: user.insert_between("int main(", ")")

include <user.code_libraries>:
    user.code_insert_library(code_libraries, "")
    key(end enter)
