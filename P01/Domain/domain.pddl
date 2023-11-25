;Header and description

(define (domain Port)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
box pallet locatable height - object
dock crane cinta - locatable
)

(:predicates ;todo: define predicates here
(link ?loc1 - locatable ?loc2 - locatable)
(top ?c - (either box pallet)) ;box is above the stack
(target ?c - box) ;box ?c is a target to deliver
(at ?c - box ?p - locatable) ;?c box is found at a locatable (either dock, crane or cinta)
(on ?c - box ?c2 - (either pallet box)) ;a box ?c is either above another box or a pallet
(ready ?c) ;box c is ready for delivery
)

(:action move
    :parameters (?c - box ?loc_org - locatable ?loc_dst - locatable  ?c1 - (either box pallet) ?c2 - (either box pallet))
    :precondition (and 
    (top ?c) ;box is on top
    (at ?c ?loc_org) ;box can be found at locatable org
    (on ?c ?c1) ;box can be found above another box or pallet
    (link ?loc_org ?loc_dst) ;a link can be found between the two locations
    (top ?c2) ;either the box is on top or the pallet is empty where it's being moved

    )
    :effect (and 
    (not (at ?c ?loc_org)) ;box leaves origin locatable
    (at ?c ?loc_dst) ;box is now on destiny locatable
    (not (on ?c ?c1)) ;box is no longer found above c1
    (on ?c ?c2) ;box is now above c2
    (top ?c1)
    )
)


)