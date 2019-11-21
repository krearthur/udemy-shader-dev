Shader "Holistic/8/Extrude"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Amount ("Extrude", Range(-1, 1)) = 0.01
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert
            #pragma target 3.0

            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            struct appdata {
                float4 vertex: POSITION;
                float3 normal: NORMAL;
                float4 texcoord: TEXCOORD0;
                float4 texcoord1: TEXCOORD1;
                float4 texcoord2: TEXCOORD2;
            };

            float _Amount;

            void vert(inout appdata v) {
                v.vertex.xyz += v.normal * _Amount ;//* sin(_Time.w);
            }

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
