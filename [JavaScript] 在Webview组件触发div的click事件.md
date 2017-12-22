首先不是所有浏览器中的所有元素都支持click方法。事实上只有input/button元素在所有浏览器才具有click方法。

但是，我们可以通过dispatchEvent事件触发。

·  
	StringBuffer js = new StringBuffer();  
	s.append("var x = document.getElementsByClassName(\"div_name\");");  
	js.append("for(var i = 0; i < x.length; i++) {");  
	js.append("  var evt = document.createEvent('Event');");  
	js.append("  evt.initEvent('click',true,true);");  
	js.append("  x[i].dispatchEvent(evt);");  
	js.append("};");  
	mWebView.loadUrl("javascript:" + js.toString());  

·      
