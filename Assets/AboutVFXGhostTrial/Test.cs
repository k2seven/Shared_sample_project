using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using XLua;
using System;

[LuaCallCSharp]
public class Test : MonoBehaviour
{
    public TextAsset luaScript;

    internal static LuaEnv luaEnv = new LuaEnv(); 

    private Action luaStart;
    private Action luaUpdate;

    private LuaTable scriptEnv;

    void Awake()
    {
        scriptEnv = luaEnv.NewTable();
        LuaTable meta = luaEnv.NewTable();
        meta.Set("__index", luaEnv.Global);
        scriptEnv.SetMetaTable(meta);
        meta.Dispose();

        scriptEnv.Set("self", this);

        luaEnv.DoString(luaScript.text, "LuaTestScript", scriptEnv);
        scriptEnv.Get("start", out luaStart);
        scriptEnv.Get("update", out luaUpdate);
    }

    // Use this for initialization
    void Start()
    {
        if (luaStart != null)
        {
            luaStart();
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (luaUpdate != null)
        {
            luaUpdate();
        }
    }
}