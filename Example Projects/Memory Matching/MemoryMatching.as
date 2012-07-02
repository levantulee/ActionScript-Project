//MemoryMatching game
package {
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	import flash.text.*;

	public class MemoryMatching extends MovieClip {

		//GLOBALS
		//CARDS
		public var firstCard;
		public var secondCard;
		public var pairTrackerA:Array;
		//SCORE
		public var scorePlayer1:int;
		public var scorePlayer2:int;
		public var scoreText:TextField = new TextField();
		public var winnerText:Winner;
		//TURNS
		public var whosTurn:String;
		public var whosTurnText:TextField = new TextField();
		//TIMERS
		public var flipCardsT:Timer;
		public var removeCardsT:Timer;

		//AutoCalled on Game STart
		public function MemoryMatching() {
			init();
		}//END MemoryMatching

		//INIT ALL GAME VALUES
		public function init() {
			//Track what pairs are still on the field
			pairTrackerA=[0,1,2,3,4,5,6,7];
			//Set the scores to 0
			scorePlayer1=0;
			scorePlayer2=0;
			//Set the first turn
			whosTurn="Player 1";

			//INIT TIMER
			initTimers();
			//INIT BOARD
			initBoard();
			//INIT GUI
			initGUI();
		}

		public function initTimers() {
			//Timer to Flip cards back if guess was wrong
			flipCardsT=new Timer(800,1);
			flipCardsT.addEventListener(TimerEvent.TIMER_COMPLETE,flipCards);
			//Timer to remove cards if guess was right
			removeCardsT=new Timer(800,1);
			removeCardsT.addEventListener(TimerEvent.TIMER_COMPLETE,removeCards);
		}

		public function initBoard() {
			//crate ramdom shuffle of 8 cards
			var cardsA:Array=[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7];
			var shuffleA:Array = new Array();
			for (var i:int = cardsA.length; i > 0; i--) {
				var aPos:int=Math.floor(Math.random()*cardsA.length);//get a random position in the cards
				shuffleA.push(cardsA[aPos]);//put it into the shuffle
				cardsA.splice(aPos,1);//remove from the ordered array
			}
			
			//create gamefield 4x4
			//2d Array
			var uniqueID = 0;//give each card a Unique ID
			for (var j:int = 0; j < 4; j++) {
				var anX=j*75+j*3+5;
				for (var k:int = 0; k < 4; k++) {
					var aCard:CARD = new CARD();
					aCard.x=anX;
					aCard.y=k*75+k*3+5;
					aCard.ID=shuffleA[0];//Give the card an ID
					aCard.uniqueID=uniqueID;
					aCard.gotoAndStop(9);//Give the card a blank field
					shuffleA.splice(0,1);//remove the first position from the shuffle
					aCard.addEventListener(MouseEvent.CLICK, clickedACard);//register clicks
					stage.addChild(aCard);
					uniqueID++;
				}
			}
		}

		public function initGUI() {
			//Place Scoring Meter
			scoreText.width=175;
			scoreText.x=stage.width-scoreText.width+10;
			scoreText.y=50;
			stage.addChild(scoreText);
			scoreText.text="Player1: "+scorePlayer1+"   Player2: "+scorePlayer2;
			//Place player tracker
			whosTurnText.width=175;
			whosTurnText.x=stage.width-whosTurnText.width+10;
			whosTurnText.y=20;
			stage.addChild(whosTurnText);
			whosTurnText.text="Who's Turn: "+whosTurn;
		}

		public function clickedACard(event:MouseEvent) {
			if (firstCard==null) {//fill first unselected card
				firstCard=event.target;
				firstCard.gotoAndStop(firstCard.ID+1);//Reveal its graphic by going to timeline position
			} else if (secondCard == null) {//fill second unselected card
				secondCard=event.target;
				if (secondCard.uniqueID!=firstCard.uniqueID) {//Not the same card
					secondCard.gotoAndStop(secondCard.ID+1);//Reveal its graphic by going to timeline position
					if (firstCard is CARD && secondCard is CARD) {//make sure they are both of type CARD
						compareCards(); //compare them
					}
				} else {//same card selected, reset second card
					trace("Clicked Same Card");
					secondCard=null;
				}
			} else {
				trace("TwoCardsAlreadySelected");
			}

		}//END clickedACard

		public function compareCards() {
			//Compare Cards
			if (firstCard.ID==secondCard.ID) {//MATCH YES
				removeCardsT.start();
				if (whosTurn=="Player 1") {//update the score
					scorePlayer1+=1;
				} else {
					scorePlayer2+=1;
				}
			} else { //MATCH NO
				if (whosTurn=="Player 1") {//update the current player
					whosTurn="Player 2";
				} else {
					whosTurn="Player 1";
				}
				//Start DELAY to Flip Back
				flipCardsT.start();
			}
			updateScore();
		}

		public function flipCards(event:TimerEvent) {//reset the cards and hide them
			firstCard.gotoAndStop(9);
			secondCard.gotoAndStop(9);
			firstCard=null;
			secondCard=null;
		}

		public function removeCards(event:TimerEvent) {//remove the cards and update the tracker
			var aPos=pairTrackerA.indexOf(firstCard.ID);
			pairTrackerA.splice(aPos, 1);
			stage.removeChild(firstCard);
			stage.removeChild(secondCard);
			firstCard=null;
			secondCard=null;
			if (pairTrackerA.length==0) {//if no more cards are on the board, show the winner
				showWinner();
			}
		}

		public function updateScore() {
			scoreText.text="Player1: "+scorePlayer1+"   Player2: "+scorePlayer2;
			whosTurnText.text="Who's Turn: "+whosTurn;
		}

		public function showWinner() {
			winnerText = new Winner();
			winnerText.x=stage.width/2;
			winnerText.y=stage.height/2;
			stage.addChild(winnerText);
			winnerText.addEventListener(MouseEvent.CLICK, playAgain);
			
			//Determine the winner & show on screen
			if (scorePlayer1>scorePlayer2) {
				winnerText.WinnerT.text="Player 1 wins!";
				trace("A Winner!  Player 1");
			} else if (scorePlayer1 < scorePlayer2) {
				winnerText.WinnerT.text="Player 2 wins!";
				trace("A Winner!  Player 2");
			} else {
				winnerText.WinnerT.text="DRAW";
			}
		}
		
		//If the players want to play again, re-init the game
		public function playAgain(event:MouseEvent) {
			stage.removeChild(winnerText);//Clear Winner Field
			init(); //re-init
		}

	}//END CLASS
}//END PACKAGE