Shader "Holistic/DotProduct"
{
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        struct Input
        {
            float2 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			half dotp = dot(normalize(IN.viewDir), o.Normal);
			if (dotp > 0.1) {
				dotp = 1;
			}
			else {
				dotp = 0.1;
			}
			o.Albedo.gb = float2(dotp, 0);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
