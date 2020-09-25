using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class reUv : MonoBehaviour {
	public RenderTexture rT;
    public RenderTexture rT1;
	public Texture sT;
	public Texture cT;
	Material lM;
	Camera ca;
    int i = 0;
	// Use this for initialization
	void Start () {
		lM = GameObject.Find("a_c_n_che10/a_c_n_che10_01").GetComponent<Renderer>().material;
		ca = GetComponent<Camera>();
		Shader sc = Shader.Find("Unlit/copyShader");
		ca.SetReplacementShader(sc,"RenderType");
		lM.SetTexture("_MainTex",sT);
        ca.targetTexture = rT;
		ca.Render();
		lM.SetTexture("_MainTex",rT);
        ca.ResetReplacementShader();
	}

	// Update is called once per frame
	void Update () {
		if(Input.GetMouseButtonUp(0)){
            // ca.ResetReplacementShader();
            // ca.targetTexture = rT1;
            // ca.Render();
            ca.clearFlags=CameraClearFlags.Nothing;
			Shader sc = Shader.Find("Unlit/spra");
			ca.SetReplacementShader(sc,"RenderType");
            ca.targetTexture = rT;
            i++;
            Texture l = new Texture();
            if(i%2 == 1){
                l = cT;
            }else{
                l = sT;
            }
			Shader.SetGlobalTexture("_PaintTex",l);
			ca.Render();
		}
	}
}
