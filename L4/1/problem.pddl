(define (problem boxes1)
  (:domain boxes)

  (:objects
    a b c d - box
  )

  (:init
    (table c)
    (table d)
    (clear b)
    (on b a)
    (on a c)
    (clear d)
  )

  (:goal
    (and
      (clear c)
      (on c b)
      (on b a)
      (on a d)
      (table d)
    )
  )
)