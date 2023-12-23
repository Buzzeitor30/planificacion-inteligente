;Header and description

(define (domain port_optic)

;remove requirements that are not needed
(:requirements :strips :fluents :typing)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
box crane pallet dock conveyor height - object
)

(:predicates ;todo: define predicates here
(clear ?b - (either box pallet crane conveyor))  ;there's nothing above the box the pallet or box, oor the crane is empty
(on ?b1 - box ?b2 - (either pallet crane box conveyor)) ;box b1 is either above other box, a pallet or a crane
(at ?b - (either box crane pallet) ?d - dock )
(origin ?c - conveyor ?d - dock)
(destiny ?c - conveyor ?d - dock)
(isgreen ?b - box)
(iswhite ?b - box)
(ready ?b - (either box pallet) ?d - dock)
(next ?h_prev - height ?h_next - height)
(box_height ?h - height ?b - (either box pallet))
(is_not_max_height ?h - height ?d - dock)
)

(:action unstack
    :parameters (?b1 - box ?b2 - (either pallet box) ?c - crane ?d - dock ?h - height)
    :precondition (and  (at ?b1 ?d) ;la caja está en un muelle
                        (at ?c ?d) ;la grúa esta en el mismo muelle
                        (clear ?b1) ;no hay nada sobre b1
                        (clear ?c) ;no hay nada en la grúa
                        (on ?b1 ?b2) ;b1 encima de una caja o pallet
                        (box_height ?h ?b1)
    )     
    :effect (and    (not (clear ?b1)) ;b1  deja de estar en una stack
                    (not (clear ?c)) ;la grúa  no está libre
                    (not (on ?b1 ?b2)) ;b1 deja de estar sobre b2
                    (not (ready ?b1 ?d)) ;la caja b1 deja de estar ready en el dock d
                    (not (box_height ?h ?b1))
                    (ready ?b2 ?d) ;la caja está ready
                    (on ?b1 ?c) ;b1 ahora está en la grúa
                    (clear ?b2) ;b2 ahora no tiene nada encima
                    )
)

(:action stack_g_o_a
    :parameters (?b1 - box ?b2 - (either box pallet) ?c - crane ?d - dock ?hb2 - height ?hnext - height)
    :precondition (and  (on ?b1 ?c) ;caja sujeta por la grua
                        (clear ?b2) ;nada encima de b2 
                        (at ?c ?d) ;crane  en el mismo dock que b2
                        (at ?b2 ?d)
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
    :effect (and    (not (on ?b1 ?c)) ;b1 no está en el crane ya
                    (not (clear ?b2)) ;b2 tiene cosas encima ahora
                    (on ?b1 ?b2) ;b1 encima de b2
                    (clear ?c) ;crane vacío
                    (clear ?b1) ;b1 no tiene nada encima
                    (ready ?b1 ?d)
                    (box_height ?hnext ?b1) ;b1 está ready (no borramos b2)
                    )
)


(:action stack_w_o_a
    :parameters (?b1 - box ?b2 - (either box pallet) ?c - crane ?d - dock ?hb2 - height ?hnext - height)
    :precondition (and  (on ?b1 ?c) ;caja sujeta por la grua
                        (clear ?b2) ;nada encima de b2 
                        (at ?c ?d) ;crane  en el mismo dock que b2
                        (at ?b2 ?d)
                        (iswhite ?b1)
                        ;(not (isgreen ?b1)) ;la caja de abajo no es verde, CAMBIAR OPTIC
                        (box_height ?hb2 ?b2)
                        (next ?hb2 ?hnext)
                        (is_not_max_height ?hb2 ?d)
    )
    :effect (and    (not (on ?b1 ?c)) ;b1 no está en el crane ya
                    (not (clear ?b2)) ;b2 tiene cosas encima ahora
                    (not (ready ?b2 ?d)) ;b2 deja de estar ready
                    (on ?b1 ?b2) ;b1 encima de b2
                    (clear ?c) ;crane vacío
                    (clear ?b1) ;b1 no tiene nada encima
                    (ready ?b1 ?d)
                    (box_height ?hnext ?b1) ;b1 está ready (no borramos b2)
                    )
)

(:action load_conveyor
    :parameters (?b - box ?cr - crane ?c - conveyor ?d_og - dock ?d_dst - dock)
    :precondition (and  (on ?b ?cr) ;box is on a crane
                        (clear ?c) ;conveyor is clear
                        (origin ?c ?d_og) ;conveyor starts at d_og
                        (destiny ?c ?d_dst) ;conveyor ends at d_dst
                        (at ?cr ?d_og) ;crane is at dock origin
                        )
    :effect (and    (not (on ?b ?cr)) ;box not on crane
                    (clear ?cr) ;crane is clear
                    (not (clear ?c)) ;conveyor is not clear
                    (on ?b ?c) ;box is on conveyor 
                    (not (at ?b ?d_og))
                    (at ?b ?d_dst) ;box is now on dst dock
    )
)

(:action unload_conveyor
    :parameters (?b - box ?c - conveyor ?cr - crane ?d - dock)
    :precondition (and  (on ?b ?c) ;caja en conveyor
                        (at ?b ?d) ;caja en el muelle
                        (at ?cr ?d) ;crane en el muelle
                        (clear ?cr) ;crane libre
    )
    :effect (and    (not (on ?b ?c))
                    (clear ?c)
                    (not (clear ?cr))
                    (on ?b ?cr)
    )
)
)