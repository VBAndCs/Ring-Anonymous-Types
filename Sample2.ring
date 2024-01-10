load "dynobj.ring"

y = defobj([
   :a = defobj([
      :b = 1
   ])
])
? y.a.b
