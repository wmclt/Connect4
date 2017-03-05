from Grid import ColumnGrid
from Robots.FirstOrderRobot import FirstOrderRobot

def play(firstNotSecond):
    grid = ColumnGrid()
    robot = FirstOrderRobot('X')

    import socket

    # create a socket object
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # get local machine name
    host = socket.gethostname()

    if firstNotSecond:
        port = 9998
        # bind to the port
        s.bind((host, port))
        # queue up to 5 requests
        s.listen(1)
        s = s.accept()

        s.send(str.encode("CHOSEN FIRST MOVE"))
    else:
        port = 9999
        s.connect((host,port))

    while not grid.game_over():

        opponent_move = int(s.recv(1024)) # even 8 (or even 1) should be enough!

        grid.add_pawn(opponent_move, 'O')

        if grid.game_over():
            break

        robot_move = str(robot.choose_move(grid))
        s.send(robot_move.encode('ascii'))
        break

    s.close()

play(True)