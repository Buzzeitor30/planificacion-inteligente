(define (problem prueba_de_fuego_1) 
(:domain port)
(:objects
box1 box2 dock1 pallet1 pallet2 crane - box
n0 n1 n2 - height
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (movable box1)
    (movable box2)
    (top box1)
    (top box2)
    (top crane)
    (at crane crane)
    (at pallet1 dock1)
    (at pallet2 dock1)
    (at box1 dock1)
    (at box2 dock1)
    (on box1 pallet1)
    (on box2 pallet2)
    (next n0 n1)
    (next n1 n2)
    (link crane dock1)
    (link dock1 crane)
    (max_height crane n1)
    (max_height dock1 n2)
    (height pallet1 n0)
    (height pallet2 n0)
    (height crane n0)
    (height box1 n1)
    (height box2 n1)
)

(:goal (and
    (on box1 box2)
))

)
