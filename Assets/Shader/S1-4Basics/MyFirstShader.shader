Shader "Holistic/HelloShader" {

	Properties {
		_myColour ("Example Colour", Color) = (1,1,1,1)
		_myEmission ("Example Emission", Color) = (0,0,0,0)
		_myNormal ("Example Normal", Color) = (0,0,0,0)
	}

	SubShader{

		CGPROGRAM
			// declare the type of shader to be a surface shader, 
			// the method name will be "surf" and
			// the Lighting model will be Lambert
			#pragma surface surf Lambert 

			struct Input {
				float2 uvMainTex;
			};

			fixed4 _myColour;
			fixed4 _myEmission;
			fixed4 _myNormal;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _myColour.rgb;
				o.Emission = _myEmission.rgb;
				o.Normal = _myNormal.rgb;
			}


		ENDCG
	}

	FallBack "Diffuse"
}