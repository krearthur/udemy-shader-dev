Shader "Holistic/BasicBlinnPhong"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_SpecColor("Spec Color", Color) = (1,1,1,1)
		_SpecSize("Specular Size", Range(0,1)) = 0.5
		_Gloss("Gloss", Range(0,1)) = 0.5
	}
		SubShader
	{
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf BlinnPhong

		float4 _Color;
		half _SpecSize;
		fixed _Gloss;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
			o.Specular = _SpecSize;
			o.Gloss = _Gloss;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
