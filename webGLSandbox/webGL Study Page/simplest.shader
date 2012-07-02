vertex:
    attribute vec3 position;
    void main(){
        gl_Position = vec4(position, 1.0);
    }

fragment:
    void main(){
        gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);
    }
