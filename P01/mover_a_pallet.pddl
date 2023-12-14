(define (problem mover_pallets) (:domain dominio)
(:objects
b1 - box
cr cr2 - crane
p1 p2  - pallet
d1 d2 - dock
c c2 - conveyor
h0 h1 h2 h3 - height
)

(:init
;donde estan las cajas
(at b1 d1)
;alturas
(next h0 h1)
(next h1 h2)
(next h2 h3)
;max_height docks
(max_height h3 d1)
(max_height h3 d2)
;pallets
(box_height h0 p1)
(box_height h0 p2)
;cajas
(box_height h1 b1)
;donde estan los pallets
(at p1 d1)
(at p2 d2)
;donde estan los crane
(at cr d1)
(at cr2 d2)
;que cajas estan clear
(clear b1)
(clear p2)
;crane clear
(clear cr)
(clear cr2)
;cintas clear
(clear c)
(clear c2)
;cómo apilo las cajas
(on b1 p1)
;origin de las cintas
(origin c d1)
(destiny c d2)
(origin c2 d2)
(destiny c2 d1)
;ready de las cajas
(ready b1 d1)
;green boxes
(isgreen b1)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(ready b1 d2)
))

)
