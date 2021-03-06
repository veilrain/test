;-------------------------------------------------------------------------------------------
;結局設定相關宏
;-------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------
;登錄END
;-------------------------------------------------------------------------------------------
[iscript]
function AddToEndList(name)
{
	//假如是第一次登錄
	if (sf.endlist==void) sf.endlist=%[];
	sf.endlist[name]=true;
	//通關設定為true
	sf.通關=true;
	dm("登錄END："+name);
}
[endscript]

[macro name=addend]
[eval exp="AddToEndList(mp.storage)"]

[endmacro]

;-------------------------------------------------------------------------------------------
;END按鈕
;-------------------------------------------------------------------------------------------
[iscript]
function EndButton(filename,picname)
{
		f.config_endmode.thum.target="*結局跳轉";

		//點下按鈕之後執行的表達式，將通過行號取得同一縮略圖的差分列表並準備顯示
		f.config_endmode.thum.exp="tf.結局=\""+filename+"\"";

		//利用thumbnail大小圖片添加一個CG按鈕
		kag.current.addButton(f.config_endmode.thum);

		//設定按鈕為最近添加的按鈕
		var button=kag.current.links[kag.current.links.count-1].object;

        //臨時圖層，讀取CG或CG縮略圖
        var temp=new Layer(kag, kag.fore.base);

		//查找PNG格式的縮略圖，找不到則直接縮放原圖
		if (Storages.isExistentStorage(picname+"_thum"+".png"))
		{
			temp.loadImages(picname+"_thum");
		}
        else
		{
			temp.loadImages(picname);
		}

        temp.setSizeToImageSize();

        //臨時圖層，讀取thumbnail大小圖片
        var temp2=new Layer(kag, kag.fore.base);
        temp2.loadImages(f.config_endmode.thum.normal);
        temp2.setSizeToImageSize();

		//將CG縮略圖描繪到按鈕上
        button.stretchCopy(0, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stLinear);
        button.stretchCopy(button.width*2, 0, button.width, button.height, temp, 0, 0, temp.width, temp.height, stLinear);
        
        //選中效果（thumbnail大小圖片同時作為高亮效果使用）
         button.operateStretch(button.width, 0, button.width, button.height, temp2, 0, 0, temp2.width, temp2.height);
         button.operateStretch(button.width*2, 0, button.width, button.height, temp2, 0, 0, temp2.width, temp2.height);
}

//
function draw_endlist()
{

	dm("=========描繪END按鈕，當前第"+tf.當前END頁+"頁=========");

	for (var i=0;i<f.config_endmode.locate.count;i++)
	{	     
	     kag.tagHandlers.locate(%["x"=>f.config_endmode.locate[i][0],"y"=>f.config_endmode.locate[i][1]]);
	     
	     //取得CG在列表中的編號（行號）
	     var j=i+f.config_endmode.locate.count*(tf.當前END頁-1);
	     
	     if (f.endlist[j]!=void)
	     {
			var arr=f.endlist[j].split(",");
			//腳本名
			var name=arr[0];
			//對應圖片
		    var pic=arr[1];
		    
		    if (sf.endlist[name]==true)
		    {
			    dm("【END按鈕："+name+"成功顯示】");
			    EndButton(name,pic);
		    }
		    else
		    {
			    dm("【END按鈕："+name+"尚未登錄】");
		    }
	     }
	}
}
[endscript]


[macro name=draw_endlist]

	;描繪按鈕
	[eval exp="draw_endlist()"]

	;前一頁
	[mybutton dicname="f.config_endmode.up" exp="tf.當前END頁-- if (tf.當前END頁>1)" target=*刷新畫面]
	;後一頁
	[mybutton dicname="f.config_endmode.down" exp="tf.當前END頁++ if (tf.當前END頁<tf.END頁數)" target=*刷新畫面]
	;返回按鈕
	[mybutton dicname="f.config_endmode.back" target=*返回]
[endmacro]

[return]
