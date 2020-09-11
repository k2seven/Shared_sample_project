using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class Test : MonoBehaviour {

	// Use this for initialization
	void Start () {
		LuaEnv env = new LuaEnv();
		env.DoString(@"
			print('lua start')
			
			GameObject = CS.UnityEngine.GameObject
			Vector3 = CS.UnityEngine.Vector3

			local go = GameObject('test_go')
			go.transform.localScale = Vector3.one	
			go.name = 'lua_obj'
		");
	}
	//12312312312312312312
	
	// Update is called once per frame
	void Update () {
		
	}
}
