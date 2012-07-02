//Memory Game - GAM 152 by Simon Rozner

	//IMPORTS FOR SOUND

	
	//create the CLASS
//CONSTANTS---------
	//amount of lights (constant!)
	//list of lights
	//play order (getting longer every turn)
	//repeat order (array)
	
	//notification messages
	//score message
	
	//light timer (how fast to play sequence)
	//off timer (how long to to leave light on theb turn off)
	
	//current game mode (light play sequence / player repeat sequence
	//What movie clip is currently selected
	
	//sound list (LATER)
	
//END CONSTANTS^^^^^^^^^^^


//GAME FUNCTIONS -----------------------------
	//INIT FUNCTION-----
		//Place the game pieces
		//create array in lights
		//LOOP
				//make a new light object
				//select the frame of the light to set the colour
				//give them a position X (with i and offset) and Y
				//load them into an array lights and give them an ID number
				//add the light to the light array
				//add the light to the stage
				//make them clickable
				//set its button move top true
		//Place a text field for game feedback
		//Place a text field for game score
		//load sounds (put em in an array)
			//load them from an mp3 in he project folder
	//END INIT FUNCTION^^^^^
	
	//NEXT TURN FUNCTION-----
		//pich a random light from the list of lights
		//Increase the REPEAT order by 1 by adding the random new light to the list
		//Show the player that the turn started and he should observe the sequence.
		//Show how long the play order is (the array lenght)
		
		//SET UP the timer here to initiate the play sequence
		//USING Timer(delay:Number, repeatCount:int = 0)
		
		//Now start the timer
		
		//Start playing the sequence
	//END NEXT TURN FUNCTION^^^^^
	
	//PLAY SEQUENCE FUNCTION-----
		//keep track of the sequence by looking at the currentCount of how often
		//this sequence was called?
		
		//now check. if the play step is less then the order lenght,
			//turn on the light at this position(playorder(current count)
			//	make a function that turns on lights
		//else
			//ask the player to repeat the sequence
	//END PLAY SEQUENCE FUNCTION^^^^^
		
	//LIGHT REPEAT SEQUENCE FUNCTION-----
		//make sure anything the player selected is set to null
		//tell the player via a message that he is expected to repeat the sequence now
		//set the game mode to replay
		//copy the play order into a repear order for the player  (use concat())
	//END LIGHT REPEAT SEQUENCE FUNCTION^^^^^
	
	//TURN LIGHT ON FUNCTION-----(receive what light is curently active)
		//set the current selection to the current active light(received)
		//turn it on (set the frame of this colour to the ON colour)
		//define when to turn off
		//add the event listener to the timer and call the off light function
		//start the offtimer
	//END TURN LIGHT ON FUNCTION^^^^^
	
	//TURN LIGHTS OFF FUNCTION-----
		//IF the current selection is not null
			//go to the Light Off colour frame of this object
			//set the current selection to null
			//stop the off timer
	//END TURN LIGHTS OFF FUNCTION^^^^^
	
	//PLAYER CLICKS----- (must come from an event listener attached to the light refering to this function
		//IF is it repeat turn then continue, else return (blank, return no value)
		//make sure to turn off all lights first (call lightoff with a null imput)
		//IF the current click is on the correct light (light ID number)
			//then turn on the light
			//IF the repeat sequence is empty
				//go to the next turn
		//ELSE the wrong light must have been clicked at that mean GAME OVER
			//give the game message of game over to the player
			//game mode is game over.
	//END PLAYER CLICKS^^^^^
			
			
			
			
			
			