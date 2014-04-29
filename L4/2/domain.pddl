(define (domain shakey)
  (:requirements :strips :equality :typing)
  (:types room switch box pos)
  (:predicates
    (in ?p - pos ?r - room)
    (box-at ?b - box ?p - pos)
    (switch-at ?s - switch ?p - pos)
    (shakey-at ?p - pos)
    (on ?s - switch)
    (off ?s - switch)
    (top ?b - box)
    (ground)
  )

  (:action ir
    :parameters (?x ?y - pos ?r - room)
    :precondition (and
      (in ?x ?r)
      (in ?y ?r)
      (shakey-at ?x)
      (ground)
    )
    :effect (and
      (not (shakey-at ?x))
      (shakey-at ?y)
    )
  )

  (:action empurrar
    :parameters (?b - box ?x ?y - pos ?r - room)
    :precondition (and
      (in ?x ?r)
      (in ?y ?r)
      (shakey-at ?x)
      (box-at ?b ?x)
      (ground)
    )
    :effect (and
      (not (shakey-at ?x))
      (shakey-at ?y)
      (not (box-at ?b ?x))
      (box-at ?b ?y)
    )
  )

  (:action subir
    :parameters (?b - box ?p - pos)
    :precondition (and
      (ground)
      (box-at ?b ?p)
      (shakey-at ?p)
    )
    :effect (and
      (not (ground))
      (top ?b)
    )
  )

  (:action descer
    :parameters (?b - box ?p - pos)
    :precondition (and
      (top ?b)
      (box-at ?b ?p)
    )
    :effect (and
      (ground)
      (not (top ?b))
    )
  )

  (:action ligar-luz
    :parameters (?s - switch ?b -box ?p - pos)
    :precondition (and
      (off ?s)
      (box-at ?b ?p)
      (switch-at ?s ?p)
      (shakey-at ?p)
      (top ?b)
    )
    :effect (and
      (not (off ?s))
      (on ?s)
    )
  )

  (:action desligar-luz
    :parameters (?s - switch ?b -box ?p - pos)
    :precondition (and
      (on ?s)
      (box-at ?b ?p)
      (switch-at ?s ?p)
      (shakey-at ?p)
      (top ?b)
    )
    :effect (and
      (not (on ?s))
      (off ?s)
    )
  )
)