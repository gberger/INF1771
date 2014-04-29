(define (domain boxes)
  (:requirements :strips :equality :typing)
  (:types box)
  (:predicates
    (clear ?a - box)
    (table ?a - box)
    (on ?a - box ?b - box)
  )

  (:action put-on
    :parameters (?x ?y ?z - box)
    :precondition (and
      (clear ?x)
      (clear ?y)
      (on ?x ?z)
    )
    :effect (and
      (not (on ?x ?z))
      (on ?x ?y)
      (not (clear ?y))
      (clear ?z)
    )
  )

  (:action put-on
    :parameters (?x ?y - box)
    :precondition (and
      (clear ?x)
      (clear ?y)
      (table ?x)
    )
    :effect (and 
      (on ?x ?y)
      (not (table ?x))
      (not (clear ?y))
    )
  )

  (:action put-table
    :parameters (?x ?y - box)
    :precondition (and 
      (clear ?x)
      (on ?x ?y)
    )
    :effect (and
      (table ?x)
      (clear ?y)
      (not (on ?x ?y))
    )
  )
)