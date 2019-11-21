Shader "Holistic/8/Waves"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white" {}
        _DetailTex ("Detail", 2D) = "white" {}
        _Tint ("Colour Tint", Color) = (1, 1, 1, 1)
        _ScrollX ("Scroll X", Range(-5,5)) = 1
        _ScrollY ("Scroll Y", Range(-5,5)) = 1
        _Freq ("Frequency", Range(0, 5)) = 3
        _Speed ("Speed", Range(0,100)) = 0.5
        _ScrollSpeed ("Scroll Speed", Range(0,2)) = 0.6
        _Amp("Amplitude", Range(0,1)) = 0.5
    }
    SubShader
    {
        Cull Off
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DetailTex;
            float3 vertColor;
        };

        float4 _Tint;
        float _Freq;
        float _Speed;
        float _ScrollSpeed;
        float _Amp;
        float _ScrollX;
        float _ScrollY;

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        sampler2D _MainTex;
        sampler2D _DetailTex;

        void vert (inout appdata v, out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input, o); // init o to type <Input> to value=0
            float t = _Time * _Speed;
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + 
                sin(t*2 + v.vertex.z * _Freq) * _Amp;
            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = _Tint * (waveHeight + 1);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            float2 newMainUV = IN.uv_MainTex + float2(_ScrollX, _ScrollY) * _ScrollSpeed * _Time;
            float2 newDetailUV = IN.uv_DetailTex + float2(_ScrollX, _ScrollY) * _ScrollSpeed*1.3 * _Time;

            float4 mainTex = tex2D(_MainTex, newMainUV);
            float4 detailTex = tex2D(_DetailTex, newDetailUV);

            o.Albedo = (mainTex + detailTex) * IN.vertColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
