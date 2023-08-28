(define (domain gripper-strips)
    (:types balls rooms hands)
    (:predicates 

        (at-robby ?r - rooms)
        (at ?b - balls ?r - rooms)
        (free ?g - hands)
        (carry ?o - balls ?g - hands)
        (connected ?from ?to - rooms)
    )

   (:action move
       :parameters  (?from ?to - rooms)
       :precondition (
                        and 
                            (connected ?from ?to) ; This says that when you move from one room to another it is connected
                            (at-robby ?from)
                     )
       :effect (and  
                    ; This is the add effect
                    (at-robby ?to)

                    ; This is the delete effect
		            (not (at-robby ?from))
                )
    )



   (:action pick
       :parameters (?obj - balls ?room - rooms ?gripper - hands)
       :precondition  
                    (and  
			            (at ?obj ?room) 
                        (at-robby ?room) 
                        (free ?gripper)
                    )
       :effect 
                (and 
                    (carry ?obj ?gripper)
		            (not (at ?obj ?room)) 
		            (not (free ?gripper))
                )
    )


   (:action drop
       :parameters  (?obj - balls  ?room - rooms ?gripper - hands)
       :precondition  
                    (and
			            (carry ?obj ?gripper) 
                        (at-robby ?room)
                    )
       :effect 
                (and 
                    (at ?obj ?room)
		            (free ?gripper)
		            (not (carry ?obj ?gripper))
                )
    )
)

