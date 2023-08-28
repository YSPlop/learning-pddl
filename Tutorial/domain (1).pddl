(define (domain gripper-strips)
(:requirements :strips)
    (:types balls rooms hands)
    (:predicates 

        (at-robby ?r - rooms)
        (at ?b - balls ?r - rooms)
        (free ?g - hands)
        (carry ?o - balls ?g - hands)
    )

   (:action move
       :parameters  (?from ?to - rooms)
       :precondition (and (at-robby ?from))
       :effect (and  
                    (at-robby ?to)
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
                        (ball ?obj) 
                        (room ?room) 
                        (gripper ?gripper)
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

