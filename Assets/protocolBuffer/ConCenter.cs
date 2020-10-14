using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Google.Protobuf;
using Google.Protobuf.pbTest.Person;
using System.IO;

public class ConCenter : MonoBehaviour {
	public Text nameT;
	public Text ageT;
	public Text phoneNumT;
	public Button btn;
	public Text rNameT;
	public Text rAgeT;
	public Text rPhoneNumT;
	// Use this for initialization
	byte[] dataBytes;
	void Start () {
		btn.onClick.AddListener(CreatSendPb);
		TestForProto tbProto = new TestForProto();
		tbProto.Name = nameT.text;
		tbProto.Age = int.Parse(ageT.text);
		string pnum = phoneNumT.text;
		for(int i = 0;i < pnum.Length;i++){
			tbProto.PhoneNum.Add(int.Parse(pnum[i].ToString()));
		}

		byte[] dataBytes = tbProto.ToByteArray();
		this.dataBytes = dataBytes;
		//IMessage imPerson = new TestForProto();
		//TestForProto cbProto = (TestForProto)imPerson.Descriptor.Parser.ParseFrom(dataBytes);
		//cbProto =

	}
	// Update is called once per frame
	void CreatSendPb (){
		TestForProto tbProto = new TestForProto();
		tbProto.Name = nameT.text;
		tbProto.Age = int.Parse(ageT.text);
		string pnum = phoneNumT.text;
		for(int i = 0;i < pnum.Length;i++){
			tbProto.PhoneNum.Add(int.Parse(pnum[i].ToString()));
		}

		byte[] dataBytes = tbProto.ToByteArray();
		this.dataBytes = dataBytes;




		TestForProto cbProto = TestForProto.Parser.ParseFrom(this.dataBytes);
		rNameT.text = cbProto.Name;
		rAgeT.text = cbProto.Age.ToString();
		rPhoneNumT.text = "";
		for(int i = 0;i < cbProto.PhoneNum.Count;i++){
			rPhoneNumT.text = rPhoneNumT.text + cbProto.PhoneNum[i];
		}
	}
	void Update () {
	}
}
