(define (problem three_docks) (:domain port_optic)
(:objects
b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 - box
cr cr2 cr3- crane
p1 p2 p3 p4 p5 p6 - pallet
d1 d2 d3 - dock
c12 c21 c23 c32- conveyor
h0 h1 h2 h3 - height
)

(:init
;donde estan las cajas
(at b1 d1)
(at b2 d1)
(at b3 d2)
(at b4 d2)
(at b5 d2)
(at b6 d2)
(at b7 d1)
(at b8 d2)
(at b9 d1)
(at b10 d1)
;alturas
(next h0 h1)
(next h1 h2)
(next h2 h3)
;max_height docks
(is_not_max_height h0 d1)
(is_not_max_height h1 d1)
(is_not_max_height h0 d2)
(is_not_max_height h1 d2)
;pallets
(box_height h0 p1)
(box_height h0 p2)
(box_height h0 p3)
(box_height h0 p4)
(box_height h0 p5)
(box_height h0 p6)
;cajas
(box_height h1 b1)
(box_height h1 b2)
(box_height h2 b3)
(box_height h1 b4)
(box_height h1 b5)
(box_height h1 b6)
(box_height h2 b7)
(box_height h2 b8)
(box_height h1 b9)
(box_height h2 b10)
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
(clear b9)
(clear b8)
(clear b6)
(clear b3)
;crane clear
(clear cr)
(clear cr2)
;cintas clear
(clear c)
(clear c2)
;cómo apilo las cajas
(on b7 b1)
(on b1 p1)
(on b9 p2)
(on b10 b2)
(on b2 p3)
(on b8 b4)
(on b4 p4)
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
(ready b9 d1)
(ready b10 d1)
(ready b8 d2)
(ready b3 d2)
(ready b6 d2)
;boxes
(iswhite b1)
(isgreen b2)
(isgreen b3)
(isgreen b4)
(iswhite b5)
(isgreen b6)
(isgreen b7)
(iswhite b8)
(iswhite b9)
(iswhite b10)
)

(:goal (and
(ready b7 d1)
(ready b4 d1)
(ready b3 d1)
(ready b2 d1)
(ready b6 d1)
))

)
