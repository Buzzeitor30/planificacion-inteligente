;Header and description

(define (domain Port)

;remove requirements that are not needed
(:requirements :strips :fluents :typing :negative-preconditions :disjunctive-preconditions)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
box height - object
)

(:predicates ;todo: define predicates here
(movable ?c - box) ;this box is a movable object
(top ?c - box) ;this bos is at the top
(at ?c - box ?d - box) ;box ?c is at another box (docker)
(link ?loc1 - box ?loc2 - box) ;there is a box that links two boxes (docks)
(ready ?b - box ?d - box);box ?c is ready to deliver on dock ?d
(green ?b - box)
(on ?c - box ?c2 - box) ;a box ?c is above other box
(max_height ?d - box ?h - height) ;Max height in a box(dock)
(height ?c - box ?h - height) ;Current height of this box
(next ?h1 - height ?h2 - height)
)

(:action move
    :parameters (?c - box ?d_org - box ?d_dst - box  ?c_org - box ?c_dst - box ?h_prev - height ?h_next - height ?h_box - height    )
    :precondition (and
    (or (green ?c) (not (green ?c_dst))) 
    (movable ?c) ;box is movable
    (top ?c) ;box is on top
    (top ?c_dst)
    (at ?c ?d_org) ;box can be found at origin box
    (on ?c ?c_org) ;box is above another box
    (link ?d_org ?d_dst) ;dock1 is linked with dock2
    (height ?c_dst ?h_prev) ;pattern matching with the current height of dst box
    (not (max_height ?d_dst ?h_prev)) ; max height on dock dst is not the current height
    (at ?c_dst ?d_dst) ;box destiny can be found at destiny dock
    (next ?h_prev ?h_next)
    (height ?c ?h_box)
    )
    :effect (and 
    (at ?c ?d_dst)
    (not (at ?c ?d_org))
    (not (on ?c ?c_org))
    (on ?c ?c_dst)
    (top ?c_org)
    (not (top ?c_dst))
    (not (height ?c ?h_box))
    (height ?c ?h_next)
    (ready ?c ?d_dst)
    (ready ?c_org ?d_org)
    (not (ready ?c ?d_org))
    )
)

(:action move-extra
    :parameters (?c - box ?d_org - box ?d_dst - box  ?c_org - box ?c_dst - box ?h_prev - height ?h_next - height ?h_box - height    )
    :precondition (and
    (not (green ?c))
    (green ?c_dst)
    (movable ?c) ;box is movable
    (top ?c) ;box is on top
    (top ?c_dst)
    (at ?c ?d_org) ;box can be found at origin box
    (on ?c ?c_org) ;box is above another box
    (link ?d_org ?d_dst) ;dock1 is linked with dock2
    (height ?c_dst ?h_prev) ;pattern matching with the current height of dst box
    (not (max_height ?d_dst ?h_prev)) ; max height on dock dst is not the current height
    (at ?c_dst ?d_dst) ;box destiny can be found at destiny dock
    (next ?h_prev ?h_next)
    (height ?c ?h_box)
    )
    :effect (and 
    (at ?c ?d_dst)
    (not (at ?c ?d_org))
    (not (on ?c ?c_org))
    (on ?c ?c_dst)
    (top ?c_org)
    (not (top ?c_dst))
    (not (height ?c ?h_box))
    (height ?c ?h_next)
    (ready ?c ?d_dst)
    (not (ready ?c_dst ?d_dst))
    (ready ?c_org ?d_org)
    (not (ready ?c ?d_org))
    )
)


)