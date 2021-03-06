;-------------------------------------------------------------------------------------------
;養成面板專用宏
;背景板顯示在layer11層上
;按鈕顯示在message3層上
;可刷新的數值顯示面板顯示在layer12上
;懸停圖片顯示在layer13上

;追加懸停圖片函數,配合新增的參數，鼠標移到按鈕上時可在指定位置額外顯示一張圖片
;使用方式為在如下參數里填入內容:
;鼠標移入：mapshow('圖片名',x,y)
;鼠標移出：maphide()
;-------------------------------------------------------------------------------------------
*start
[iscript]
//------------------------------------------------------------
//載入.edu文件
//------------------------------------------------------------
function loadedu(name)
{
//創建數組類並讀入關鍵字
var dic =[];
dic=Scripts.evalStorage(name);

 if (dic!='')
 {
   //載入背景
   kag.back.layers[11].loadImages(%["storage"=>dic[0].bgd,"visible"=>true,"left"=>0,"top"=>0]);
   //讀取空白底圖
   kag.back.layers[12].loadImages(%['storage'=>'empty','visible'=>true,'left'=>0,'top'=>0]);

////循環描繪按鈕-------------------------------------------------------------------------------
   for (var i=1;i<11;i++)
   {
   //定義按鈕位置
   kag.tagHandlers.locate(%["x" => dic[i]["x"], "y" => dic[i]["y"] ]);
   
   //創建按鈕用字典
   var edubutton = new Dictionary();
   //取得數據
   edubutton["normal"]=dic[i]["normal"];
   edubutton["over"]=dic[i]["over"];
   edubutton["on"]=dic[i]["on"];
   edubutton["storage"]=dic[i]["storage"];
   edubutton["target"]=dic[i]["target"];

   if (dic[i]["exp"]!=void) edubutton["exp"]=dic[i]["exp"];

   if (dic[i]["enterse"]!=void) edubutton["enterse"]=dic[i]["enterse"];
   if (dic[i]["clickse"]!=void) edubutton["clickse"]=dic[i]["clickse"];
	if (dic[i]["onenter"]!=void) mapbutton["onenter"]=dic[i]["onenter"];
	if (dic[i]["onleave"]!=void) mapbutton["onleave"]=dic[i]["onleave"];
 
   //假如有條件，取得條件表達式
   if (dic[i]["cond"]!=void) edubutton["cond"]=dic[i]["cond"];
   
       //該據點在本地圖上使用到
       if (dic[i]["use"]==1)
      {
           //滿足條件
           if (Scripts.eval(edubutton["cond"])==true) kag.tagHandlers.button(edubutton);
           //或者無需條件
           if (edubutton["cond"]==void) kag.tagHandlers.button(edubutton);
      }
      
      
   }
//
// //-------------------------------------------------------------------------------
 
   //循環描繪文字
   for (var i=11;i<21;i++)
   {
     //創建文字用字典
     var edutext = new Dictionary();
     
      edutext["layer"]="12";
      edutext["page"]="back";
      
      edutext["x"]=dic[i].x;
      edutext["y"]=dic[i].y;
      //加入行高度屬性
      if (dic[i].lineheight!=void) edutext["lineheight"]=dic[i].lineheight;
      
      edutext["text"]=Scripts.eval(dic[i].flagname);
      
      edutext["face"]=dic[i].fontname;
      edutext["size"]=dic[i].size;
      edutext["color"]=dic[i].color;
      edutext["bold"]=dic[i].bold;
      edutext["shadow"]=dic[i].shadow;
      edutext["shadowcolor"]=dic[i].shadowcolor;
      edutext["edge"]=dic[i].edge;
      edutext["edgecolor"]=dic[i].edgecolor;

   //假如有條件，取得條件表達式
   if (dic[i]["cond"]!=void) edutext["cond"]=dic[i]["cond"];
   
       //該據點在本地圖上使用到
       if (dic[i]["use"]==1)
      {
           //滿足條件
           if (Scripts.eval(edutext["cond"])==true)  kag.tagHandlers.ptext(edutext);
           //或者無需條件
           if (edutext["cond"]==void)   kag.tagHandlers.ptext(edutext);
      }
 
   }
   //-------------------------------------------------------------------------------
      //循環描繪圖形
   for (var i=21;i<31;i++)
   {

     if (dic[i].pic!=void && dic[i]["use"]==1)
     {
       //圖形的情況，創建圖形用字典
        var edupic = new Dictionary();
        
		edupic["layer"]="12";
		edupic["page"]="back";
		
		edupic["dx"]=dic[i].x;
		edupic["dy"]=dic[i].y;
		
		edupic["storage"]=dic[i].pic;
		
		//假如變數值不為空，則將變數值視為圖片名
		if (dic[i].flagname!=void) edupic["storage"]=Scripts.eval(dic[i].flagname);
		
		if (Scripts.eval(dic[i]["cond"])==true) kag.tagHandlers.pimage(edupic);
		if (dic[i]["cond"]==void)  kag.tagHandlers.pimage(edupic);
     
     }
     else if (dic[i].pic==void && dic[i]["use"]==1)
     {
         //假如是數字的情況
          if (Scripts.eval(dic[i]["cond"])==true) drawnum(Scripts.eval(dic[i].flagname),dic[i].num,dic[i].space,"12","back",dic[i].x,dic[i].y);
          if (dic[i]["cond"]==void) drawnum(Scripts.eval(dic[i].flagname),dic[i].num,dic[i].space,"12","back",dic[i].x,dic[i].y);  
     }
     
   }
   
   //-------------------------------------------------------------------------------
}
}
[endscript]
;------------------------------------------------------------
;顯示養成面板
;------------------------------------------------------------
[macro name=edu]
[rclick enabled="false"]
[history enabled="false"]
[backlay]
;隱藏一般對話層
[layopt layer="message0" page="back" visible="false"]
;隱藏系統按鈕層
[hidesysbutton]
[frame layer="%message|message3" page="back"]
[current layer="%message|message3" page="back"]
[er]
;顯示養成面板
[eval exp=&"'loadedu(\''+mp.storage+'\')'"]
[trans * method=%method|crossfade time=%time|300]
[wt]
;當「等待玩家選擇」選中時，等待玩家點擊按鈕再繼續
[s cond="mp.waitclick"]
[endmacro]

