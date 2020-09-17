Shader "Unlit/teatG"
{
	Properties
	{
		// _NoiseTex ("NoiseTextrue", 2D) = "white" {}
		// _Strength ("Strength", range(0, 1)) = 0.5
		// _Speed ("Speed", range(-2, 2)) = 0.5
		_NoiseTexture ("Noise" , 2D) = "white" {}
		_Distorted ("Distorted" , range(0,1)) = 0.5
		_Speed ("Speed" , range(-2,2)) = 1
	}
	SubShader
	{
		Tags { "Queue" = "Transparent" }

		GrabPass
		{
			"_GTT"
		}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				// float2 uv : TEXCOORD0;
				// UNITY_FOG_COORDS(1)
				float2 uv : TEXCOORD0;
				float4 grabPos : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			sampler2D _NoiseTexture;
			float4 _NoiseTexture_ST;
			// float4 _MainTex_ST;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _NoiseTexture);
				// UNITY_TRANSFER_FOG(o,o.vertex);
				o.grabPos = ComputeGrabScreenPos(o.vertex);
				return o;
			}

			sampler2D _GTT;
			float _Distorted;
			float _Speed;
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				i.uv = i.uv - _Time.xy*_Speed*0.1;
				fixed4 col = tex2D(_NoiseTexture, i.uv);
				i.grabPos.xy += (col.xy*2 - 1) *0.1 *_Distorted;
				fixed4 col1 = tex2Dproj(_GTT, i.grabPos);

				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				return col1;
			}
			ENDCG
		}
	}
}
