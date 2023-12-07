(define (problem unstack_simple) (:domain dominio)
(:objects
b1 b2 - box
cr cr2 - crane
p1 p2 - pallet
d1 d2 - dock
c - conveyor
)

(:init
(at p1 d1)
(at p2 d2)
(at b1 d1)
(at b2 d1)
(at cr d1)
(at cr2 d2)
(on b1 p1)
(on b2 b1)
(clear b2)
(clear p2)
(clear cr)
(clear cr2)
(clear c)
(origin c d1)
(destiny c d2)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(on b2 p2)
(on b1 b2)
))

)
