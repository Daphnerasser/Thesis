turtles-own [my-value]

to set-up
  clear-all
  ;resize-world 0 3 0 2
  resize-world 0 30 0 30
  ;ask patches [create-turtle]
  ask n-of 600 patches [create-turtle]
  reset-ticks
end

to create-turtle
    sprout 1 [
    set shape "circle"
    set my-value one-of [1 2 3 4 5]
    assigned-color
    ;set label who
  ]
end

to assigned-color
    ask turtles with [my-value = 1] [set color 125]
    ask turtles with [my-value = 2] [set color 128]
    ask turtles with [my-value = 3] [set color 9.9]
    ask turtles with [my-value = 4] [set color 108]
    ask turtles with [my-value = 5] [set color 105]
end

to go
  ;if ticks >= 2000 [
  ;stop
  ;]
  if random-float 1 < 0.5 [
    ask one-of turtles [
         ;set shape "turtle"
      let count-color [ ]
      foreach [1 2 3 4 5] [
        let main-turtle count other turtles in-radius 1.5  with [my-value = ?]
        set count-color lput main-turtle count-color
      ]
      let highest-value max count-color
      let max-color position highest-value count-color + 1
      let nb-with-most-freq-color one-of other turtles in-radius 1.5 with [ my-value = max-color]
      ;create-link-with nb-with-most-freq-color

      if nb-with-most-freq-color != nobody [
      ifelse abs (my-value - [my-value] of nb-with-most-freq-color) = 0
      [extreme]
      [ifelse abs (my-value - [my-value] of nb-with-most-freq-color) <= 2
        [consensus nb-with-most-freq-color]
        [extreme]
      ]
      ]
      assigned-color
      move
    ]
    ]
  tick
  ;clear-links
end


to extreme
  ifelse my-value = 4
  [set my-value (my-value + 1)]
  [ifelse my-value = 2
    [set my-value (my-value - 1)]
    [ ]
  ]
end

To consensus [other-turtle]
  ifelse my-value < [my-value] of other-turtle
  [set my-value (my-value + 1)]
  [set my-value (my-value - 1)]
end

to move
  ask other turtles in-radius 1.5 [
    ifelse my-value != [my-value] of myself
     [attract-same]
     [ ]
  ]
end

to attract-same
   fd random 5 + 1
   if any? other turtles-here [attract-same]
   move-to patch-here
end


