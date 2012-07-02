$(function(){
	console.log('hello');
	//Cavas Reference
	var canvas = $('canvas');//uses $jQuery command to find element of ID
	var width = canvas.width(), height = canvas.height();//Set with and height
	canvas[0].width = width;
	canvas[0].height = height;
	
	//Init webGL
	var gl = canvas[0].getContext('experimental-webgl');
	gl = WebGLDebugUtils.makeDebugContext(gl, function(err, name, args){
        throw 'function: ' + name + ' ' + WebGLDebugUtils.glEnumToString(err);
    });
    
    //Clear canvas in red
	gl.clearColor(1, 0, 0, 1);
	gl.clear(gl.COLOR_BUFFER_BIT);
	
	//new buffer for vertex InfoSoft
	var meshVertexbuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, meshVertexbuffer);
	
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([
			//Front
			0.0,  1.0,  0.0,
			-1.0, -1.0,  1.0,
			1.0, -1.0,  1.0,
			//Right
			0.0,  1.0,  0.0,
			1.0, -1.0,  1.0,
			1.0, -1.0,  -1.0,
			//Back
			0.0,  1.0,  0.0,
			1.0, -1.0,  -1.0,
			-1.0, -1.0,  -1.0,
			//Left
			0.0,  1.0,  0.0,
			-1.0, -1.0,  -1.0,
			-1.0, -1.0,  1.0,
			
        ]), gl.STATIC_DRAW);
    
    
        
	//shader source holen, shader objekte machen, source attachen, compilen, linken, use
	var shadersJS = [{"fragment": "#version 100\n#ifdef GL_ES\nprecision highp int;\nprecision highp float;\nprecision highp vec2;\nprecision highp vec3;\nprecision highp vec4;\nprecision highp ivec2;\nprecision highp ivec3;\nprecision highp ivec4;\n#endif\n#line 7 0\nvoid main(){\n#line 8 0\ngl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n#line 9 0\n}\n", "path": "/Users/levantulee/Documents/webGL Study Page/simplest.shader", "vertex": "#version 100\n#ifdef GL_ES\nprecision highp int;\nprecision highp float;\nprecision highp vec2;\nprecision highp vec3;\nprecision highp vec4;\nprecision highp ivec2;\nprecision highp ivec3;\nprecision highp ivec4;\n#endif\n#line 1 0\nattribute vec3 position;\n#line 2 0\nvoid main(){\n#line 3 0\ngl_Position = vec4(position, 1.0);\n#line 4 0\n}\n", "lines": ["vertex:", "    attribute vec3 position;", "    void main(){", "        gl_Position = vec4(position, 1.0);", "    }", "", "fragment:", "    void main(){", "        gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);", "    }", ""], "name": "simplest"}];
	//$.getJSON(shaderJS, function(shaders){ 
	var shadersInit = function(shaders){
		var program = gl.createProgram();
		var vs = gl.createShader(gl.VERTEX_SHADER);
		var fs = gl.createShader(gl.FRAGMENT_SHADER);
		gl.attachShader(program, vs); gl.attachShader(program, fs);
		compile(vs, shaders[0].vertex);
		compile(fs, shaders[0].fragment);
		gl.linkProgram(program);
		if(!gl.getProgramParameter(program, gl.LINK_STATUS)){
			throw gl.getProgramInfoLog(program);
		}
		gl.useProgram(program);
		var position_loc = gl.getAttribLocation(program, 'position');
		gl.enableVertexAttribArray(position_loc);
		gl.vertexAttribPointer(position_loc, 3, gl.FLOAT, false, 0, 0);
		gl.drawArrays(gl.TRIANGLES, 0, 3);
	};
	//});
		
	var compile = function(shader, source){
		gl.shaderSource(shader, source);
		gl.compileShader(shader);
		if(!gl.getShaderParameter(shader, gl.COMPILE_STATUS)){
			throw gl.getShaderInfoLog(shader);
		}
	};

	shadersInit(shadersJS);
	
	/*
	function mouseMove(einEvent)  {
		if(g_bMousedown== true)    {
			g_fAnimationYAngle+=(einEvent.clientX-g_lastpoint.x);
			g_fAnimationXAngle+=(einEvent.clientY-g_lastpoint.y);
			//drawScene();
		}  
	
		g_lastpoint.x=einEvent.clientX;
		g_lastpoint.y=einEvent.clientY;
	}
	
	function mouseDown(einEvent)   {
		g_bMousedown=true;
		g_DrawInterval = setInterval(drawScene,40);
	}
	
	function mouseUp(einEvent)   {
		g_bMousedown=false;
		clearInterval(g_DrawInterval);
	}
	*/
	 
 });