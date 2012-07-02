/*Game: Othello
Purpose: Make simple Othello AS3 Flash implementation, Learn AS3

Written Sept/Oct 2010 in Singapore by Simon Etienne Rozner, Lecturer at DigiPen Institute of Technology

Version:	0.3
Date: 		21.10.2010
Comments: 	-CORE GAMEPLAY FINISHED
			-Ready for Polishing
			-TO DO: Integrate proper start and start again logic and retention of victory scores in movie
			-TO DO: settings screen to enable and disable tips/hints
			-TO DO: Allow for quick scaling of game graphics for quick deployment on multiple platforms
			-TO DO: Make nice graphics
			

Revision History:
Version:	0.2
Date: 		14.10.2010
Comments: 	-DONE - Hints: Placed Double thus Hint-Marker not removed. Check if a hint already exists before placing it!
			-DONE Build improved checking list to avoid duplicate variable definition warning -> Reduce to two functions with a flagged function call.
			-DONE - Elliminate Term has undefined properties error (One was an out of bounds not checked properly!) RECHECK
			-DONE - flipList not containing all possibilities/somtimes an undefined position!

Version:	0.1
Date: 		13.10.2010
Comments: 	-DONE Added Revision History DONE
			-DONE Clean Up Hints and replace them DONE
			-DONE Better Garbage Collection DONE
			-Fixing Bug of not detecting correct possibilities DONE VERT/HORZ , DONE DIAGONALS

*/

