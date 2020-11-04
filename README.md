# Ring Anonymous Types

I asked myself: Ring is a dynamic language, so, why don't I create a dynamic objects of anonymous types? So, I did it and it was fun :).
Here is how:
Call the `defObj` to define an object with anonymous type. This methods receives a list parameter, containing the names of the properties and their values. You can also use lambda functions as values, to add methods to the object. For example, this code will create a grey color object:
```ring
grey = defObj([
	:R = 128,
	:G = 128, 
	:B = 128, 
	:ToString = func(){
		 return "(" + R + ", " + G + ", " + B + ")"
	}
])
```

You can use this object like this:
```ring
? grey.R                          #128
? "grey = " + grey.ToString()     #grey = (128, 128, 128)
```

Now, what if you want to create a similar object for red? do you have to redefine the same object with the same properties (but with different values) and the same print function?
No. Here comes the function new NewObj, that returns a new instance of the object where all its properties values are nulls, so, you can set them as you want:
```ring
Red = newObj(grey) {r=255 G=0 B=0}
? Red.ToString()                  #(255, 0, 0)
```

If fact, you can make a little enhancement, by defining a color object which properties don't have values, and use it for creating all colors you want:
```ring
Color = defObj([
	:R,
	:G, 
	:B, 
	:ToString = func(){
		return "(" + R + ", " + G + ", " + B + ")"
	}
])
```

So, let's use this color object, to define a Colors object, that contains some colors and a Print method to print then all:
```ring
Colors = defObj([ 
      :Red = NewObj(Color){R = 255 G = 0 B = 0},
      :Green = NewObj(Color){R = 0 G = 255 B = 0},
      :Blue = NewObj(Color){R = 0 G = 0 B = 255},
      :Black = NewObj(Color){R = 0 G = 0 B = 0},
      :White = NewObj(Color){R = 255 G = 255 B = 255},
      :Print = func() {
          For C in Attributes(self)
             ? C + " = " + GetAttribute(Self, C).ToString()
          Next
      }
    ]) 
```

you can use the Colors object like this:
```ring
w = Colors.White
? "white.R = " + w.R
```

Note:
There are is an issue in Ring that will give an error if you try to use:
`? "white.R = " + Colors.White.R`
I hope it will be fixed soon.

You can print all the colors info like this:
```ring
? colors.Print()
```

# Warining:
You can't nest `defObj` directly, because there is a bug in Ring regarding calling methods with list param inside another listt. This will not work:
```ring
y = defobj([
   :a = defobj([
      :b = 1
   ])
])
```

But this will work:
```ring
x = defobj([:b = 1])
y = defobj([:a = x])
```

# Hope:
I hope ring can someday provide a direct syntax to declare anonymous types, such as:
```ring
Color = {
   R 
   G 
   B 
   ToString = func(){
		return "(" + R + ", " + G + ", " + B + ")"
   }
}

Colors = { 
      Red = new Color{R = 255 G = 0 B = 0}
      Green = new Color{R = 0 G = 255 B = 0}
      Blue = new Color{R = 0 G = 0 B = 255}
      Black = new Color{R = 0 G = 0 B = 0}
      White = new Color{R = 255 G = 255 B = 255}
      func Print() {
          For C in Attributes(self)
             ? C + " = " + GetAttribute(Self, C).ToString()
          Next
      }
    } 
```
