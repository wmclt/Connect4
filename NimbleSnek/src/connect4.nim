import grid, bot, player
from strutils import parseInt, isDigit

# forward declaration
proc accept_move(grid: var Grid, player_index: int, bot: Bot)
proc accept_human_move(grid: Grid): int

const 
    PLAYERS = [X, Y]
    PLAYER_INVOCS = ["You", "Bot"]

proc start() =
    var grid = new_grid()
    echo "\nWelcome to a new game of Connect 4\n"
    var bot = new_bot(Y)

    var id_index = 0
    while not grid.game_over():
        grid.print()
        accept_move(grid, id_index, bot)
        id_index = (id_index+1) mod 2 
        # TODO: check if someone has won
        
proc accept_move(grid: var Grid, player_index: int, bot: Bot) =
    var column: int
    if bool(player_index):
        column = bot.choose_move(grid)
    else:
        column = accept_human_move(grid)
    echo PLAYER_INVOCS[player_index] & " played column: " & $(column+1)
    grid.add_pawn(column, PLAYERS[player_index])

proc accept_human_move(grid: Grid): int =
    echo "Choose a move:"

    var input = stdin.readLine()
    while not(input.isDigit() and 0 < parseInt(input) and parseInt(input) <= 7):
        echo "Please choose a correct move [1..7]"
        input = stdin.readLine()
    return parseInt(input) - 1

start()