import Tkinter
from Tkinter import Canvas, Label, Tk, StringVar
import tkMessageBox

from random import choice
from collections import Counter

class Game():
    WIDTH = 300
    HEIGHT = 600

    def start(self):
        self.level = 1
        self.score = 0
        self.speed = 500
        self.counter = 0
        self.create_new_game = True

        self.root = Tk()
        self.root.title("Tetris")

        self.status_var = StringVar() 
        self.status_var.set("Level: 1, Score: 0")
        self.status = Label(self.root, 
                textvariable=self.status_var, 
                font=("Helvetica", 10, "bold"))
        self.status.pack()
        
        self.canvas = Canvas(
                self.root, 
                width=Game.WIDTH, 
                height=Game.HEIGHT)
        self.canvas.pack()

        self.root.bind("<Key>", self.handle_events)
        self.timer()
        self.root.mainloop()




    def timer(self):
        if self.create_new_game == True:
            self.current_shape = Shape(self.canvas)
            self.create_new_game = False

        if not self.current_shape.fall():
            lines = self.remove_complete_lines()
            if lines:
                self.score += 10 * self.level**2 * lines**2
                self.status_var.set("Level: %d, Score: %d" % 
                        (self.level, self.score))

            self.current_shape = Shape(self.canvas)
            if self.is_game_over(): 
                self.create_new_game = True
                self.game_over()

            self.counter += 1
            if self.counter == 5:
                self.level += 1
                self.speed -= 20
                self.counter = 0
                self.status_var.set("Level: %d, Score: %d" % 
                        (self.level, self.score))
        
        self.root.after(self.speed, self.timer)

    def handle_events(self, event):
        if event.keysym == "Left": self.current_shape.move(-1, 0)
        if event.keysym == "Right": self.current_shape.move(1, 0)



    def is_game_over(self):
        for box in self.current_shape.boxes:
            if not self.current_shape.can_move_box(box, 0, 1):
                return True
        return False

    def remove_complete_lines(self):
        shape_boxes_coords = [self.canvas.coords(box)[3] for box 
                in self.current_shape.boxes]
        all_boxes = self.canvas.find_all()
        all_boxes_coords = {k : v for k, v in 
                zip(all_boxes, [self.canvas.coords(box)[3] 
                    for box in all_boxes])}
        lines_to_check = set(shape_boxes_coords)
        boxes_to_check = dict((k, v) for k, v in all_boxes_coords.iteritems()
                if any(v == line for line in lines_to_check))
        counter = Counter()
        

    def game_over(self):
            self.canvas.delete(Tkinter.ALL)
            tkMessageBox.showinfo(
                    '''"Game Over", 
                    "You scored %d pointsimport Tkinter'''）


class Shape:
    BOX_SIZE = 20
    START_POINT = Game.WIDTH / 2 / BOX_SIZE * BOX_SIZE - BOX_SIZE
    SHAPES = (
            ("yellow", (0, 0), (1, 0), (0, 1), (1, 1)),     
            ("blue", (0, 0), (0, 1), (1, 1), (2, 1)),       
            ("green", (0, 1), (1, 1), (1, 0), (2, 0)),  
            ("red", (0, 0), (1, 0), (1, 1), (2, 1))        
            )

    def __init__(self, canvas):
        self.boxes = [] 
        self.shape = choice(Shape.SHAPES) 
        self.color = self.shape[0]
        self.canvas = canvas

        for point in self.shape[1:]:
            box = canvas.create_rectangle(
                point[0] * Shape.BOX_SIZE + Shape.START_POINT,
                point[1] * Shape.BOX_SIZE,
                point[0] * Shape.BOX_SIZE + Shape.BOX_SIZE + Shape.START_POINT,
                point[1] * Shape.BOX_SIZE + Shape.BOX_SIZE,
                fill=self.color)
            self.boxes.append(box)

           
    def move(self, x, y):
        if not self.can_move_shape(x, y): 
            return False         
        else:
            for box in self.boxes: 
                self.canvas.move(box, x * Shape.BOX_SIZE, y * Shape.BOX_SIZE)
            return True

    def fall(self):
        if not self.can_move_shape(0, 1):
            return False
        else:
            for box in self.boxes:
                self.canvas.move(box, 0 * Shape.BOX_SIZE, 1 * Shape.BOX_SIZE)
            return True

    def can_move_box(self, box, x, y):
        x = x * Shape.BOX_SIZE
        y = y * Shape.BOX_SIZE
        coords = self.canvas.coords(box)
        
        if coords[3] + y > Game.HEIGHT: return False
        if coords[0] + x < 0: return False
        if coords[2] + x > Game.WIDTH: return False

        overlap = set(self.canvas.find_overlapping(
                (coords[0] + coords[2]) / 2 + x, 
                (coords[1] + coords[3]) / 2 + y, 
                (coords[0] + coords[2]) / 2 + x,
                (coords[1] + coords[3]) / 2 + y
                ))
        other_items = set(self.canvas.find_all()) - set(self.boxes)
        if overlap & other_items: return False

        return True


    

if __name__ == "__main__":
    game = Game()
    game.start()
