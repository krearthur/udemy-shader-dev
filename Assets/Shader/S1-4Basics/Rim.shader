Shader "Holistic/Rim"
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
		};

		float4 _RimColor;
		float _RimPower;

		void surf(Input IN, inout SurfaceOutput o) {
			// saturate converts a range from -1,1 to 0,1
			half rim = saturate(dot(normalize(IN.viewDir), o.Normal));
			rim = 1 - rim;

			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
		}

        ENDCG
    }
    FallBack "Diffuse"
}
