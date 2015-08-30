import turtle

def drawsquare():

    window = turtle.Screen()
    window.bgcolor("red") 
    me = turtle.Turtle()
    me.forward(100)
    me.right(90)
    me.forward(100)
    me.right(90)
    me.forward(100)
    me.right(90)
    me.forward(100)
    me.right(90)
    window.exitonclick()
    

drawsquare()
