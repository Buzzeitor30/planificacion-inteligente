(define (problem unstack_simple) (:domain dominio)
(:objects
b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 - box
cr cr2 - crane
p1 p2 p3 p4 p5 p6 - pallet
d1 d2 - dock
c c2 - conveyor
)

(:init
;donde estan las cajas
(at b1 d1)
(at b7 d1)
(at b10 d1)
(at b9 d1)
(at b11 d1)
(at b4 d2)
(at b8 d2)
(at b5 d2)
(at b3 d2)
(at b2 d2)
(at b6 d2)
;donde estan los pallets
(at p1 d1)
(at p2 d1)
(at p3 d1)
(at p4 d2)
(at p5 d2)
(at p6 d2)
;donde estan los crane
(at cr d1)
(at cr2 d2)
;que cajas estan clear
(clear b7)
(clear b10)
(clear b11)
(clear b8)
(clear b2)
(clear b6)
;crane clear
(clear cr)
(clear cr2)
;cintas clear
(clear c)
(clear c2)
;cómo apilo las cajas
(on b7 b1)
(on b1 p1)
(on b10 b9)
(on b9 p2)
(on b11 p3)
(on b8 b4)
(on b4 p4)
(on b2 b3)
(on b3 b5)
(on b5 p5)
(on b6 p6)
;origin de las cintas
(origin c d1)
(destiny c d2)
(origin c2 d2)
(destiny c2 d1)
;ready de las cajas
(ready b7 d1)
(ready b10 d1)
(ready b11 d1)
(ready b8 d2)
(ready b2 d2)
(ready b6 d2)
;green boxes
(isgreen b7)
(isgreen b4)
(isgreen b3)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(ready b7 d1)
(ready b4 d1)
(ready b3 d1)
))

)
