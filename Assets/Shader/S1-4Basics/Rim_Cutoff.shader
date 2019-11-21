Shader "Holistic/Rim_Cutoff"
{
    Properties
    {
		_RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
		_RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }
    SubShader
    {
        CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float3 viewDir;
			float3 worldPos;
		};

		float4 _RimColor;
		float _RimPower;

		void surf(Input IN, inout SurfaceOutput o) {
			// saturate converts a range from -1,1 to 0,1
			half rim = saturate(dot(normalize(IN.viewDir), o.Normal));
			rim = 1 - rim; // invert 
			//o.Emission = rim > 0.65 ? float3(1,0,0) : rim > 0.45 ? float3(0, 1, 0) : rim > 0.25 ? float3(0, 0, 1) : 0;
			o.Emission = rim * (frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? float3(0, 1, 0) : float3(1, 0, 0));
		}

        ENDCG
    }
    FallBack "Diffuse"
}
