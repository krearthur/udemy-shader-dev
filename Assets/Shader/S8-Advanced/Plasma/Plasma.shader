Shader "Holistic/8/Plasma"
{
    Properties
    {
        _Tint("Color Tint", Color) = (1, 1, 1, 1)
        _Speed("Speed", Range(1, 100)) = 10
        _Scale1("Scale 1", Range(0.1, 10)) = 2
        _Scale2("Scale 2", Range(0.1, 10)) = 2
        _Scale3("Scale 3", Range(0.1, 10)) = 2
        _Scale4("Scale 4", Range(0.1, 10)) = 2
    }
    SubShader
    {

        CGPROGRAM
        
        #pragma surface surf Lambert
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        float4 _Tint;
        float _Speed;
        float _Scale1;
        float _Scale2;
        float _Scale3;
        float _Scale4;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            const float PI = 3.14159265;
            float t = _Time.x * _Speed;

            // vertical
            float c = sin(IN.worldPos.x * _Scale1 + t);

            // horizontal
            c += sin(IN.worldPos.z * _Scale2 + t);

            // diagonal
            c += sin(_Scale3 * (IN.worldPos.x * sin(t / 2) + IN.worldPos.z * cos(t/3)) + t);

            // circular
            float c1 = pow(IN.worldPos.x + 0.5 * sin(t/5), 2);
            float c2 = pow(IN.worldPos.z + 0.5 * cos(t/3), 2);
            c += sin(sqrt(_Scale4 * (c1 + c2) + 1 + t));

            o.Albedo.r = sin(c / 4.0 * PI);
            o.Albedo.g = sin(c / 4.0 * PI + 2*PI/4);
            o.Albedo.b = sin(c / 4.0 * PI + 4*PI/4);
            o.Albedo *= _Tint;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
