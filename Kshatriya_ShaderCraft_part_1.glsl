#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){

    vec2 st = gl_FragCoord.xy/u_resolution;

    vec3 backgroundColor = vec3(0.9, 0.95, 1.0); // Light background color
    vec3 riverColor = vec3(0.2, 0.4, 0.6); // River color
    vec3 treeColor = vec3(0.1, 0.2, 0.3); // Tree color
    vec3 mountainColor = vec3(0.7, 0.8, 0.9);
    vec3 treestem = vec3(0.01, 0.13, 0.26);
    vec3 leaf = vec3(0.03, 0.35, 0.6);

    float frequency = 3.0;
    float amplitude = 0.1;
    float offset = 0.5;

    float x = amplitude * sin (st.y * frequency * 2.0 * 3.14159) + offset;
    
    float waveLineWidth = abs(0.6-st.y); // Thickness of the sine wave
    float distanceToWave = abs(st.x - x); // Distance from the fragment to the sine wave
	vec3 wavecolor = riverColor;

    vec3 color = backgroundColor;
    float alpha = smoothstep(0.0, waveLineWidth, waveLineWidth - distanceToWave);
    if (st.y < 0.6 ) {
        color = mix(backgroundColor, wavecolor, alpha);
    }

    if(st.y - 0.7 < (-0.75)*st.x + 0.2 && st.y - 0.69 > (-0.75)*st.x - 0.1 && st.y < 0.905 && st.y > 0.595){
        color = mountainColor;
    }
    if(st.y - 0.7 <= 0.5*st.x - 0.3 && st.y - 0.69 >= 0.5*st.x - 0.6&& st.y < 0.905 && st.y > 0.595){
        color = mountainColor;
    }
    if(st.y > 0.6 && st.y < 0.9 && st.x > 0.0 && st.x < 0.05){
        color = treestem;
    }
    if(st.y > 0.65 && st.y < 0.85 && st.x > 0.19 && st.x < 0.24){
        color = treestem;
    }
    if(st.y > 0.7 && st.y < 0.8 && st.x > 0.38 && st.x < 0.43){
        color = treestem;
    }
    if(st.y > 0.6 && st.y < 0.9 && st.x > 0.95 && st.x < 1.0){
        color = treestem;
    }
    if(st.y > 0.65 && st.y < 0.85 && st.x > 0.76 && st.x < 0.81){
        color = treestem;
    }
    if(st.y > 0.7 && st.y < 0.8 && st.x > 0.57 && st.x < 0.62){
        color = treestem;
    }
    if(st.x > st.y-0.9 && st.x - 0.1 < st.y-0.9 && st.x >-0.1 && st.x <= 0.05){
        color = leaf;
    }
    if(-1.0*st.x > st.y-1.0 && -1.0*st.x - 0.1 < st.y-1.0 && st.x >0.05 && st.x < 0.1){
        color = leaf;
    }
    if(st.x > st.y-0.7 && st.x - 0.1 < st.y-0.7 && st.x >0.15 && st.x <= 0.225){
        color = leaf;
    }
    if(-1.0*st.x > st.y-1.15 && -1.0*st.x - 0.1 < st.y-1.15 && st.x >0.225 && st.x < 0.3){
        color = leaf;
    }
    gl_FragColor = vec4(color, 1.0);
}