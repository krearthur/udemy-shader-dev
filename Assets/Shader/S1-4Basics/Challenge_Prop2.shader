﻿Shader "Holistic/GreenShader"
{
    Properties
    {
        _Tex ("Texture (RGB)", 2D) = "white" {}
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
		sampler2D _Tex;

		// Define what input structs (like world positions, screen position, etc.) 
		// we want to have access to 
        struct Input
        {
            float2 uv_Tex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
			half4 albedo = tex2D(_Tex, IN.uv_Tex);
			albedo.g = 0.4;
			o.Albedo = albedo.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
