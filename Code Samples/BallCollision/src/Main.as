package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Main extends Sprite 
	{
		
		private var circle1:Sprite = new Sprite;		
		private var c1v:Point = new Point(122, -1);
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			generateCircles();
			
			addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		private var collisionList:Array = new Array();
		private function generateCircles():void
		{
			circle1.graphics.beginFill(0x00000);
			circle1.graphics.lineStyle(1, 0x000000);
			circle1.graphics.drawCircle(0, 0, 10);
			circle1.x = 150;
			circle1.y = 250;
			stage.addChild(circle1);
			
			var obstacles:Sprite;
			
			for (var i:int = 0; i < 1; i++) {
				for (var j:int = 0; j < 1; j++) {
					obstacles = new Sprite();
					obstacles.graphics.lineStyle(1, 0x000000);
					obstacles.graphics.drawCircle(0, 0, 40);
					obstacles.x = 75+i*150;
					obstacles.y = 75+j*150;
					collisionList.push(obstacles);
					stage.addChild(obstacles);
			
				}
			}
		}
		
		private function makeCircle(location:Point, color:uint):void
		{
			var circle:Sprite = new Sprite();
			circle.x = location.x;
			circle.y = location.y;
			circle.graphics.lineStyle(1, color);
			circle.graphics.drawCircle(0, 0, 5);
			stage.addChild(circle);
		}
		
		private function loop(e:Event):void
		{
			circle1.x += c1v.x;
			circle1.y += c1v.y;
		
			for (var i:int = collisionList.length-1; i >= 0; i--){
				
				collision(collisionList[i]);
				
			}
			//Collide with boundaries
			if (circle1.x > stage.stageWidth)
			{
				circle1.x = stage.stageWidth;
				c1v.x *= -1;

				//circle1.x = 0;
			}
			if (circle1.x < 0)
			{
				circle1.x = 0;
				c1v.x *= -1;

				//circle1.x = stage.stageWidth;
			}
			if (circle1.y > stage.stageHeight)
			{
				circle1.y = stage.stageHeight;
				c1v.y *= -1;

				//circle1.y = 0;
			}
			if (circle1.y < 0)
			{
				circle1.y = 0;
				c1v.y *= -1;

				//circle1.y = stage.stageHeight;
			}
		}
		
		private function collision(collObj:Sprite):void
		{
			var collisionPoint:Point = checkCollision(circle1,collObj,c1v);
				
				//Distance between movement vector to collision point
				var distanceVector:Point = new Point(collisionPoint.x - circle1.x, collisionPoint.y - circle1.y);
				
				//If length of movement vector to collision point is less than the length of movement vector, and the collision object
				//and movement vector have the same direction (dorProduct>0), we collide and se the new point to the collision point!
				//Ensures only the intersection points in the possible distance moved during this cycle is considered!
				if (vLength(distanceVector) < vLength(c1v))
				{
					circle1.x = collisionPoint.x;
					circle1.y = collisionPoint.y;
					reflection(circle1,collObj,c1v);
				}
		}
		
		/********************************************************************************
		 * Reflect the moving ball on the object
		 * 	Project onto the vectors between centers, and reverse the vector.
		 * 	project onto normal of said vector.
		 * 	New direction vector is first projection+second projection.
		 * 
		 * @param object 1:Sprite, object 2 to be reflected against:Sprite, movement vector of object 1:Point
		 * 
		 ********************************************************************************/
		
		private function reflection(object1:Sprite, object2:Sprite, movementVector:Point):void
		{
			var vc:Point = new Point(object2.x - object1.x, object2.y - object1.y);
			var centerProjection = vProjection(movementVector, vc);
			var normalProjection = vProjection(movementVector, new Point(vc.y* -1, vc.x ));
			
			movementVector.x = -1*centerProjection.x+normalProjection.x;
			movementVector.y = -1*centerProjection.y+normalProjection.y;
		}
		
		/********************************************************************************
		 * Finds the collision point between two objects.
		 * 
		 * @param object 1:Sprite, object 2 to be collided against:Sprite, movement vector of object 1:Point
		 * 
		 * @return ColllisionPoint:Point
		 ********************************************************************************/
		private function checkCollision(object1:Sprite, object2:Sprite, movementVector:Point):Point
		{
			//Find P3
			//Project V c1center->c2center onto Vx to get P2
			var vCenters:Point = new Point(object2.x - object1.x, object2.y - object1.y);
			
			var vP:Point = vProjection(vCenters, movementVector);
			
			//get p2 moving the projection to the location
			var p2:Point = new Point (circle1.x + vP.x, circle1.y + vP.y);
			
		
			//Move back along original movement vector from P2 to P3 by b = sqrt(c*c - a*a);
			var a:Number = vLength(new Point(object2.x - p2.x , object2.y - p2.y));
			var c:Number = circle1.width / 2 + object2.width / 2;
			var b:Number = Math.sqrt(Math.pow(c, 2) - Math.pow(a, 2));
			
			//Find the point shifting p2 backwards along movementVector by b * movementVector unit vector
			var movementVectorUnit:Point = vUnit(movementVector);
			var p3:Point = new Point(p2.x - b * movementVectorUnit.x, p2.y - b * movementVectorUnit.y);
			

			/*///GRAPHICAL GIMMICKS
			makeCircle(p2, 0xFF0000);
			makeCircle(p3, 0xFF00FF);
			
			
			//projected line
			var projectionOnv2ofv1:Sprite = new Sprite();
			projectionOnv2ofv1.graphics.lineStyle(2,0x00FF00);
			projectionOnv2ofv1.graphics.moveTo(object1.x,object1.y);
			projectionOnv2ofv1.graphics.lineTo(p2.x,p2.y);
			addChild(projectionOnv2ofv1);
			
			//cv1 lines
			var linev1:Sprite = new Sprite();
			linev1.graphics.lineStyle(2,0x0000FF);
			linev1.graphics.moveTo(object1.x,object1.y);
			linev1.graphics.lineTo(object1.x+movementVector.x,object1.y+movementVector.y);
			addChild(linev1);
			
			//vCenters lines
			linev1.graphics.lineStyle(1,0xFF00FF);
			linev1.graphics.moveTo(object1.x,object1.y);
			linev1.graphics.lineTo(object1.x+vCenters.x,object1.y+vCenters.y);
			addChild(linev1);
			
			//C2 -> P2 on movementVector lines
			var linev2:Sprite = new Sprite();
			linev2.graphics.lineStyle(1,0xFF0000);
			linev2.graphics.moveTo(object2.x,object2.y);
			linev2.graphics.lineTo(p2.x,p2.y);
			addChild(linev2);
			
			//anglebetweenVector 1 and 2
			
			var angle1:Number = Math.atan2(object2.y - p2.y, object2.x - p2.x);
			var angle2:Number = Math.atan2(object1.y - object2.y, object1.x - object2.x);
			trace('angle v1 v2', 180 - (angle1 * 180 / Math.PI - angle2 * 180 / Math.PI));
			
			//anglebetweenVector 1 and projection normal
			
			angle1 = Math.atan2(object2.y - p2.y, object2.x - p2.x);
			angle2 = Math.atan2(object1.y - p2.y, object1.x - p2.x);
			trace('angle v1 v2p', 180 - (angle1 * 180 / Math.PI - angle2 * 180 / Math.PI));
		*/
			
			return p3;
			
		}
		
		/********************************************************************************
		 * Find the projection vector of v onto u
		 * 
		 * @param source vector, target vector to be projected onto:Point
		 * 
		 * @return ColllisionPoint:Point
		 ********************************************************************************/
		private function vProjection(v:Point, u:Point):Point
		{
			var Vprojection:Point = new Point();
			
			var uU:Point = vUnit(u);
			
			var dotP:Number = dotProduct(uU, v);
			
			Vprojection.x = dotP * uU.x;
			Vprojection.y = dotP * uU.y;

			return Vprojection;
		}
		
		
		/********************************************************************************
		 * Calculates the unit vector of v
		 * 
		 * @param vector:Point
		 * 
		 * @return Unit Vector of v:Point
		 ********************************************************************************/
		private function vUnit(v:Point):Point
		{
			var uV:Point = new Point();
			uV.x = v.x / vLength(v);
			uV.y = v.y / vLength(v);
			return uV;
		}
		
		/********************************************************************************
		 * Calculates the length of a vector v
		 * 
		 * @param vector:Point
		 * 
		 * @return length of vector:Number
		 ********************************************************************************/
		private function vLength(v:Point):Number
		{
			var length:Number
			length = Math.sqrt(v.x * v.x + v.y * v.y);
			return length;
		}
		
		/********************************************************************************
		 * Calculate the dot product of a vector
		 * positive value means vectors pointed same direction.
		 * 
		 * @param vector 1 and vector 2:Point
		 * 
		 * @return dotProduct:Number
		 ********************************************************************************/
		private function dotProduct(v1:Point, v2:Point):Number
		{
			var dotProduct:Number;
			dotProduct = v1.x * v2.x + v1.y * v2.y;
			return dotProduct;
		}
	}
	
}