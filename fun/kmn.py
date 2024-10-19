from random import randint

#create a list of play options
t = ["k", "m", "n"]

#assign a random play to the computer
computer = t[randint(0,2)]

#set player to False
player = False

while player == False:
#set player to True
    player = input("k, m, n?")
    if player == computer:
        print("Tie!")
    elif player == "k":
        if computer == "m":
            print("Проиграл!")
        else:
            print("Выиграл!")
    elif player == "m":
        if computer == "n":
            print("Проиграл!")
        else:
            print("Выиграл!")
    elif player == "n":
        if computer == "k":
            print("Проиграл!")
        else:
            print("Выиграл!")
    else:
        print("Простите?")
    #player was set to True, but we want it to be False so the loop continues
    player = False
    computer = t[randint(0,2)]

