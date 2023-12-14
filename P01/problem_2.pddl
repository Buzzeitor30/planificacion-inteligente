(define (problem unstack_simple) (:domain dominio)
(:objects
b1 b2 b3 b4 b5 - box
cr cr2 - crane
p1 p2 p3 p4 - pallet
d1 d2 - dock
c c2 - conveyor
)

(:init
(at p1 d1)
(at p2 d1)
(at p3 d2)
(at p4 d2)
(at b1 d2)
(at b2 d2)
(at b3 d2)
(at b4 d1)
(at b5 d1)
(at cr d1)
(at cr2 d2)
(on b4 p1)
(on b5 b4)
(on b1 p3)
(on b3 p4)
(on b2 b3)
(clear b2)
(clear b1)
(clear b5)
(clear p2)
(clear cr)
(clear cr2)
(clear c)
(clear c2)
(origin c d1)
(destiny c d2)
(origin c2 d2)
(destiny c2 d1)
(isgreen b1)
(isgreen b3)
(isgreen b4)
(ready b5 d1)
(ready b2 d2)
(ready b1 d2)
(ready p2 d1)
(ready b1 d2)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(ready b4 d1)
(ready b1 d1)
(ready b3 d1)
))

)
