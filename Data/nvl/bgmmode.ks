;------------------------------------------------------------
;非常懶惰的BGM鑒賞系統
;------------------------------------------------------------
*start
[tempsave]
[iscript]
//載入bgm列表
f.bgmlist=[].load("bgmlist.txt");

//計算頁數
tf.BGM頁數=f.bgmlist.count\f.config_bgmmode.list.num;
if (f.bgmlist.count%f.config_bgmmode.list.num>0) tf.BGM頁數++;
tf.當前BGM頁=1;
[endscript]
;------------------------------------------------------------
*window
[history enabled="false"]

[locklink]
[rclick enabled="true" jump="true" storage="bgmmode.ks" target=*返回]

[backlay]
;這裡修改背景圖片
[image layer=11 page=back storage=&"f.config_bgmmode.bgd" left=0 top=0 visible="true"]

[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]
;描繪各種ABC
[draw_bgmlist]
[trans method="crossfade" time=300]
[wt]

[s]
*播放音樂
[playbgm storage=&"tf.當前BGM"]
;------------------------------------------------------------
*刷新畫面
[rclick enabled="true" jump="true" storage="bgmmode.ks" target=*返回]
[current layer="message4"]
[er]
;描繪各種ABC
[draw_bgmlist]
[s]

;------------------------------------------------------------
*返回
;假如當前播放的不是標題背景音樂，恢復標題背景音樂
[bgm storage=&"f.config_title.bgm" cond="kag.bgm.playingStorage!=f.config_title.bgm"]
[locklink]
[rclick enabled="false"]
[backlay]
[tempload backlay="true" bgm="false" se="false"]
[trans method="crossfade" time=200]
[wt]

[return]
