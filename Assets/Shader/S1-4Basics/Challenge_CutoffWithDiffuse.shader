Shader "Holistic/Challenge_CutoffWithDiffuse"
{
    Properties
    {
		_Tex("Main Texture", 2D) = "white" {}
		_RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
		_RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
		_StripeSize ("Stripe Size", Range(0.5, 50)) = 10
    }
    SubShader
    {
        CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float2 uv_Tex;
			float3 viewDir;
			float3 worldPos;
		};

		sampler2D _Tex;
		float4 _RimColor;
		float _RimPower;
		float _StripeSize;

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_Tex, IN.uv_Tex);
			// saturate converts a range from -1,1 to 0,1
			half rim = saturate(dot(normalize(IN.viewDir), o.Normal));
			rim = 1 - rim; // invert 
			//o.Emission = rim > 0.65 ? float3(1,0,0) : rim > 0.45 ? float3(0, 1, 0) : rim > 0.25 ? float3(0, 0, 1) : 0;
			o.Emission = rim * (frac(IN.worldPos.y * _StripeSize * 0.5) > 0.4 ? float3(0, .5, 0) : float3(.5, 0, 0));
		}

        ENDCG
    }
    FallBack "Diffuse"
}
