Shader "Holistic/Custom_BlinnPhong"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf CustomBlinnPhong

		// --- Custom Lighting Function --- 
		half4 LightingCustomBlinnPhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
			half3 h = normalize(lightDir + viewDir);

			fixed3 nN = normalize(s.Normal);
			half diff = max(0, dot(nN, lightDir));
			float nh = max(0, dot(nN, h));
			float spec = pow(nh, 48.0);

			half4 c;
			//c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime*3;
			c.a = s.Alpha;
			return c;
		}

		float4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
