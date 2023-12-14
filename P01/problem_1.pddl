(define (problem unstack_simple) (:domain dominio)
(:objects
b1 b2 - box
cr - crane
p1 p2 - pallet
d - dock
h0 h1 h2 h3 - height
)

(:init
(at p1 d)
(at p2 d)
(at b1 d)
(at b2 d)
(at cr d)
(on b1 p1)
(on b2 b1)
(clear b2)
(clear p2)
(clear cr)
(next h0 h1)
(next h1 h2)
(next h2 h3)
(max_dock_height h3 d)
(box_height h0 p1)
(box_height h0 p2)
(box_height h1 b1)
(box_height h2 b2)
(ready b2 d)
(isgreen b1)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(on b1 b2)
))

)
