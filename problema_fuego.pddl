(define (problem problema_fuego) (:domain port)
(:objects
b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 - box
cr cr2 - crane
p1 p2 p3 p4 p5 p6 - box
d1 d2 - dock
c c2 - conveyor
h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 - height
)

(:init
;donde estan las cajas
(at_box b1 d1)
(at_box b2 d1)
(at_box b3 d2)
(at_box b4 d2)
(at_box b5 d2)
(at_box b6 d2)
(at_box b7 d1)
(at_box b8 d2)
(at_box b9 d1)
(at_box b10 d1)
;alturas
(next h0 h1)
(next h1 h2)
(next h2 h3)
(next h3 h4)
(next h4 h5)
(next h5 h6)
(next h6 h7)
(next h7 h8)
(next h8 h9)
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
(at_box p1 d1)
(at_box p2 d1)
(at_box p3 d1)
(at_box p4 d2)
(at_box p5 d2)
(at_box p6 d2)
;donde estan los crane
(at_crane cr d1)
(at_crane cr2 d2)
;que cajas estan clear
(clear b7)
(clear b10)
(clear b9)
(clear b8)
(clear b6)
(clear b3)
;crane clear
(empty_crane cr)
(empty_crane cr2)
;cintas clear
(empty_conveyor c)
(empty_conveyor c2)
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
