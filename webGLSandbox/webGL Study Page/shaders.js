[{"fragment": "#version 100\n#ifdef GL_ES\nprecision highp int;\nprecision highp float;\nprecision highp vec2;\nprecision highp vec3;\nprecision highp vec4;\nprecision highp ivec2;\nprecision highp ivec3;\nprecision highp ivec4;\n#endif\n#line 7 0\nvoid main(){\n#line 8 0\ngl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n#line 9 0\n}\n", "path": "/Users/levantulee/Documents/webGL Study Page/simplest.shader", "vertex": "#version 100\n#ifdef GL_ES\nprecision highp int;\nprecision highp float;\nprecision highp vec2;\nprecision highp vec3;\nprecision highp vec4;\nprecision highp ivec2;\nprecision highp ivec3;\nprecision highp ivec4;\n#endif\n#line 1 0\nattribute vec3 position;\n#line 2 0\nvoid main(){\n#line 3 0\ngl_Position = vec4(position, 1.0);\n#line 4 0\n}\n", "lines": ["vertex:", "    attribute vec3 position;", "    void main(){", "        gl_Position = vec4(position, 1.0);", "    }", "", "fragment:", "    void main(){", "        gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);", "    }", ""], "name": "simplest"}]