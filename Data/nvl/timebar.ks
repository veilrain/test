;TimeBar Plugin
;Version 0.97-beta(2007-03)
;Author:CountD & Miliardo (KCDDP)
;Copyright 2005-2007 [Key Fans Club] the Council of Doujin-game Development and Promotion, All Right Reserved

;調用本插件的KAG Tag為timeout。
;需要在調用@s之前使用。
;參數如下：
;bar：時間條的文件名
;x、y：時間條顯示的位置
;time：定時時間
;width：時間條的長度
;bgimage、bgx、bgy：時間條背景的文件名、位置
;
;調用例子如下：
;@timebar bar=bar x=300 y=300 time=5000 width=120 bgimage=barbg bgx=295 bgy=295

@if exp="typeof(global.timebar_object) == 'undefined'"
@iscript

class TimeBarPlugin extends KAGPlugin
{

        var fore,bgfore;
        var timer;
        function TimeBarPlugin(seltime)
        {
                bgfore=new Layer(kag, kag.fore.base);
                fore=new Layer(kag, kag.fore.base);
                fore.absolute = 2000000-2;
                bgfore.absolute = 2000000-3;
                timer = new Timer(onTimer, "");
                timer.enabled = false;
                fore.visible = false;
                bgfore.visible = false;
        }

        function createTimeBar()
        {

                bgfore=new Layer(kag, kag.fore.base);
                fore=new Layer(kag, kag.fore.base);
                fore.absolute = 2000000-2;
                bgfore.absolute = 2000000-3;
                fore.visible = false;
                bgfore.visible = false;
        }

        function setOptions(elm)
        {
                createTimeBar();
                if(typeof(elm.bgimage)!='undefined')
                {        
                        bgfore.visible=true;
                        bgfore.loadImages(elm.bgimage);
                        bgfore.setSizeToImageSize();
                        bgfore.setPos(elm.bgx,elm.bgy);
                }
                fore.visible=true;
                fore.loadImages(elm.bar);
                fore.setSizeToImageSize();
                fore.setPos(elm.x,elm.y);
                timer.enabled = true;
                timer.interval = elm.time/(elm.width);
        }

        function finalize()
        {
                invalidate timer;
                invalidate fore;
        }

        function onTimer()
        {
                if (fore.imageWidth > 1) fore.imageWidth -= 1;
                if (fore.imageWidth == 1)
                {
                        timer.enabled = false;
                        fore.visible = false;
                        bgfore.visible = false;
                }
        }

        function delTimeBar()
        {
                timer.enabled = false;
                fore.visible = false;
                bgfore.visible = false;
        }

}


kag.addPlugin(global.timebar_object = new TimeBarPlugin(kag));

@endscript

@macro name="timebar"
@eval exp="timebar_object.setOptions(mp)"
@endmacro


@macro name="deltimebar"
@eval exp="timebar_object.delTimeBar(mp)"
@endmacro

@endif
@return
