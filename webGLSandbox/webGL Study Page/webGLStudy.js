$(function(){ 
	var canvas = document.getElementById("webGLCanvas");
	var width = $(canvas).width();
	canvas.width = width;
	
	initGL(webGLCanvas);

	gl.clearColor(0.0, 0.0, 0.0, 1.0);
	gl.enable(gl.DEPTH_TEST);

	drawScene();
	}