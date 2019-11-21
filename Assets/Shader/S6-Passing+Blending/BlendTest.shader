Shader "Holistic/6/BlendTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

		//Blend One One // just add the colors together
		//Blend SrcAlpha OneMinusSrcAlpha // blend alpha -> default transparency method
		// Blend (Color of pixel output of this shader * DstColor) + (Color of pixel already on screen * zero)
		Blend DstColor Zero

		// We don't even need CGPROGRAM, which is just a special form of "Pass"
		// so we define a very simple Pass here. Remember, pass is a draw call.
		Pass {
			SetTexture [_MainTex] { combine texture }
		}
    }
    FallBack "Diffuse"
}
