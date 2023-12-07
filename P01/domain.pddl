;Header and description

(define (domain dominio)

;remove requirements that are not needed
(:requirements :strips :fluents :typing :negative-preconditions :disjunctive-preconditions)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
box crane pallet dock conveyor - object
)

(:predicates ;todo: define predicates here
(clear ?b - (either box pallet crane conveyor))  ;there's nothing above the box the pallet or box, oor the crane is empty
(on ?b1 - box ?b2 - (either pallet crane box conveyor)) ;box b1 is either above other box, a pallet or a crane
(at ?b - (either box crane pallet) ?d - dock )
(origin ?c - conveyor ?d - dock)
(destiny ?c - conveyor ?d - dock)
(ready ?b - box ?d - dock)
)

(:action unstack
    :parameters (?b1 - box ?b2 - (either pallet box) ?c - crane ?d - dock)
    :precondition (and  (at ?b1 ?d) ;la caja está en un muelle
                        (at ?c ?d) ;la grúa esta en el mismo muelle
                        (clear ?b1) ;no hay nada sobre b1
                        (clear ?c) ;no hay nada en la grúa
                        (on ?b1 ?b2)) ;b1 encima de una caja o pallet
    :effect (and    (not (clear ?b1)) ;b1  deja de estar en una stack
                    (not (clear ?c)) ;la grúa  no está libre
                    (not (on ?b1 ?b2)) ;b1 deja de estar sobre b2
                    (on ?b1 ?c) ;b1 ahora está en la grúa
                    (clear ?b2) ;b2 ahora no tiene nada encimma
                    )
)

(:action stack
    :parameters ( ?b1 - box ?b2 - (either pallet box) ?c - crane ?d - dock)
    :precondition (and  (on ?b1 ?c) ;caja sujeta por la grua
                        (clear ?b2) ;nada encima de b2 
                        (at ?c ?d) ;crane  en el mismo dock que b2
                        (at ?b2 ?d) 
    )
    :effect (and    (not (on ?b1 ?c))
                    (not (clear ?b2))
                    (on ?b1 ?b2)
                    (clear ?c)
                    (clear ?b1)
                    )

    )

(:action load_conveyor
    :parameters (?b - box ?cr - crane ?c - conveyor ?d_og - dock ?d_dst - dock)
    :precondition (and  (on ?b ?cr) ;box is on a crane
                        (clear ?c) ;conveyor is clear
                        (origin ?c ?d_og) 
                        (destiny ?c ?d_dst)
                        (at ?cr ?d_og) ;crane is at dock origin
                        )
    :effect (and    (not (on ?b ?cr)) ;box not on crane
                    (clear ?cr) ;crane is clear
                    (not (clear ?c)) ;conveyor is not clear
                    (on ?b ?c) ;box is on conveyor 
                    (not (at ?b ?d_og))
                    (at ?b ?d_dst) ;box is now on dst dockc
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

