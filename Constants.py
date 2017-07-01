from enum import Enum

# Constant utility class
class ColorModel(Enum):
    gray = "gray"
    blue = "blue"
    green = "green"
    red = "red"
    H = "H"
    S = "S"
    V = "V"
    L = "L"
    A = "A"
    B = "B"
    O1 = "O1"
    O2 = "O2"
    O3 = "O3"
    RGB = "RGB"
    HSV = "HSV"
    LAB = "LAB"
    Opponent = "Opponent"

    def get(self,color):
        if (color == "gray"): return (self.gray)
        if (color == "blue"): return (self.blue)
        if (color == "green"): return (self.green)
        if (color == "red"): return (self.red)
        if (color == "H"): return (self.H)
        if (color == "S"): return (self.S)
        if (color == "V"): return (self.V)
        if (color == "L"): return (self.L)
        if (color == "A"): return (self.A)
        if (color == "B"): return (self.B)
        if (color == "O1"): return (self.O1)
        if (color == "O2"): return (self.O2)
        if (color == "O3"): return (self.O3)
        if (color == "RGB"): return (self.RGB)
        if (color == "HSV"): return (self.HSV)
        if (color == "LAB"): return (self.LAB)
        if (color == "Opponent"): return (self.Opponent)

class WeightType(Enum):

     NONE = 'NONE'
     GAUSS = 'GAUSSIAN'
     LAP = 'LAPLACIAN'

     def get(self, wt):
         if (wt == "NONE"): return (self.NONE)
         if (wt == "GAUSSIAN"): return (self.GAUSS)
         if (wt == "LAPLACIAN"): return (self.LAP)