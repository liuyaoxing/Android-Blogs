## Android 开发遇到过的问题

#### 1、Caused by: java.lang.IllegalStateException: You need to use a Theme.AppCompat theme (or descendant) with this activity.

将Styles.xml中的

```
    <style name="AppBaseTheme" parent="@style/Theme.Holo.Light">
    <item name="android:windowIsTranslucent">true</item>
</style>
```
修改成
```
    <style name="AppBaseTheme" parent="@style/Theme.AppCompat.Light">
    <item name="android:windowIsTranslucent">true</item>
</style>
```

#### 2、WebView 中执行loadUrl("javascript:document.getElementById(\"id\").click();") 不生效

因为Android js 接口目前并没有实现click()方法，所以的使用HTML DOM事件对象触发：

```
webView.loadUrl("javascript:(function(){" //
	+ "l=document.getElementById('" + elementId + "');" //
	+ "e=document.createEvent('HTMLEvents');" //
	+ "e.initEvent('click',true,true);" //
	+ "l.dispatchEvent(e);" //
	+ "})()");
```

#### 3、出现：Error parsing XML:unbound prefix
在布局文件中新增:

```
xmlns:app="http://schemas.android.com/apk/res-auto"
```
或者
```
xmlns:app="http://schemas.android.com/apk/packagename"
```

#### 4、Installation error: INSTALL_FAILED_UPDATE_INCOMPATIBLE
安装包和设备上已安装的程序签名不一致。