package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class Othello extends MovieClip {
		
		//BOARD SETTINGS
		static const boardWidth:int = 8;
		static const boardHeight:int = 8;
		static const boardPieceOffset:int = 50;
		static const boardPieceSpacing:int = 50;
		
		//PIECES INIT SETTINGS
		//ROW 4, COLUMN 4 and 5 = BLACK, WHITE
		//ROW 5, COLUMN 4 and 5 = WHITE, BLACK
		
		private var gameHintsEnabled:Boolean = true;
		private var gameHoverHintsEnabled:Boolean = true;
		private var gameFlipHintsEnabled:Boolean = true;
		
		//Keep Track of Board Pieces
		private var gameFieldList:Array = new Array();
		
		private var playerTrackerText:TextField = new TextField();
		
		private var playerTurn = "black";//White player goes first
		private var otherPlayer = "white";//Black player is opponent
		
		//WINNING CONDITION STATEMENTS
		
		private var howManyWhitePieces = "White:  " + 0;
		private var howManyBlackPieces = "Black:  " + 0;
		private var howManyPossibleMoves = 0;
		private var WhitePiecesTrackerText:TextField = new TextField();
		private var BlackPiecesTrackerText:TextField = new TextField();
		
		//END DEFINING VARIABLES----------------------------------------
	
	
		//MAIN FUNCTION-------------------------------------------------
		public function Othello(){
			
			makePieceTracking();
			makePlayerTracking();
			makeBoard();
			makeStartPieces();
			
			checkValidPosition();
			trackScore(); //Keep track of score and winning conditions
						
		}//END MAIN------------------------------------------------------
		
		
		public function trackScore():void{
			trace("TRACKING SCORE");
			countPlayerPieces();//IN A FUNCTION Keep track of how many tiles are white how many are black
			
		}//END trackScore
		public function makePieceTracking():void{
				trace("ADDING TRACKING SCORE FIELDS");
				WhitePiecesTrackerText.x = boardWidth*boardPieceSpacing+50;
				WhitePiecesTrackerText.y = 75;
				WhitePiecesTrackerText.text = howManyWhitePieces;
				addChild(WhitePiecesTrackerText);
				
				BlackPiecesTrackerText.x = boardWidth*boardPieceSpacing+50;
				BlackPiecesTrackerText.y = 90;
				BlackPiecesTrackerText.text = howManyBlackPieces;
				addChild(BlackPiecesTrackerText);
		}
		public function countPlayerPieces():void{
			trace("TRACKING PLAYER PIECES");
			//set count for both to 0
			howManyBlackPieces = 0;
			howManyWhitePieces = 0;
			howManyPossibleMoves = 0;
			
			//cycle boardgame and count player pieces
			for (var i:int = 0; i < boardWidth; i++){
				for (var j:int = 0; j < boardHeight; j++){
					if(gameFieldList[i][j].colour == "white"){
						howManyWhitePieces++;
					}else if (gameFieldList[i][j].colour == "black"){
						howManyBlackPieces++;
					}
					if(gameFieldList[i][j].valid == true){
						howManyPossibleMoves++;
					}
				}
			}
			//trace(howManyWhitePieces);
			//trace(howManyBlackPieces);
			showCount();//IN A FUNCTION PLACE two gamefields that show the total
			if (howManyPossibleMoves == 0){
				gameOver();//IN A FUNCTION check if any available move are existing, if not, then the game ends. OPTIONAL (Ask to reset the boardgame?)
			}

		}//END countPlayerPieces
		public function showCount():void{
			trace("SHOWING SCORE");
			WhitePiecesTrackerText.text = "White:  " + howManyWhitePieces;
			BlackPiecesTrackerText.text = "Black:  " + howManyBlackPieces;
		}
		public function gameOver():void{
			var gameOverText:TextField = new TextField()
			gameOverText.x = (boardWidth*boardPieceSpacing)/2;
			gameOverText.y = (boardHeight*boardPieceSpacing)/2;
			gameOverText.text = "GAME OVER";
			addChild(gameOverText)
			
			var Winner:TextField = new TextField()
			Winner.x = (boardWidth*boardPieceSpacing)/2;
			Winner.y = (boardHeight*boardPieceSpacing)/2+50;
			if(howManyWhitePieces > howManyBlackPieces){
				Winner.text = "WHITE WINS";
			} else {
				Winner.text = "BLACK WINS";
			}
			addChild(Winner)
			MovieClip(root).gotoAndStop("GameOver");
		}//END countMoves
		public function makePlayerTracking():void{
				playerTrackerText.x = boardWidth*boardPieceSpacing+50;
				playerTrackerText.y = 50;
				playerTrackerText.text = playerTurn;
				addChild(playerTrackerText);
		}
		

		public function makeBoard():void{
			//popoulate the game board with the board
			for (var i:int = 0; i < boardWidth; i++){
				//Set the X Position for BoardPiece
				var anX = i*boardPieceOffset+boardPieceSpacing;

				var ColumnPosition:Array = new Array ();
				for (var j:int = 0; j < boardHeight; j++){
					//Set the Y Position for BoardPiece
					var anY = j*boardPieceOffset+boardPieceSpacing;
					
					//Generate the BoardPiece
					var boardPiece:BoardPiece = new BoardPiece();
					boardPiece.Row = i;
					boardPiece.Column = j;
					boardPiece.addEventListener(MouseEvent.CLICK,clickBoardPiece);
					boardPiece.addEventListener(MouseEvent.MOUSE_OVER,hoverBoardPiece);
					boardPiece.addEventListener(MouseEvent.MOUSE_OUT,removehoverBoardPiece);
					boardPiece.x = anX;
					boardPiece.y = anY;
					boardPiece.colour = "blank";
					boardPiece.valid = false;
					boardPiece.flipList = new Array();
					//boardPiece.hint = 0;
					addChild(boardPiece);
					if (gameHintsEnabled == true){
						var boardPieceText:TextField = new TextField();
						boardPieceText.x = anX;
						boardPieceText.y = anY;
						boardPieceText.text = i +" "+j;
						boardPieceText.z = -1;
						addChild(boardPieceText);
					}
					//Add piece to list
					ColumnPosition[j] = boardPiece;
				}
				gameFieldList.push(ColumnPosition);
			}
		}//End MAKEBOARD
		
		public function makeStartPieces():void{
			for (var i:int = 0; i < 2; i++){
				var gamepieceWhite:GamepieceWhite = new GamepieceWhite();
				gamepieceWhite.x = gameFieldList[boardWidth/2+i-1][boardWidth/2+i-1].x;
				gamepieceWhite.y = gameFieldList[boardWidth/2+i-1][boardWidth/2+i-1].y;
				gamepieceWhite.mouseEnabled = false;
				gameFieldList[boardWidth/2+i-1][boardWidth/2+i-1].colour = "white";
				gameFieldList[boardWidth/2+i-1][boardWidth/2+i-1].theGamepiece = gamepieceWhite;
				addChild(gamepieceWhite);
			}
			for (var j:int = 0; j < 2; j++){
				var gamepieceBlack:GamepieceBlack = new GamepieceBlack();
				gamepieceBlack.x = gameFieldList[boardWidth/2+j-1][boardWidth/2+j-1].x;
				gamepieceBlack.y = gameFieldList[boardWidth/2-j][boardWidth/2-j].y;
				gamepieceBlack.mouseEnabled = false;
				gameFieldList[boardWidth/2+j-1][boardWidth/2-j].colour = "black";
				gameFieldList[boardWidth/2+j-1][boardWidth/2-j].theGamepiece = gamepieceBlack;
				addChild(gamepieceBlack);
			}
		}//End MAKEPIECES	
		
		public function clickBoardPiece(event:MouseEvent){
			var row:int = event.currentTarget.Row;
			var column:int = event.currentTarget.Column;
			//trace("------Click", row,column, gameFieldList[row][column].colour);
			if (gameFieldList[row][column].colour == "blank"){
				
				if (gameFieldList[row][column].valid == true){
					//trace("-------------clickBoardPiece Valid?", gameFieldList[row][column].valid, row, column);
					flipPieces(row,column);
					if (gameFlipHintsEnabled == true){
						//REMOVE OLD FLIP CHECK MARKERS
						removeFlipCheckMarker();
						//ADD MARKERS TO SHOW WHAT WAS FLIPPED
						placeFlipCheckMarker(row,column);
					}
					if (gameHintsEnabled == true){
						garbageCollection(row,column);
					}
					//Set other players turn after clicking on a valid place.
					if (playerTurn == "white"){
						playerTurn = "black";
						otherPlayer = "white";
					} else {
						playerTurn = "white";
						otherPlayer = "black";
					}
					clearFlipLists(row,column);
					
					playerTrackerText.text = playerTurn;
					checkValidPosition();
					trackScore();
				}
			}
		}//End CLICKBOARD
		
		public function flipPieces(row:int,column:int){
			placeGamePiece(row,column);
			var whatgamePiece;
			//get the fliplist of this tile
			var flippingList = gameFieldList[row][column].flipList;
			//cycle the list and flipt them to the other colour			
			for (var i:int = 0; i <= flippingList.length-1; i++){
				if (playerTurn == "white"){
						var gamepieceWhite:GamepieceWhite = new GamepieceWhite();
						whatgamePiece = gamepieceWhite;
				} else {
					var gamepieceBlack:GamepieceBlack = new GamepieceBlack();
					whatgamePiece = gamepieceBlack;
				}
				//set the new piece location
				whatgamePiece.x = flippingList[i].x;
				whatgamePiece.y = flippingList[i].y;
				whatgamePiece.mouseEnabled = false;
				
				//remove the old piece
				removeChild(flippingList[i].theGamepiece);
				
				//Add the new piece
				flippingList[i].theGamepiece = whatgamePiece;
				
				addChild(flippingList[i].theGamepiece);
				//Set the field to player colour
				flippingList[i].colour = playerTurn;
				
				
			}
		}//End FLIPIECES

		public function placeGamePiece(r:int,c:int){
			var whatgamePiece;
			if (playerTurn == "white"){
				var gamepieceWhite:GamepieceWhite = new GamepieceWhite();
				whatgamePiece = gamepieceWhite;
			} else {
				var gamepieceBlack:GamepieceBlack = new GamepieceBlack();
				whatgamePiece = gamepieceBlack;
			}
			whatgamePiece.x = gameFieldList[r][c].x;
			whatgamePiece.y = gameFieldList[r][c].y;
			whatgamePiece.mouseEnabled = false;
			gameFieldList[r][c].colour = playerTurn;
			gameFieldList[r][c].theGamepiece = whatgamePiece;
			addChild(whatgamePiece);
		}//End PLACEGAMEPIECE

		//FUNCTION TO ADD FLIPPED CHECKING MARKER
		public function placeFlipCheckMarker(row:int,column:int){
			var v;
			v = gameFieldList[row][column].flipList;

			//cycle through the fliplist of this tile and add markers to all the pieces that are listed as to flip
			for (var i:int = 0; i <= v.length-1; i++){
				var u = v[i]; //get the flippable piece at this position
				//check if a hint already is placed at this position, if not, place it.
				if (u.flipCheck == undefined){
					var gamepieceFlipCheck:GamepieceFlipCheck = new GamepieceFlipCheck();
					gamepieceFlipCheck.x = u.x;
					gamepieceFlipCheck.y = u.y;
					gamepieceFlipCheck.mouseEnabled = false;
					u.flipCheck = gamepieceFlipCheck;
					addChild(gamepieceFlipCheck);
				}
			}
		}//END placeFlipCheckMarker
		//FUNTION TO REMOVE CHECKING MARKERS AFTER A NEW CLICK HAS BEEN MADE
		public function removeFlipCheckMarker():void{
			for (var i:int = 0; i < boardWidth; i++){
				for (var j:int = 0; j < boardHeight; j++){
					if (gameFieldList[i][j].flipCheck == undefined) {
						////trace('Obj does not exists @',i,j);
						} else {
						////trace("Removing Hint @",i,j);
						removeChild (gameFieldList[i][j].flipCheck);
						delete gameFieldList[i][j].flipCheck;
					}
				}
			}
		}//END removeFlipCheckMarker

		public function addHints(row:int,column:int){
			//check if a hint already is placed, if not, place it.
			if (gameFieldList[row][column].hint == undefined){
				var gamepieceHint:GamepieceHint = new GamepieceHint();
				gamepieceHint.x = gameFieldList[row][column].x;
				gamepieceHint.y = gameFieldList[row][column].y;
				gamepieceHint.mouseEnabled = false;
				gameFieldList[row][column].hint = gamepieceHint;
				addChild(gamepieceHint);
			}
		}//End ADDHINTS
		public function garbageCollection(row:int,column:int){
			//Cycle through the board and essentially remove all the old stuff, such as hints and old game pieces
			for (var i:int = 0; i < boardWidth; i++){
				for (var j:int = 0; j < boardHeight; j++){
					if (gameFieldList[i][j].hint == undefined) {
						} else {
						removeChild (gameFieldList[i][j].hint);
						delete gameFieldList[i][j].hint;
					}
				}
			}
		}//End GARBAGECOLLECTION
		
		
		




		public function clearFlipLists(row:int,column:int){
			var v = gameFieldList[row][column].flipList;
			if (v.length > 0){
				for (var i:int = 0; i < boardWidth; i++){
					for (var j:int = 0; j < boardHeight; j++){
						var u = gameFieldList[i][j].flipList;
						//trace(u.length);
						u.length = 0;
						gameFieldList[i][j].flipList = u;
						gameFieldList[i][j].valid = false;
						var grml = gameFieldList[i][j].flipList;
						//trace("CLEARING", grml.length,i,j);
					}
				}
			}
		}//End CLEAR FLIP LISTS
		//Add Fliplist to Tile
		public function addFlipList(row:int,column:int,tempArray:Array):void{
			//cycle all valid positions form tempArray into validFlipPositions
			if (gameFieldList[row][column].colour == "blank"){//Only add things of the field is in fact an opposing player)
				var v;
				v = gameFieldList[row][column].flipList;
				var validFlipPositions:Array = new Array();
				var u; 
				for (var i:int = 0; i <= tempArray.length-1; i++){
					u = tempArray[i];
					validFlipPositions.push(u);
					if(u == undefined){
						//trace("ALERT 1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", row, column);
					}
				}
				
				if (v.length > 0){//If things are already in the gameFieldList, re-add them to the validflippositions. bacause of below
					var w;
					for (var j:int = 0; j <= v.length-1; j++){
						w = v[j];
						if(v[j] != undefined){
							//trace("ALERT 2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", row, column);
							//trace("ALERT 2 Lenght",v.length, "Position",j);
							validFlipPositions.push(w);
						}
					}
				}
				
				tempArray.length = 0;
				gameFieldList[row][column].flipList = validFlipPositions;
				//print flipList
				printFlipListonLocation(row,column);
			}
		}//End FLIPLIST TO TILE
		 
		 public function printFlipListonLocation(row:int,column:int){
			var v;
				v = gameFieldList[row][column].flipList;
			for (var i:int = 0; i <= v.length-1; i++){
				//trace(v[i],v[i].Row, v[i].Column, "Attached to",row,column);
				if(v[i] == undefined){
					//trace("ALERT 3 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", row, column);
				}
			}
		}





		//Check Valid Positions
		public function checkValidPosition():void{
			//Loop through the gameFieldList and find valid positions for the player
			for (var row:int = 0; row <= boardWidth-1; row++){
				for (var column:int = 0; column <= boardHeight-1; column++){
					if (gameFieldList[row][column].colour == "blank"){
						//check Diagonals
						evaluateDiagonalRU(row,column);
						evaluateDiagonalLU(row,column);
						evaluateDiagonalRD(row,column);
						evaluateDiagonalLD(row,column);
						
						//check  Cominations with flags (UP,DOWN,LEFT,RIGHT,DIAGONAL dUPLEFT, dUPRIGHT, dDOWNLEFT, dDOWNRIGHT)
						evalComb_Horizontal_Right(row,column);
						evalComb_Horizontal_Left(row,column);
						evalComb_Horizontal_Up(row,column);
						evalComb_Horizontal_Down(row,column);
						
					}
				}
			}
			trace("--------------------------NEW TURN------------------------------");
		}//End CHECK VALID POSITIONS


public function evalComb_Horizontal_Right(row:int,column:int){
			var tempArray:Array = new Array();
			//Adjacent Right
			if (row+1 <= boardWidth-1 && gameFieldList[row+1][column].colour == otherPlayer){
				for (var i:int = row+2; i <= boardWidth-1; i++){//continue to loop
					if (gameFieldList[i][column].colour == playerTurn){
						//add all additional otherPlayer pieces inbetween to the array
						for (var j:int = i-1; j >= row+1; j--){ 
							//trace("Adding to list RIGHT", j, column, "to tile",row,column);
							tempArray.push(gameFieldList[j][column]);
						}
						gameFieldList[row][column].valid = true;
						if (gameHintsEnabled == true){
							addHints(row,column);
						}
						break;
					} else if (gameFieldList[i][column].colour == "blank"){
						break;
					}
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}
		}//End ADJACENT right
		public function evalComb_Horizontal_Left(row:int,column:int){
			var tempArray:Array = new Array();
			//Adjacent left
			if (row-1 >= 0 && gameFieldList[row-1][column].colour == otherPlayer){
				for (var i:int = row-2; i >= 0; i--){//continue to loop
					if (gameFieldList[i][column].colour == playerTurn){
						//add all additional otherPlayer pieces inbetween to the array
						for (var j:int = i+1; j <= row-1; j++){ //for (var j:int = i+1; j <= row-1; j++){ 
							tempArray.push(gameFieldList[j][column]);
						}
						gameFieldList[row][column].valid = true;
						if (gameHintsEnabled == true){
							addHints(row,column);
						}

						break;
					}else if (gameFieldList[i][column].colour == "blank"){
						break;
					}
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}
		}//End ADJACENT left
		public function evalComb_Horizontal_Up(row:int,column:int){
			var tempArray:Array = new Array();
			//Adjacent up
			if (column-1 >= 0 && gameFieldList[row][column-1].colour == otherPlayer){
				for (var i:int = column-2; i >= 0; i--){//continue to loop
					if (gameFieldList[row][i].colour == playerTurn){
						//add all additional otherPlayer pieces inbetween to the array
						for (var j:int = i+1; j <= column-1; j++){ 
							tempArray.push(gameFieldList[row][j]);
						}
						
						gameFieldList[row][column].valid = true;

						if (gameHintsEnabled == true){
							addHints(row,column);
						}

						break;
					}else if (gameFieldList[row][i].colour == "blank"){
						break;
					}
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}
		}//End ADJACENT top
		public function evalComb_Horizontal_Down(row:int,column:int){
			var tempArray:Array = new Array();
			//Adjacent bottom
			if (column+1 <= boardHeight-1 && gameFieldList[row][column+1].colour == otherPlayer){
				for (var i:int = column+2; i <= boardHeight-1; i++){//continue to loop
					if (gameFieldList[row][i].colour == playerTurn){
						//add all additional otherPlayer pieces inbetween to the array
						for (var j:int = i-1; j >= column+1; j--){ 
							tempArray.push(gameFieldList[row][j]);
						}
						gameFieldList[row][column].valid = true;
						if (gameHintsEnabled == true){
							addHints(row,column);
						}

						break;
					} else if (gameFieldList[row][i].colour == "blank"){
						break;
					}
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}//End ADJACENT bottom----------------------------------------------
		}
		public function evaluateDiagonalRD(row:int,column:int){
			var tempArray:Array = new Array();
			//Diagonal Right/Down
			if (row+1 <= boardWidth-1 && column+1 <= boardHeight-1 && gameFieldList[row+1][column+1].colour == otherPlayer){
				var i:int = 1;
				while (i <= boardHeight-1 && i <= boardWidth){
					var rowi:int = row+1 + i;
					var columni:int = column+1 + i;
					
					if (rowi <= boardWidth-1 && columni <= boardHeight-1 && gameFieldList[rowi][columni].colour == playerTurn){
						var j:int = rowi-1;
						var k:int = columni-1;
						while (j >= row+1 && k >= column+1){
							tempArray.push(gameFieldList[j][k]);
							j--;
							k--;
						}
						gameFieldList[row][column].valid = true;
						if (gameHintsEnabled == true && gameFieldList[row][column].hint == undefined){
							addHints(row,column);
						}
						break;
						
					} else if (rowi <= boardWidth-1 && columni <= boardHeight-1 && gameFieldList[rowi][columni].colour == "blank"){
						break;
					}
						
					i++;
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}//End Diagonal Right/Down
		}
		public function evaluateDiagonalLU(row:int,column:int){
			var tempArray:Array = new Array();
			//Diagonal Left/Up
			if (row-1 >= 0 && column-1 >= 0 && gameFieldList[row-1][column-1].colour == otherPlayer){
				var i:int = 1;
				while (column - i >= 0 && row - i >= 0){
						var rowi:int = row - i;
						var columni:int = column - i;
												
						if (gameFieldList[rowi][columni].colour == playerTurn){ //rowi >= 0 && columni >= 0 && 
							var j:int = rowi+1;
							var k:int = columni+1;
							while (j <= row-1 && k <= column-1){
								tempArray.push(gameFieldList[j][k]);
								j++;
								k++;
							}
												
							gameFieldList[row][column].valid = true;
							if (gameHintsEnabled == true && gameFieldList[row][column].hint == undefined){
								addHints(row,column);
							}
							break;
						
						} else if (gameFieldList[rowi][columni].colour == "blank"){
							break;
						}
						
					i++;
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}//End Diagonal Left/Up
		}
		public function evaluateDiagonalRU(row:int,column:int){							
			var tempArray:Array = new Array();
			//Diagonal Right/Up
			if (row+1 <= boardWidth-1 && column-1 >= 0 && gameFieldList[row+1][column-1].colour == otherPlayer){
				var i:int = 1;
				while (column - i >= 0 && i <= boardWidth){
					var rowi:int = row + i;
					var columni:int = column - i;
					if (rowi <= boardWidth-1 && gameFieldList[rowi][columni].colour == playerTurn){
						
						var j:int = rowi-1;
						var k:int = columni+1;
						while (j >= row+1 && k <= column-1){
							tempArray.push(gameFieldList[j][k]);
							j--;
							k++;
						}
						
						gameFieldList[row][column].valid = true;
						if (gameHintsEnabled == true && gameFieldList[row][column].hint == undefined){
							addHints(row,column);
						}
						
						break;
						
					} else if (rowi <= boardWidth-1 && gameFieldList[rowi][columni].colour == "blank"){
						break;
					}
						
					i++;
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}//End Diagonal Right/Up
		}
		public function evaluateDiagonalLD(row:int,column:int){
			var tempArray:Array = new Array();
			//Diagonal Left/Down
			if (column+1 <= boardHeight-1 && row-1 >= 0 &&gameFieldList[row-1][column+1].colour == otherPlayer){
				var i:int = 1;
				while (column + i <= boardHeight-1 && row - i >= 0){
					var rowi:int = row - i;
					var columni:int = column + i;
					
					if (columni <= boardHeight-1 && gameFieldList[rowi][columni].colour == playerTurn){
						var j:int = rowi+1;
						var k:int = columni-1;
						while (j <= row-1 && k >= column+1){
							tempArray.push(gameFieldList[j][k]);
							j++;
							k--;
						}
						
						gameFieldList[row][column].valid = true;
						if (gameHintsEnabled == true && gameFieldList[row][column].hint == undefined){
							addHints(row,column);
						}
						break;
					
					} else if (gameFieldList[rowi][columni].colour == "blank"){
						break;
					}
						
					i++;
				}
				if (tempArray.length > 0){
					addFlipList(row,column,tempArray);
					tempArray.length = 0;
				}
			}//End Diagonal Left/Down
		}//End Evaluate Combinations


		public function hoverBoardPiece(event:MouseEvent){
					var row:int = event.currentTarget.Row;
					var column:int = event.currentTarget.Column;
					//ADD MARKERS TO SHOW WHAT WAS FLIPPED
					placeHoverFlipCheckMarker(row,column);
			
		}//End HOVER
		
		public function removehoverBoardPiece(event:MouseEvent){
					//REMOVE OLD FLIP CHECK MARKERS
					removeHoverFlipCheckMarker();
		}//End REMOVEHOVER
		
		
		
		//FUNCTION TO ADD FLIPPED CHECKING MARKER
		public function placeHoverFlipCheckMarker(row:int,column:int){
			if (gameHoverHintsEnabled == true){
				var v;
				v = gameFieldList[row][column].flipList;
	
				//cycle through the fliplist of this tile and add markers to all the pieces that are listed as to flip
				for (var i:int = 0; i <= v.length-1; i++){
					var u = v[i]; //get the flippable piece at this position
					//check if a hint already is placed at this position, if not, place it.
					if (u.flipHoverCheck == undefined){
						var gamepieceHoverFlipCheck:GamepieceHoverFlipCheck = new GamepieceHoverFlipCheck();
						gamepieceHoverFlipCheck.x = u.x;
						gamepieceHoverFlipCheck.y = u.y;
						gamepieceHoverFlipCheck.mouseEnabled = false;
						u.flipHoverCheck = gamepieceHoverFlipCheck;
						addChild(gamepieceHoverFlipCheck);
					}
				}
			}
		}//END placeFlipCheckMarker
		
		//FUNTION TO REMOVE CHECKING MARKERS AFTER A NEW CLICK HAS BEEN MADE
		public function removeHoverFlipCheckMarker():void{
			if (gameHoverHintsEnabled == true){
				for (var i:int = 0; i < boardWidth; i++){
					for (var j:int = 0; j < boardHeight; j++){
						if (gameFieldList[i][j].flipHoverCheck == undefined) {
							} else {
							removeChild (gameFieldList[i][j].flipHoverCheck);
							delete gameFieldList[i][j].flipHoverCheck;
						}
					}
				}
			}
		}//END removeFlipCheckMarker
		
	}//END CLASS
}//END PACKAGE
		