 ;Header and description

(define (domain port)

;remove requirements that are not needed
(:requirements :strips :fluents :typing)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
;a pallet is a box
box crane dock conveyor height - object
)

(:predicates ;todo: define predicates here
;(clear ?b - (either box crane conveyor))  ;there's nothing above the box the pallet or box, oor the crane is empty
(clear ?b - box)
(empty_crane ?c - crane)
(empty_conveyor ?c - conveyor)
;(on ?b1 - box ?b2 - (either crane box conveyor)) ;box b1 is either above other box, a pallet or a crane
(on ?b1 - box ?b2 - box)
(holding ?b1 - box ?c - crane)
(carrying ?b1 - box ?co - conveyor)
;(at ?b - (either box crane) ?d - dock )
(at_box ?b - box ?d - dock)
(at_crane ?c - crane ?d - dock)
(origin ?c - conveyor ?d - dock)
(destiny ?c - conveyor ?d - dock)
(isgreen ?b - box)
(iswhite ?b - box)
(ready ?b -  box ?d - dock)
(next ?h_prev - height ?h_next - height)
(box_height ?h - height ?b - box)
(is_not_max_height ?h - height ?d - dock)
)

(:action unstack
    :parameters (?b1 - box ?b2 - box ?c - crane ?d - dock ?h - height)
    :precondition (and  (at_box ?b1 ?d) ;la caja está en un muelle
                        (at_crane ?c ?d) ;la grúa esta en el mismo muelle
                        (clear ?b1) ;no hay nada sobre b1
                        (empty_crane ?c) ;no hay nada en la grúa
                        (on ?b1 ?b2) ;b1 encima de una caja o pallet
                        (box_height ?h ?b1)
    )     
    :effect (and    (not (clear ?b1)) ;b1  deja de estar en una stack
                    (not (empty_crane ?c)) ;la grúa  no está libre
                    (not (on ?b1 ?b2)) ;b1 deja de estar sobre b2
                    (not (ready ?b1 ?d)) ;la caja b1 deja de estar ready en el dock d
                    (not (box_height ?h ?b1))
                    (ready ?b2 ?d) ;la caja está ready
                    (holding ?b1 ?c) ;b1 ahora está en la grúa
                    (clear ?b2) ;b2 ahora no tiene nada encima
                    )
)

(:action stack_g_o_a
    :parameters (?b1 - box ?b2 - box ?c - crane ?d - dock ?hb2 - height ?hnext - height)
    :precondition (and  (holding ?b1 ?c) ;caja sujeta por la grua
                        (clear ?b2) ;nada encima de b2 
                        (at_crane ?c ?d) ;crane  en el mismo dock que b2
                        (at_box ?b2 ?d)
                        (isgreen ?b1)
                        ;(or 
                        ;(isgreen ?b1)
                        ;(not (isgreen ?b2))
                        ;)
                        (box_height ?hb2 ?b2)
                        (next ?hb2 ?hnext)
                        (is_not_max_height ?hb2 ?d)
                        ;;(not (max_height ?hb2 ?d)) ;CAMBIAR OPTIC

    )
    :effect (and    (not (holding ?b1 ?c)) ;b1 no está en el crane ya
                    (not (clear ?b2)) ;b2 tiene cosas encima ahora
                    (on ?b1 ?b2) ;b1 encima de b2
                    (empty_crane ?c) ;crane vacío
                    (clear ?b1) ;b1 no tiene nada encima
                    (ready ?b1 ?d)
                    (box_height ?hnext ?b1) ;b1 está ready (no borramos b2)
                    )
)


(:action stack_w_o_a
    :parameters (?b1 - box ?b2 - box ?c - crane ?d - dock ?hb2 - height ?hnext - height)
    :precondition (and  (holding ?b1 ?c) ;caja sujeta por la grua
                        (clear ?b2) ;nada encima de b2 
                        (at_crane ?c ?d) ;crane  en el mismo dock que b2
                        (at_box ?b2 ?d)
                        (iswhite ?b1)
                        ;(not (isgreen ?b1)) ;la caja de abajo no es verde, CAMBIAR OPTIC
                        (box_height ?hb2 ?b2)
                        (next ?hb2 ?hnext)
                        (is_not_max_height ?hb2 ?d)
    )
    :effect (and    (not (holding ?b1 ?c)) ;b1 no está en el crane ya
                    (not (clear ?b2)) ;b2 tiene cosas encima ahora
                    (not (ready ?b2 ?d)) ;b2 deja de estar ready
                    (on ?b1 ?b2) ;b1 encima de b2
                    (empty_crane ?c) ;crane vacío
                    (clear ?b1) ;b1 no tiene nada encima
                    (ready ?b1 ?d)
                    (box_height ?hnext ?b1) ;b1 está ready (no borramos b2)
                    )
)

(:action load_conveyor
    :parameters (?b - box ?cr - crane ?c - conveyor ?d_og - dock ?d_dst - dock)
    :precondition (and  (holding ?b ?cr) ;box is on a crane
                        (empty_conveyor ?c) ;conveyor is clear
                        (origin ?c ?d_og) ;conveyor starts at d_og
                        (destiny ?c ?d_dst) ;conveyor ends at d_dst
                        (at_crane ?cr ?d_og) ;crane is at dock origin
                        )
    :effect (and    (not (holding ?b ?cr)) ;box not on crane
                    (empty_crane ?cr) ;crane is clear
                    (not (empty_conveyor ?c)) ;conveyor is not clear
                    (carrying ?b ?c) ;box is on conveyor 
                    (not (at_box ?b ?d_og))
                    (at_box ?b ?d_dst) ;box is now on dst dock
    )
)

(:action unload_conveyor
    :parameters (?b - box ?c - conveyor ?cr - crane ?d - dock)
    :precondition (and  (carrying ?b ?c) ;caja en conveyor
                        (at_box ?b ?d) ;caja en el muelle
                        (at_crane ?cr ?d) ;crane en el muelle
                        (empty_crane ?cr) ;crane libre
    )
    :effect (and    (not (carrying ?b ?c))
                    (empty_conveyor ?c)
                    (not (empty_crane ?cr))
                    (holding ?b ?cr)
    )
)
)