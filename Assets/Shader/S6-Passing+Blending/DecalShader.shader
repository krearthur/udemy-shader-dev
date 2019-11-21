Shader "Holistic/6/Decal"
{
    Properties
    {
		_MainTex("Texture", 2D) = "black" {}
		_DecalTex("Decal Texture", 2D) = "black" {}
		[Toggle] _ShowDecal("Show Decal?", Float) = 0
    }
    SubShader  
    {
        Tags { "Queue"="Transparent" }

		Blend SrcAlpha OneMinusSrcAlpha

		Cull Off

		CGPROGRAM // this is one "pass", the main pass, means one draw call
		#pragma surface surf Lambert 

		struct Input
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;
		sampler2D _DecalTex;
		float _ShowDecal;

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;
			o.Albedo = b.r > 0 ? b.rgb : a.rgb;
		}
		ENDCG
    }
    FallBack "Diffuse"
}
