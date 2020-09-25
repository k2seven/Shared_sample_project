Shader "Unlit/spra"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Cull Off
		ZTest Off
		Blend SrcAlpha OneMinusSrcAlpha
		//Blend SrcAlpha OneMinusSrcAlpha
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
				float2 uv : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float2 screenUV:TEXCOORD1;
				float eyeDepth : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			sampler2D _PaintTex;

			v2f vert (appdata v)
			{
				v2f o;
				//o.vertex = UnityObjectToClipPos(v.vertex);
				//o.vertex = float4(v.uv * 2, 0, 1)*float4(1, _ProjectionParams.x, s1, 1);
				o.vertex = float4(v.uv1 * 2 - 1, 0, 1)*float4(1, _ProjectionParams.x, 1, 1);
				o.uv = v.uv;
				// float4 hsp = UnityObjectToClipPos(v.vertex);
				// o.screenUV = hsp.xy / hsp.w;
				// COMPUTE_EYEDEPTH(o.eyeDepth);
				//UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_PaintTex, i.uv);
				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
				// clip(1 + i.screenUV.x);
				// clip(1 + i.screenUV.y);
				// clip(1 - i.screenUV.x);
				// clip(1 - i.screenUV.y);
				// // float refDepth = tex2D(_DepthTex, i.screenUV*float2(1, _ProjectionParams.x)*0.5 + 0.5).r;
				// // refDepth=LinearEyeDepth(refDepth);
				// //clip((i.eyeDepth + 0.001) - refDepth);
				// //clip(refDepth - (i.eyeDepth - 0.05));

				// float fallout = 1 - min(dot(i.screenUV, i.screenUV), 1);

				// fixed4 col = tex2D(_PaintTex, i.uv);
				// col.a *= fallout;
				// return col;
			}
			ENDCG
		}
	}
}
