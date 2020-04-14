
// Simplified Diffuse shader. Differences from regular Diffuse one:
// - no Main Color
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.

Shader "Hortor/Diffuse(Support foldUV)" {
Properties {
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _DummyTex0("Base (RGB)", 2D) = "white" {}
    _DummyTex1("Base (RGB)", 2D) = "white" {}
}
SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 150

CGPROGRAM
#pragma surface surf Lambert noforwardadd

sampler2D _MainTex;

struct Input {
    float2 uv_MainTex;
    float2 uv3_DummyTex0;
    float2 uv4_DummyTex1;
};

void surf (Input IN, inout SurfaceOutput o) {
	float2 coord = frac(IN.uv_MainTex) * IN.uv4_DummyTex1 + IN.uv3_DummyTex0;
    fixed4 c = tex2D(_MainTex, coord);
    o.Albedo = c.rgb;
    o.Alpha = c.a;
}
ENDCG
}

Fallback "Mobile/VertexLit"
}
