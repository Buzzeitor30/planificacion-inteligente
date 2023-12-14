(define (problem unstack_simple) (:domain dominio)
(:objects
b1 b2 - box
cr - crane
p1 p2 - pallet
d - dock
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
(ready b2 d)
(isgreen b1)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and

))

)
