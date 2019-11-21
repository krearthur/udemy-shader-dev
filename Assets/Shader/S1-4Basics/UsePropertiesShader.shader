Shader "Holistic/UsePropertiesShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
		_Range ("Range", Range(0,5)) = 1
        _Tex ("Texture (RGB)", 2D) = "white" {}
        _Cube ("Cube", CUBE) = "" {}
		_Float ("Float", Float) = 0.5
		_Vector ("Vector", Vector) = (0.5, 1, 1, 1)
    }
    SubShader
    {

        CGPROGRAM
        // lambert=non physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
		
		// Map Propterties to internal variables of CGProgram
		// the names have to match exactly!
        fixed4 _Color;
		half _Range;
		sampler2D _Tex;
		samplerCUBE _Cube;
		float _Float;
		float4 _Vector;

		// Define what input structs (like world positions, screen position, etc.) 
		// we want to have access to 
        struct Input
        {
            float2 uv_Tex;
			float3 worldRefl;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = (tex2D(_Tex, IN.uv_Tex) * _Range * _Color).rgb;
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
