;------------------------------------------------------------
;點下「開始遊戲」以後一開始默認執行的內容
;你可以把下面替換成自己的劇本，或者直接從這裡跳躍到其他自建腳本
;------------------------------------------------------------
*start|序章
@bgm storage="BGM074.ogg"
@bg storage="BG14a"
@fg pos="center" storage="fg01_02"
@dia
@history output="true"
@nvl娘 face="face01_02"
歡迎來到THE NVL Maker的世界～[lr]一起來創作好玩的遊戲吧！[w]
@nvl娘 face="face01_01" fg="fg01_01"
《THE NVL Maker》是一款圖形化編輯工具，可以用來製作電子小說、戀愛冒險遊戲、養成遊戲等等。[w]
@nvl娘
軟件在任何情況下（製作免費遊戲、同人販賣遊戲、商業遊戲），都是可以免費使用的。[w]
@nvl娘
abcd但是請注意，發佈遊戲時，需要在遊戲內或說明文檔、發佈帖等地方，明確寫出使用了本工具。[w]
@fg pos="center" storage="fg01_02"
@nvl娘 face="face01_02" fg="fg01_02"
這是為了讓更多人能認識NVL娘，所以拜託了嘛。[w]
@nvl娘
另外，
@link exp="System.shellExecute('http://www.nvlmaker.net/')"
《THE NVL Maker》的官網
@endlink
也提供了專門的頁面用於遊戲宣傳，方便同好交流。[w]
@nvl娘
所以，發佈遊戲的時候歡迎
@link exp="System.shellExecute('http://www.weibo.com/nvlmaker')"
@font color="0xCCFFCC"
艾特官方微博
@resetfont
@endlink
喲~[w]
@nvl娘 face="face01_01" fg="fg01_01"
還有一點要注意的是，在使用THE NVL Maker製作遊戲時，不能使用「侵犯到他人版權的素材」。[w]
@nvl娘
例如，不能使用網上隨意搜索到的風景圖片作為背景，不能使用來源不明的MP3作為BGM等等。[w]
@nvl娘
NVL可以使用的素材僅限於此範圍：來歷明確（可指向特定的作者，而非收集者）、有清楚的使用規約（作者聲明同意用於遊戲）。[w]
@nvl娘
網上會有一些所謂的素材站，將其他遊戲的圖片音樂音效等解包並放出，或隨意擴散他人版權的作品，這些被稱為「版權物」，是絕對不可以使用的。[w]
@nvl娘
簡單地說，請不要使用由「收集者」而非「原作者」上傳的「XX素材包」。[w]
@nvl娘
如果你看到「內容由用戶上傳版權歸原作者所有僅供學習」等字樣，那麼可以直接把那個站拉黑了。[w]
@nvl娘
「禁止侵權」這點對免費遊戲也沒有例外。因為，一旦你公開了包含版權問題素材的遊戲，你的行為已經不屬於通稱的「個人學習使用」。[w]
@nvl娘
在這種情況下，發佈（如在論壇、貼吧、QQ群有條件或無條件分享等等）即是違法。[w]
@nvl娘 face="face01_02" fg="fg01_02"
當然，並不是說所有東西都一定要自己做。[lr]還是可以利用現有資源的～[w]
@nvl娘
所以，為了幫助大家更有效率地製作遊戲，
@link exp="System.shellExecute('http://www.nvlmaker.net/')"
《THE NVL Maker》的官網[endlink]
提供了一些合法的共享素材網站連接。
請點
@link exp="System.shellExecute('http://www.nvlmaker.net/material.html')"
@font color="0xCCFFCC"
這裡查看
@resetfont
@endlink
。[w]
@nvl娘 face="face01_01" fg="fg01_01"
對於一些作品的二次創作（即是俗稱的XX作品的同人），在沒有獲得官方授權的情況下，也不可以使用官方的原畫、截圖、OST等。[w]
@nvl娘 face="face01_02" fg="fg01_02"
真心想要製作二次創作遊戲的話，請寫信去向官方索要授權，[lr]或者徵集同好一起來畫圖、創作音樂吧。[w]
@nvl娘 face="face01_01" fg="fg01_01"
接下來進入演示正題～[w]
@clfg layer="8" time="100"
;----------
;設置默認姓名
@eval exp="f.姓='abc'"
@eval exp="f.名='def'"
@history output="false"
;自定義主角名字的代碼
@nowait
請輸入主角名字：[r]
姓氏：[edit opacity=0 color=0xFFFFFF name=f.姓][r]
名字：[edit opacity=0 color=0xFFFFFF name=f.名][r]
@links target="*輸入完畢" text="確定" hint="點這裡繼續~"
@endnowait
@history output="true"
@s
;----------
*輸入完畢
;將輸入的名字使用commit保存下來，沒有這個指令的話輸入了也還是維持默認值
@commit
@er
;使用emb指令來在對話裡顯示變數的值
@主角
主角的姓氏是[emb exp=f.姓]，名字是[emb exp=f.名]。[w]
@fg layer="0" pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
那麼，測試一下選擇吧。[w]
@clfg layer="0" clface="1"
;----------
;顯示選擇按鈕
@selstart hidemes="0" hidesysbutton="0"
@locate y="200" x="0"
@selbutton target="*選擇A" text="我要選擇A"
@locate y="300" x="0"
@selbutton target="*選擇B" text="我要選擇B"
@selend
;----------
*選擇A|路線一
@clsel
@bg storage="cg_01"
;登陸CG（記得也要在cglist.txt裡寫上對應CG名才能成功顯示）
@addcg storage="cg_01"
@npc id="路人甲"
你選擇了A。第一張CG現在可以在CG模式裡查看了。[w]
@bg storage="cg_01_a"
@addcg storage="cg_01_a"
@npc id="路人甲"
第一張CG的變化也被登陸了，現在在CG模式中點選第一張CG，會連續顯示兩張圖。[w]
@jump target="*合併"
;----------
*選擇B|路線二
@clsel
@bg storage="cg_02"
;登陸CG（記得也要在cglist.txt裡寫上對應CG名才能成功顯示）
@addcg storage="cg_02"
@npc id="路人甲"
你選擇了B。第二張CG現在可以在CG模式裡查看了。[w]
@jump target="*合併"
;----------
*合併
@npc id="路人甲"
不管選擇了A還是B，最後你都會看到這句話。[w]
@scr
試試另外一個樣式的對話框……[w]
你也可以切換文字的顏色。[l][font color=0xCCFFCC]比如這樣……[resetfont][lr][r]
改變[font size=30]大[font size=15]小[resetfont]也沒有問題喲。[w]
@dia
@npc id="路人甲"
現在換回來了……[w]
@npc id="路人甲"
地圖測試。[w]
@clfg layer="all"
@map storage="sample.map"
;----------
*地圖01|教室
@clmap
@bg storage="BG01a"
@dia
@主角
來到了教室。[w]
@call storage="endA.ks"
;呼叫結局事件A，當事件執行完之後就會返回這裡
@jump target="*地圖合併"
;----------
*地圖02|車上
@clmap
@bg storage="BG12a"
@dia
@主角
來到了車上。[w]
@call storage="endB.ks"
;呼叫結局事件B，當事件執行完之後就會返回這裡
@jump target="*地圖合併"
;----------
*地圖合併
@fg pos="center" storage="fg01_02"
@nvl娘 face="face01_02"
功能演示完畢。[lr]
更多內容請查看tutorial文件夾下的教程。[w]
@nvl娘 face="face01_01" fg="fg01_01"
準備好就返回標題了哦。[w]
;執行返回標題指令，返回到標題畫面
@gotostart ask="false"
