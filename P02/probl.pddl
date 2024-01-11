(define (problem problema_fuego) (:domain port)
(:objects
b1 b2  - box
cr cr2 - crane
p1 p2 - box
d1 d2 - dock
c c2 - conveyor
h0 h1 h2  - height
)

(:init
;donde estan las cajas
(at_box b1 d1)
(at_box b2 d2)
;alturas
(next h0 h1)
(next h1 h2)
;max_height docks
(is_not_max_height h0 d1)
(is_not_max_height h1 d1)
(is_not_max_height h0 d2)
(is_not_max_height h1 d2)
;pallets
(box_height h0 p1)
(box_height h0 p2)
;cajas
(box_height h1 b1)
(box_height h1 b2)
;donde estan los pallets
(at_box p1 d1)
(at_box p2 d2)
;donde estan los crane
(at_crane cr d1)
(at_crane cr2 d2)
;que cajas estan clear
(clear b1)
(clear b2)
;crane clear
(empty_crane cr)
(empty_crane cr2)
;cintas clear
(empty_conveyor c)
(empty_conveyor c2)
;cómo apilo las cajas
(on b1 p1)
(on b2 p2)
;origin de las cintas
(origin c d1)
(destiny c d2)
(origin c2 d2)
(destiny c2 d1)
;ready de las cajas
(ready b1 d1)
(ready b2 d2)
;green boxes
(isgreen b2)
(isgreen b1)
)

(:goal (and
    (ready b1 d1)
    (ready b2 d1)
))
)
