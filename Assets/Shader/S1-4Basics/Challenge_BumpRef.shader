Shader "Challenge/BumpRef"
{
	Properties{
		_myBump("Bump Texture", 2D) = "bump" {}
		_myCube("Cube Map", CUBE) = "white" {}
		_normalScale("Normal Brightnes", Range(0,2)) = 0.3 
	}
		SubShader{

		  CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myBump;
			samplerCUBE _myCube;
			half _normalScale;

			struct Input {
				float2 uv_myBump;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf(Input IN, inout SurfaceOutput o) {
				o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) ;
				o.Normal *= _normalScale;
				o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;

			}

		  ENDCG
		}
		Fallback "Diffuse"
}
