Shader "Holistic/7/ColorVF"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float4 color: COLOR; 
            };

			half FTR(float f, float r)
			{
				return (f * 2 + r) / (r * 2);
			}

            v2f vert (appdata v)
            {
                v2f o; // means output. the output for the fragment shader
                o.vertex = UnityObjectToClipPos(v.vertex); // world positions
				o.color.rgb = FTR(v.vertex.x, 10);
                return o;
            }

			// input is the output from vert()
            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				fixed4 col = i.color;
				//col.r = i.vertex.x / 1000;
				//col.g = i.vertex.y / 1000;
                return col;
            }
            ENDCG
        }
    }
}
