/*
A Class containing all the basic vector mathematical functions for 2d vectors
Because we use only 2d vectors, we will represent them within the class as points.
We expect them to be passed in as points as well.

*/

package{
	dynamic public class Vectors {
		
		import flash.geom.Point;

		public function Vectors(){
		}
		
		public function VectorSum(vector1,vector2){
			var newVector:Point = new Point();
			newVector.x = vector1.x + vector2.x;
			newVector.y = vector1.y + vector2.y;
			return(newVector);
		}
		
		public function DotProduct(vector1,vector2){
			var newVector;
			newVector = vector1.x * vector2.x + vector1.y * vector2.y;
			return(newVector);
		}
		
		//vector lenght
		public function Length(vector){
			var newVector;
			newVector = Math.sqrt(vector.x*vector.x+vector.y*vector.y);
			return(newVector);
		}
		
		//vector movement position
		public function RotMovePosition(point,vector){
			var newVector:Object = new Object();
			
			newVector.x = Math.cos(convertToRad(point.rotation));
			newVector.y = Math.sin(convertToRad(point.rotation));
			
			point.x += newVector.x*vector;
			point.y += newVector.y*vector;
			
			return(point);
		}
		
		
		//vector angle
		public function Angle(vector){
			var rotation =  convertToDeg(Math.atan2(vector.y,vector.x));
			return(rotation);
		}
		
		public function convertToRad(degree){
			var rad  = Math.PI*degree/180;
			return(rad);
		}
		public function convertToDeg(rad){
			var degree  = 180*rad/Math.PI;
			return(degree);
		}
		
		
		/*public function CrossProduct(vector1,vector2){
			var vectorCross:Point = new Point();
			
			//on a 2d vector
			// [x1]   [x2]   [y1-z2]
			// [y1] X [y2] = [z1-x2]
			// [z1]   [z2]   [x1-y2]
			
			
			vectorCross.x = vector1.x + vector2.x;
			vectorCross.y = vector1.y + vector2.y;
			vectorCross.z = vector1.z + vector2.z;
			
			return (vectorCross);
		}*/
	}
}