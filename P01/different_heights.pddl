(define (problem different_heights) (:domain port_optic)
(:objects
b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 - box
cr cr2 - crane
p1 p2 p3 p4 p5 p6 - pallet
d1 d2 - dock
c c2 - conveyor
h0 h1 h2 h3 h4 - height
)

(:init
;donde estan las cajas
(at b1 d1)
(at b2 d1)
(at b3 d1)
(at b4 d1)
(at b5 d1)
(at b6 d2)
(at b7 d2)
(at b8 d2)
(at b9 d2)
(at b10 d2)
(at b11 d2)
(at b12 d2)
(at b13 d2)
;alturas
(next h0 h1)
(next h1 h2)
(next h2 h3)
(next h3 h4)
;max_height docks
(is_not_max_height h0 d1)
(is_not_max_height h1 d1)
(is_not_max_height h0 d2)
(is_not_max_height h1 d2)
(is_not_max_height h2 d2)
(is_not_max_height h3 d2)
;pallets
(box_height h0 p1)
(box_height h0 p2)
(box_height h0 p3)
(box_height h0 p4)
(box_height h0 p5)
(box_height h0 p6)
;cajas
(box_height h1 b1)
(box_height h2 b2)
(box_height h1 b3)
(box_height h1 b4)
(box_height h2 b5)
(box_height h1 b6)
(box_height h2 b7)
(box_height h3 b8)
(box_height h1 b9)
(box_height h2 b10)
(box_height h3 b11)
(box_height h1 b12)
(box_height h2 b13)
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
(clear b2)
(clear b3)
(clear b5)
(clear b8)
(clear b11)
(clear b13)
;crane clear
(clear cr)
(clear cr2)
;cintas clear
(clear c)
(clear c2)
;cómo apilo las cajas
;pallet1
(on b2 b1)
(on b1 p1)
;pallet2
(on b3 p2)
;pallet3
(on b5 b4)
(on b4 p3)
;pallet4
(on b8 b7)
(on b7 b6)
(on b6 p4)
;pallet5
(on b11 b10)
(on b10 b9)
(on b9 p5)
;pallet6
(on b13 b12)
(on b12 p6)
;origin de las cintas
(origin c d1)
(destiny c d2)
(origin c2 d2)
(destiny c2 d1)
;ready de las cajas
(ready b2 d1)
(ready b3 d1)
(ready b5 d1)
(ready b8 d2)
(ready b12 d2)
(ready b15 d2)
;boxes
(isgreen b1)
(iswhite b2)
(iswhite b3)
(isgreen b4)
(iswhite b5)
(isgreen b6)
(iswhite b7)
(iswhite b8)
(iswhite b9)
(isgreen b10)
(iswhite b11)
(iswhite b12)
(iswhite b13)
)

(:goal (and
(ready b1 d1)
(ready b4 d1)
(ready b6 d1)
(ready b10 d1)
))

)
