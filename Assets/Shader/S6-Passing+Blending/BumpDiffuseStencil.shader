Shader "Holistic/6/BumpDiffuseStencil"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
		_myBump("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,10)) = 1

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]	_SComp("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]			_SOp("Stencil Op", Float) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

		Stencil
		{
			Ref[_SRef]
			Comp[_SComp]
			Pass[_SOp]
		}

        CGPROGRAM
        #pragma surface surf Lambert 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _myDiffuse;
		sampler2D _myBump;
		half _mySlider;
		float4 _Color;

        struct Input
        {
            float2 uv_myDiffuse;
			float2 uv_myBump;
        };


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb * _Color.rgb;
			o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
			o.Normal *= float3(_mySlider, _mySlider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
