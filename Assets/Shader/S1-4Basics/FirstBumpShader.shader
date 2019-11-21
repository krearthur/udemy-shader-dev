Shader "Holistic/FirstBumpShader"
{
    Properties
    {
		_myDiffuse ("Diffuse Texture", 2D) = "white" {}
		_myBump ("Normal Map", 2D) = "bump" {}
		_mySlider ("Bump Amount", Range(0,10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

		sampler2D _myDiffuse;
		sampler2D _myBump;
		half _mySlider;

        struct Input
        {
			float2 uv_myDiffuse;
			float2 uv_myBump;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
			o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
			o.Normal *= float3(_mySlider, _mySlider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
