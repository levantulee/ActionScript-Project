//Memory Game - GAM 152 by Simon Rozner
package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	//IMPORTS FOR SOUND
	import flash.media.Sound;
    import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	//create the CLASS
	public class memorygame extends Sprite {
	//CONSTANTS---------
		//amount of lights (constant!)
		static const lightCount:uint = 4;
		//list of lights
		private var lights:Array;
		//play order (getting longer every turn)
		private var playOrder:Array;
		//repeat order (array)
		private var repeatOrder:Array;
		
		//notification messages
		private var textNotifications:TextField;
		//score message
		private var textScore:TextField;
		
		//light timer (how fast to play sequence)
		private var turnOnTimer:Timer;
		//off timer (how long to to leave light on theb turn off)
		private var turnOffTimer:Timer;
		
		//current game mode (light play sequence / player repeat sequence
		var gameState:String;
		//What movie clip is currently selected
		var currentSelection:MovieClip = null;
		
		//sound list (LATER)
		
	//END CONSTANTS^^^^^^^^^^^
	
	
	//GAME FUNCTIONS -----------------------------
		//INIT FUNCTION-----
		public function memorygame(){
			//Place the game pieces
			//create array in lights
			lights = new Array();
			//LOOP
			for(var i:int = 0; i < lightCount; i++){
					trace("Placing", i);
					var whatLight:Light = new Light();//make a new light object
					whatLight.lightColour.gotoAndStop(i+1);//select the frame of the light to set the colour
					whatLight.x = i*50+100;//give them a position X (with i and offset) and Y
					whatLight.y = 150;
					whatLight.ID = i;//load them into an array lights and give them an ID number
					lights.push(whatLight);//add the light to the light array
					addChild(whatLight);//add the light to the stage
					whatLight.addEventListener(MouseEvent.CLICK, clickLight);//make them clickable
					whatLight.buttonMode = true;//set its button move top true
			}
			//Place a text field for game feedback
			//Place a text field for game score
			//load sounds (put em in an array)
				//load them from an mp3 in he project folder
		}//END INIT FUNCTION^^^^^
		
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
		private function turnLightOn(whatLight){
			currentSelection = lights[whatLight];//set the current selection to the current active light(received)
			currentSelection.gotoAndStop(2);//turn it on (set the frame of this colour to the ON colour)
			turnOffTimer = new Timer(500,1);//define when to turn off (after half a second, do it once)
			turnOffTimer.addEventListener(TimerEvent.TIMER_COMPLETE,turnLightOff);//add the event listener to the timer and call the off light function
			turnOffTimer.start();//start the offtimer
		}//END TURN LIGHT ON FUNCTION^^^^^
		
		//TURN LIGHTS OFF FUNCTION-----
		private function turnLightOff(event:TimerEvent){
			//IF the current selection is not null
			if (currentSelection != null){
				currentSelection.gotoAndStop(1);//go to the Light Off colour frame of this object
				currentSelection = null;//set the current selection to null
				turnOffTimer.stop();//stop the off timer
			}
		}//END TURN LIGHTS OFF FUNCTION^^^^^
		
		//PLAYER CLICKS----- (must come from an event listener attached to the light refering to this function
		private function clickLight(event:MouseEvent){
			//IF is it repeat turn then continue, else return (blank, return no value)
			//make sure to turn off all lights first (call lightoff with a null imput)
			//IF the current click is on the correct light (light ID number)
//			if(event.currentTarget.ID == repeatOrder.shift()){}
				//then turn on the light
				turnLightOn(event.currentTarget.ID);
				//IF the repeat sequence is empty
					//go to the next turn
			//ELSE the wrong light must have been clicked at that mean GAME OVER
				//give the game message of game over to the player
				//game mode is game over.
		}//END PLAYER CLICKS^^^^^
			
	}//End Class

}//End Package
			
			