;------------------------------------------------------------
;清除面板
;------------------------------------------------------------
[macro name=cledu]
[backlay]
[freeimage layer=11 page="back"]
[freeimage layer=12 page="back"]
[freeimage layer=13 page="back"]
[current layer="%message|message3" page="back"]
[er]
[layopt layer="%message|message3" page="back" visible="false"]
[layopt layer="message0" page="back" visible="true"]
[hidesysbutton]
[trans * method=%method|crossfade time=%time|200]
[wt]
[current layer="message0"]
[rclick enabled="true"]
[history enabled="true"]
[endmacro]
;------------------------------------------------------------

[iscript]
//------------------------------------------------------------
//顯示數字圖片
//------------------------------------------------------------
function drawnum(flagname,num,sp=20,layer="12",page="back",x=0,y=0) //數值，圖片，字間距，所在層,x,y
{

   //分析處理變數（格式化為三位數，改成%04d就可格式化為4位）
   var str="%03d".sprintf(flagname);

   //循環描繪數值;
   for (var i=0;i<str.length;i++)
   {
           kag.tagHandlers.pimage(
           %[
              "layer"=>layer,
              "page"=>page,
              "storage"=>num+str[i],
              "dx"=> (int)x+(int)i*sp,
              "dy"=> (int)y
           ]);
   
   }

}
[endscript]
;------------------------------------------------------------
;描繪數字顯示的宏
;------------------------------------------------------------
;使用範例
;@draw_num num=&"f.test" pic="num-" x=100 y=150
[macro name=draw_num]
[eval exp="drawnum(mp.num,mp.pic,mp.sp,mp.layer,mp.page,mp.x,mp.y)"]
[endmacro]

[return]
