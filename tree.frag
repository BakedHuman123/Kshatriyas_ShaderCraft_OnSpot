#define S(a, b, t) smoothstep(a,b,t)

float TaperBox(vec2 p, float wb, float wt, float yb, float yt, float blur) {
    float m = S(-blur, blur, p.y - yb);
    m *= S(blur, -blur, p.y - yt);

    p.x = abs(p.x);

    // 0 p.y=yb, 1 p.y=yt
    float w = mix(wb, wt, (p.y - yb) / (yt - yb));
    m *= S(blur, -blur, p.x - w);

    return m;
}
vec4 Tree(vec2 uv, vec3 col, float blur) {
    float m = TaperBox(uv, .03, .03, 0., .25, blur);  // trunk
    m += TaperBox(uv, .2, .1, .25, .5, blur);         // canopy 1
    m += TaperBox(uv, .15, .05, .5, .75, blur);       // canopy 2
    m += TaperBox(uv, .1,  0., .75, 1., blur);        // top

    float shadow = TaperBox(uv-vec2(.2,0), .1, .5, .15, .25, blur);
    shadow += TaperBox(uv+vec2(.25,0), .1, .5, .45, .5, blur);
    shadow += TaperBox(uv-vec2(.25,0), .1, .5, .7, .75, blur);
    
    col -= shadow;
    //m = 1.;
    return vec4(col, m);
}
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    uv.y += .5;

    vec4 col = vec4(0);

    float blur = .005;

    vec4 tree = Tree(uv, vec3(1), blur);

    col = mix(col, tree, tree.a);

    float thickness = 1. / iResolution.y;

    // if (abs(uv.x) < thickness) col.g = 1.;
    // if (abs(uv.y) < thickness) col.r = 1.;

    fragColor = col;
}


