## Java JNA 使用笔记

#### 1、解决JNA调用dll出现中文乱码问题.

最简单方式，设置JNA编码
```
System.setProperty("jna.encoding",编码);
```

