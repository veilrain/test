;------------------------------------------------------------
;非常懶惰的load畫面
;------------------------------------------------------------
*start
[locksnapshot]
[tempsave]

;------------------------------------------------------------
*window

;載入配置文件
[iscript]
f.config_sl=f.config_load;
[endscript]
[history enabled="false"]

*firstpage
[locklink]
[rclick enabled="true" jump="true" storage="load.ks" target=*返回]
[backlay]
[image layer=14 page=back storage=&"f.config_sl.bgd" left=0 top=0 visible="true"]

;無效化系統按鈕層
[disablesysbutton page="back"]

;用message4描繪
[current layer="message4" page="back"]
[layopt layer="message4" visible="true" page="back" left=0 top=0]
[er]

[eval exp="drawslbutton('back')"]

[trans method="crossfade" time=300]
[wt]

[s]
;------------------------------------------------------------
*刷新畫面
[current layer="message4"]
[er]
[eval exp="drawslbutton()"]
[s]

;------------------------------------------------------------
*存取遊戲
[if exp="checkdata(tf.最近檔案)"]
[load ask="true" place="&tf.最近檔案"]
[else]
[jump target=*刷新畫面]
[end]
[s]
;------------------------------------------------------------
*返回
[jump storage="main_menu.ks" target=*返回]
