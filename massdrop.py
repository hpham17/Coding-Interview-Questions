# MassDrop Interview Question:
# Given an integer print out asterisks up to that integer
# each separated by a newline
# for ex. n = 3 would output
# *
# **
# ***

# Use only recursion and no iteration involved for example you cannot print
# "*" two times there should only be one print("*") call

# Regular recursive way using iteration "trick"
# which was clarified that it is not allowed
def print_asterisk1(num):
    if (num == 0):
        return
    print_asterisk1(num-1)
    print("*" * num) # not allowed

# Modified recursive way with only one print("*") call.
def print_asterisk(start, how_much, end):
    if start == end:
        return
    if how_much == 0:
        print("\n")
        print_asterisk(start+1, start+2, end)
    else:
        print("*"),
        print_asterisk(start, how_much-1, end)

print_asterisk(0,1,3)
# => *
#    **
#    ***
