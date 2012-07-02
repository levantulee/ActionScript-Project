//Memory Game - GAM 152 by Simon Rozner
package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	//IMPORTING DATA
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	//Saving Data
	import flash.filesystem.*;
	
/*	import flash.net.FileReference;
    import flash.net.FileFilter;*/
	import flash.utils.ByteArray;
    import flash.errors.EOFError;

	
	//IMPORTS FOR SOUND
	import flash.media.Sound;
    import flash.media.SoundChannel;
	
	//create the CLASS
	public class memorygame extends MovieClip {
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
		//Repeat counter
		private var textCounter:TextField;
		//Highscore Display
		private var textHighScore:TextField;
		
		//delay timer (so a new turn doesn't start right away
		private var delayTimer:Timer = new Timer(2000);
		//light timer (how fast to play sequence)
		private var turnOnTimer:Timer;
		//off timer (how long to to leave light on theb turn off)
		private var turnOffTimer:Timer;
		
		//current game mode (light play sequence / player repeat sequence
		var gameState:String;
		//What movie clip is currently selected
		var currentSelection:MovieClip = null;
		
		//Score Board XML (saving and loading)
		private var xmlHighscore:XML;
		//Hiscore
		var highscore:int;
		
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
				whatLight.x = i*50+200;//give them a position X (with i and offset) and Y
				whatLight.y = 150;
				whatLight.ID = i;//load them into an array lights and give them an ID number
				lights.push(whatLight);//add the light to the light array
				addChild(whatLight);//add the light to the stage
				whatLight.addEventListener(MouseEvent.CLICK, clickLight);//make them clickable
				whatLight.buttonMode = true;//set its button move top true
			}
			
			var textFormat = new TextFormat();
			textFormat.font = "VERDANA";
			textFormat.size = 24;
			textFormat.align = "center";
			
			//Place a text field for game feedback
			textNotifications = new TextField();
			textNotifications.width = 550;
			textNotifications.height = 35;
			textNotifications.x = 0;
			textNotifications.y = 75;
			textNotifications.background = true;
			textNotifications.backgroundColor = 0xAAAAAA;
			textNotifications.selectable = false;
			textNotifications.defaultTextFormat = textFormat;
			addChild(textNotifications);
			
			//Place a text field for game score
			textScore = new TextField();
			textScore.width = 550;
			textScore.height = 35;
			textScore.x = 0;
			textScore.y = 350;
			textScore.background = true;
			textScore.backgroundColor = 0xDDDDDD;
			textScore.selectable = false;
			textScore.defaultTextFormat = textFormat;
			addChild(textScore);
			
			//Text Feedback
			textCounter = new TextField();
			textCounter.width = 550;
			textCounter.height = 35;
			textCounter.x = 0;
			textCounter.y = 250;
			textCounter.background = true;
			textCounter.backgroundColor = 0xDDDDDD;
			textCounter.selectable = false;
			textCounter.defaultTextFormat = textFormat;
			addChild(textCounter);
			
			//SHOW HIGHSCORE
			textHighScore = new TextField();
			textHighScore.width = 70;
			textHighScore.height = 60;
			textHighScore.x = 0;
			textHighScore.y = 0;
			textHighScore.background = true;
			textHighScore.backgroundColor = 0x444444;
			textHighScore.textColor = 0xDDDDDD;
			textHighScore.selectable = false;
			textHighScore.wordWrap = true;
			addChild(textHighScore);
			
			//LOAD XML DATA
			loadHighscore();
			//load sounds (put em in an array)
				//load them from an mp3 in the project folder
			//Prepare values for first run
			playOrder = new Array();
			gameState = "play";
			nextTurn();//run the first turn
		}//END INIT FUNCTION^^^^^
		
		//LOAD HIGHSCORE-----
		private function loadHighscore(){
			xmlHighscore = new XML();
			//Reading from WEB URL
			/*var xmlURL:URLRequest = new URLRequest("HighscoreTemp.xml");
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE,xmlLoaded);*/
			
			//Reading from LOCAL file
			var file:File = File.desktopDirectory.resolvePath("HighscoreTemp.xml");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			xmlHighscore = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
						
			fileStream.close();
			trace("Data Loaded");
			//trace (xmlHighscore);
			textHighScore.text = "Rank 1: " + xmlHighscore.Rank1.@score + 
								 "\n Rank 2: " + xmlHighscore.Rank2.@score + 
								 "\n Rank 3: " + xmlHighscore.Rank3.@score;
			
		}//End LOAD HIGHSCORE^^^^^
		
		//SAVE HIGHSCORE-----
		private function saveHighscore():void {
			var fileStream:FileStream = new FileStream();
			var file:File = File.desktopDirectory;
			file = file.resolvePath("HighscoreTemp.xml");
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(xmlHighscore);
			fileStream.close();
		}//End SAVE HIGHSCORE^^^^^
		
		//PLACE the LOADED XML Data-----
		private function xmlLoaded(event:Event){
			//xmlHighscore = XML(event.target.data);
			trace(xmlHighscore.Rank1.@score);
			trace("Data Loaded");
			textHighScore.text = "Rank 1: " + xmlHighscore.Rank1.@score + 
								 "\n Rank 2: " + xmlHighscore.Rank2.@score + 
								 "\n Rank 3: " + xmlHighscore.Rank3.@score;
		}//EndPLACE the LOADED XML Data^^^^^
		
		//CALCULATE THE HIGHSCORE AND SAVE IT INTO THE XML CONTAINER-----
		private function calculateHighscore():void {
			if (highscore > xmlHighscore.Rank1.@score){
				xmlHighscore.Rank1.@score = highscore;
				//textScore.text = "New HighScore Rank 1: " + highscore;
			} else if (highscore > xmlHighscore.Rank2.@score){
				xmlHighscore.Rank2.@score = highscore;
				//textScore.text = "New HighScore Rank 2: " + highscore;
			} else if (highscore > xmlHighscore.Rank3.@score){
				xmlHighscore.Rank3.@score = highscore;
				//textScore.text = "New HighScore Rank 3: " + highscore;
			} else {
				//textScore.text = "No Highscore Achieved";
				return;
			}
			textHighScore.text = "Rank 1: " + xmlHighscore.Rank1.@score + 
								 "\n Rank 2: " + xmlHighscore.Rank2.@score + 
								 "\n Rank 3: " + xmlHighscore.Rank3.@score;
			saveHighscore(); //Save the HighScore
			
			if (gameState == "GAME OVER"){
				MovieClip(root).rank1 = xmlHighscore.Rank1.@score;
				MovieClip(root).rank2 = xmlHighscore.Rank2.@score;
				MovieClip(root).rank3 = xmlHighscore.Rank3.@score;
				MovieClip(root).playerScore = highscore;
				
				MovieClip(root).gotoAndStop("GameOver");
			}
			
		}//End CALCULATE THE HIGHSCORE^^^^^
		
		//NEXT TURN FUNCTION-----
		private function nextTurn (){
			var whatLight:uint = Math.floor(Math.random()*lightCount);//pich a random light from the list of lights
			playOrder.push(whatLight);//Increase the REPEAT order by 1 by adding the random new light to the list
			
			textNotifications.text = "Sequence about to start!";//Show the player that the turn started and he should observe the sequence.
			textCounter.text = "Lenght " + playOrder.length;//Show how long the play order is (the array lenght)
			
			//Add a delay so playig doesn't start right away
			delayTimer.addEventListener(TimerEvent.TIMER, runTurnOnTimer);
			delayTimer.start();
		}//END NEXT TURN FUNCTION^^^^^
		
		//RUN TURN SEQUENCE ON TIMER FUNCTION-----
		private function runTurnOnTimer(event:TimerEvent){
			textNotifications.text = "Observe...";
			delayTimer.stop();
			turnOnTimer = new Timer(1000,playOrder.length+1);//SET UP the timer here to initiate the play sequence
			turnOnTimer.addEventListener(TimerEvent.TIMER,playSequence);//USING Timer(delay:Number, repeatCount:int = 0)
			turnOnTimer.start();//Now start the timer
		}//RUN TURN SEQUENCE ON TIMER FUNCTION^^^^^
		
		//PLAY SEQUENCE FUNCTION-----
		private function playSequence(event:TimerEvent){
			//keep track of the sequence by looking at the currentCount of how often
			//this sequence was called?
			var whatPosition:uint = event.currentTarget.currentCount-1;
			
			if(whatPosition < playOrder.length){//now check. if the play step is less then the order lenght,
				turnLightOn(playOrder[whatPosition]);//turn on the light at this position(playorder(current count)
			}else{
				repeatSequence();//ask the player to repeat the sequence
			}
		}//END PLAY SEQUENCE FUNCTION^^^^^
			
		//LIGHT REPEAT SEQUENCE FUNCTION-----
		private function repeatSequence(){
			currentSelection = null;//make sure anything the player selected is set to null
			textNotifications.text = "Repeat the sequence";//tell the player via a message that he is expected to repeat the sequence now
			gameState = "replay";//set the game mode to replay
			repeatOrder = playOrder.concat();//copy the play order into a repear order for the player  (use concat())
		}//END LIGHT REPEAT SEQUENCE FUNCTION^^^^^
		
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
			if (gameState != "replay") return;//IF is it repeat turn then continue, else return (blank, return no value)
			turnLightOff(null);//make sure to turn off all lights first (call lightoff with a null imput)
			//IF the current click is on the correct light (light ID number at first entry in array)
			if(event.currentTarget.ID == repeatOrder[0]){
				//then turn on the light
				turnLightOn(event.currentTarget.ID);
				repeatOrder.shift();//remove the element from the sequence
				highscore += 100;
				textScore.text = "Your Current Score " + highscore;
				if(repeatOrder.length == 0){//IF the repeat sequence is empty
					nextTurn();//go to the next turn
				}
			}else{//ELSE the wrong light must have been clicked at that mean GAME OVER
				gameState = "GAME OVER";//game mode is game over.
				//textNotifications.text = gameState; //give the game message of game over to the player
				calculateHighscore();
			}
		}//END PLAYER CLICKS^^^^^
			
			
	}//End Class

}//End Package
			
			