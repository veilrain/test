@if exp="typeof(global.fog_object) == 'undefined'"
@iscript

/*
	模擬霧氣的插件

	這個是在下雪的插件的基礎上修改的
*/

class FogGrain
{
	// 霧氣團塊的類

	var fore; // 表層的霧氣團塊的layer對像
	var back; // 裏層的霧氣團塊的layer對像
	var xvelo; // 橫速度
	var yvelo; // 縱速度
	var xaccel; // 橫加速
	var yaccel; // 縱加速
	var l, t; // 橫位置縱位置
	var ownwer; // 所有 FogPlugin 
	var spawned = false; // 霧氣團塊是否出現
	var window; // 參照

	function FogGrain(window, n, opacity, owner)
	{
		// FogGrain 
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.absolute = 1000-1; // 重合順序履歷奧
		back.absolute = fore.absolute;

		fore.hitType = htMask;
		fore.hitThreshold = 256; // 全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("fog_" + n); // 畫像讀迂
		back.assignImages(fore);
		fore.setSizeToImageSize(); // 畫像同
		back.setSizeToImageSize();
		fore.opacity = opacity; // 不透明度
		back.opacity = opacity;
		xvelo = 0; // 橫方向速度
		yvelo = 0; // 縱方向速度
		xaccel = 0; // 初期加速度
		yaccel = 0;
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn()
	{
		// 出現
		l = Math.random() * window.primaryLayer.width; // 橫初期位置
		t = Math.random() * window.primaryLayer.height; // 縱初期位置
		spawned = true;
		fore.setPos(l, t);
		back.setPos(l, t); // 裏畫面位置同
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function resetVisibleState()
	{
		// 表示?非表示狀態再設定
		if(spawned)
		{
			fore.visible = owner.foreVisible;
			back.visible = owner.backVisible;
		}
		else
		{
			fore.visible = false;
			back.visible = false;
		}
	}

	function move()
	{
		// 移動霧氣團塊
		l += xvelo;
		t += yvelo;
		xvelo += xaccel;
		xaccel += (Math.random() - 0.5) * 0.3;
		yvelo += yaccel;
		yaccel += (Math.random() - 0.5) * 0.3;
		if(xvelo>=1.5) xvelo=1.5;
		if(xvelo<=-1.5) xvelo=-1.5;
		if(xaccel>=0.2) xaccel=0.2;
		if(xaccel<=-0.2) xaccel=-0.2;
		if(yvelo>=1.5) yvelo=1.5;
		if(yvelo<=-1.5) yvelo=-1.5;
		if(yaccel>=0.2) yaccel=0.2;
		if(yaccel<=-0.2) yaccel=-0.2;
		if(l < -fore.width)
			l = -fore.width;
		if(t < -fore.height)
			t = -fore.height;
		if(l > window.primaryLayer.width)
			l = window.primaryLayer.width;
		if(t > window.primaryLayer.height)
			t = window.primaryLayer.height;

		fore.setPos(l, t);
		back.setPos(l, t); // 裏畫面位置同
	}

	function exchangeForeBack()
	{
		// 表裏管理情報交換
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class FogPlugin extends KAGPlugin
{
	var fogs = []; // 霧氣團塊
	var timer; // 
	var window; // 參照
	var foreVisible = true; // 表畫面表示狀態
	var backVisible = true; // 裏畫面表示狀態
    var opacity;

	function FogPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize 
		// 管理明示的破棄
		for(var i = 0; i < fogs.count; i++)
			invalidate fogs[i];
		invalidate fogs;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		if(timer !== void) return;


		for(var i = 0; i < num; i++)
		{
			var n = intrandom(0, 3); 
			fogs[i] = new FogGrain(window, n, +options.opacity, this);
			fogs[i].spawn();
		}

		// 作成
		timer = new Timer(onTimer, '');
		timer.interval = 80;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		opacity = +options.opacity;

		setOptions(options); // 設定
	}

	function uninit()
	{

		if(timer === void) return;

		for(var i = 0; i < fogs.count; i++)
			invalidate fogs[i];
		fogs.count = 0;

		invalidate timer;
		timer = void;
	}

	function setOptions(elm)
	{
		// 設定
		foreVisible = +elm.forevisible if elm.forevisible !== void;
		backVisible = +elm.backvisible if elm.backvisible !== void;
		resetVisibleState();
	}

	function onTimer()
	{
		// 週期呼
		var fogcount = fogs.count;
		for(var i = 0; i < fogcount; i++)
			fogs[i].move(); // move 呼出
	}

	function resetVisibleState()
	{
		var fogcount = fogs.count;
		for(var i = 0; i < fogcount; i++)
			fogs[i].resetVisibleState(); // resetVisibleState 呼出
	}

	function onStore(f, elm)
	{
		// 刊保存
		var dic = f.fogs = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.fogCount = fogs.count;
		dic.opacity = opacity;
	}

	function onRestore(f, clear, elm)
	{
		// 刊讀出
		var dic = f.fogs;
		if (dic === void || !+dic.init)
		{
			uninit();
		}
		else if (dic !== void && +dic.init)
		{
			init(dic.fogCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible, opacity : dic.opacity ] );
		}
	}

	function onStableStateChanged(stable)
	{
	}

	function onMessageHiddenStateChanged(hidden)
	{
	}

	function onCopyLayer(toback)
	{
		// 表←→裏情報
		// 情報表示?非表示情報
		if(toback)
		{
			// 表→裏
			backVisible = foreVisible;
		}
		else
		{
			// 裏→表
			foreVisible = backVisible;
		}
		resetVisibleState();
	}

	function onExchangeForeBack()
	{
		// 裏表管理情報交換
		var fogcount = fogs.count;
		for(var i = 0; i < fogcount; i++)
			fogs[i].exchangeForeBack(); // exchangeForeBack 呼出
	}
}

kag.addPlugin(global.fog_object = new FogPlugin(kag));
	// 作成、登錄

@endscript
@endif
; 登錄
@macro name="foginit"
@eval exp="mp.num=20" cond=(mp.num===void)
@eval exp="mp.opacity=255" cond=(mp.opacity===void)
@eval exp="fog_object.init(+mp.num, mp)"
@endmacro
@macro name="foguninit"
@eval exp="fog_object.uninit()"
@endmacro
@macro name="fogopt"
@eval exp="fog_object.setOptions(mp)"
@endmacro
@return

