(define (problem shakey1)
  (:domain shakey)

  (:objects
    box1 box2 box3 box4 - box
    switch1 switch2 switch3 switch4 - switch
    posroom1 posroom2 posroom3 posroom4 door1 door2 door3 door4 poscorridor - pos
    room1 room2 room3 room4 corridor - room
  )

  (:init
    (switch-at switch1 posroom1)
    (switch-at switch2 posroom2)
    (switch-at switch3 posroom3)
    (switch-at switch4 posroom4)
    (on switch1)
    (off switch2)
    (off switch3)
    (on switch4)
    (box-at box1 posroom1)
    (box-at box2 posroom1)
    (box-at box3 posroom1)
    (box-at box4 posroom1)
    (in posroom1 room1)
    (in posroom2 room2)
    (in posroom3 room3)
    (in posroom4 room4)
    (in door1 room1)
    (in door2 room2)
    (in door3 room3)
    (in door4 room4)
    (in door1 corridor)
    (in door2 corridor)
    (in door3 corridor)
    (in door4 corridor)
    (in poscorridor corridor)
    (ground)
    (shakey-at posroom3)
  )

  (:goal
    (on switch2)
  )
)