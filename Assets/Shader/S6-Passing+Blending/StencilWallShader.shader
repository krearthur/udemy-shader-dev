Shader "Holistic/6/StencilWall"
{
    Properties
    {
        _Color("Main Color", Color) = (1,1,1,1)

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2
    }
    SubShader
    {
        Tags { "Queue" = "Geometry-1" }
        LOD 200

		ColorMask 0
		ZWrite off

		Stencil
		{
			Ref[_SRef]
			Comp[_SComp] // comparison method
			Pass[_SOp]
		}

        CGPROGRAM
        #pragma surface surf Lambert
        #pragma target 3.0

        sampler2D _myDiffuse;

        struct Input
        {
            float2 uv_myDiffuse;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
