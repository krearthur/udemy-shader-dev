Shader "Holistic/8/UVScroll"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Tint ("Colour Tint", Color) = (1, 1, 1, 1)
        _ScrollX ("Scroll X", Range(-5,5)) = 1
        _ScrollY ("Scroll Y", Range(-5,5)) = 1
        _Speed ("Speed", Range(0,2)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float4 _Tint;
        float _ScrollX;
        float _ScrollY;
        float _Speed;

        struct Input {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            float2 newUV = IN.uv_MainTex + float2(_ScrollX, _ScrollY) * _Speed * _Time;
            o.Albedo = tex2D (_MainTex, newUV) * _Tint;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
