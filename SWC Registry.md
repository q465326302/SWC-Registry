以下表格概述了SWC注册表。每一行包含一个SWC标识符（ID），弱点标题，CWE父级和相关代码示例列表。ID和测试用例列中的链接指向相应的SWC定义。关系列中的链接指向CWE基本类型或类别。

| ID | 标题 | 关系 |
|---|---|---|
|[SWC-136](SWC-136/SWC-136.md)|未加密的私有数据上链|[CWE-767: 通过公共方法访问关键私有变量](https://cwe.mitre.org/data/definitions/767.html)|
|[SWC-135](SWC-135/SWC-135.md)|没有效果的代码|[CWE-1164: 无关代码](https://cwe.mitre.org/data/definitions/1164.html)|
|[SWC-134](SWC-134/SWC-134.md)|使用硬编码的gas数量进行消息调用|[CWE-655: 不正确的初始化](https://cwe.mitre.org/data/definitions/767.html)|
|[SWC-133](SWC-133/SWC-133.md)|多个变长参数的哈希碰撞|[CWE-294: 通过捕获重放绕过身份验证](https://cwe.mitre.org/data/definitions/294.html)|
|[SWC-132](SWC-132/SWC-132.md)|意外的以太余额|[CWE-667：不正确的锁定](https://cwe.mitre.org/data/definitions/667.html)|
|[SWC-131](SWC-131/SWC-131.md)|存在未使用的变量|[CWE-1164: 无关代码](https://cwe.mitre.org/data/definitions/1164.html)|
|[SWC-130](SWC-130/SWC-130.md)|从右到左覆盖控制字符（U+202E）|[CWE-451：用户界面（UI）对关键信息的误传](http://cwe.mitre.org/data/definitions/451.html)|
|[SWC-129](SWC-129/SWC-129.md)|印刷错误|[CWE-480: 使用错误的运算符](https://cwe.mitre.org/data/definitions/480.html)|
|[SWC-128](SWC-128/SWC-128.md)|利用区块的燃气限制来发动 DoS 攻击。|[CWE-400: 未受控制的资源消耗](https://cwe.mitre.org/data/definitions/400.html)|
|[SWC-127](SWC-127/SWC-127.md)|使用函数类型变量进行任意跳转|[CWE-695：使用低级功能](https://cwe.mitre.org/data/definitions/695.html)|
|[SWC-126](SWC-126/SWC-126.md)|不足的燃气欺诈|[CWE-691：不足的控制流管理](https://cwe.mitre.org/data/definitions/691.html)|
|[SWC-125](SWC-125/SWC-125.md)|错误的继承顺序|[CWE-696：错误的行为顺序](https://cwe.mitre.org/data/definitions/696.html)|
|[SWC-124](SWC-124/SWC-124.md)|写入任意存储位置|[CWE-123: 写入何处条件漏洞](https://cwe.mitre.org/data/definitions/123.html)|
|[SWC-123](SWC-123/SWC-123.md)|要求违规|[CWE-573: 调用方未正确遵循规范](https://cwe.mitre.org/data/definitions/573.html)|
|[SWC-122](SWC-122/SWC-122.md)|缺乏适当的签名验证|[CWE-345: 数据真实性验证不足](https://cwe.mitre.org/data/definitions/345.html)|
|[SWC-121](SWC-121/SWC-121.md)|缺乏防止签名重放攻击的保护措施|[CWE-347: 不正确验证加密签名](https://cwe.mitre.org/data/definitions/347.html)|
|[SWC-120](SWC-120/SWC-120.md)|链属性的弱随机性来源|[CWE-330: 使用不足够随机的值](https://cwe.mitre.org/data/definitions/330.html)|
|[SWC-119](SWC-119/SWC-119.md)|阴影状态变量|[CWE-710: 缺乏对编码规范的正确遵循](http://cwe.mitre.org/data/definitions/710.html)|
|[SWC-118](SWC-118/SWC-118.md)|错误的构造函数名称|[CWE-665: 不正确的初始化](http://cwe.mitre.org/data/definitions/665.html)|
|[SWC-117](SWC-117/SWC-117.md)|签名可伸缩性|[CWE-347: 不正确的加密签名验证](https://cwe.mitre.org/data/definitions/347.html)|
|[SWC-116](SWC-116/SWC-116.md)|将区块值作为时间的代理|[CWE-829: 从不可信控制领域包含功能](https://cwe.mitre.org/data/definitions/829.html)|
|[SWC-115](SWC-115/SWC-115.md)|通过tx.origin进行授权|[CWE-477: 使用已过时的函数](https://cwe.mitre.org/data/definitions/477.html)|
|[SWC-114](SWC-114/SWC-114.md)|交易订单依赖性|[CWE-362: 并发执行时使用共享资源时缺乏适当的同步（'竞态条件'）](https://cwe.mitre.org/data/definitions/362.html)|
|[SWC-113](SWC-113/SWC-113.md)|拒绝服务与失败的呼叫|[CWE-703: 异常条件的不当检查或处理](https://cwe.mitre.org/data/definitions/703.html)|[send_loop.sol]|
|[SWC-112](SWC-112/SWC-112.md)|将委托调用给不受信任的被调用方|[CWE-829: 包含来自不受信任的控制领域的功能](https://cwe.mitre.org/data/definitions/829.html)|
|[SWC-111](SWC-111/SWC-111.md)|使用已弃用的Solidity函数|[CWE-477：使用过时的函数](https://cwe.mitre.org/data/definitions/477.html)|
|[SWC-110](SWC-110/SWC-110.md)|断言违规|[CWE-670: 始终不正确的控制流实现](https://cwe.mitre.org/data/definitions/670.html)|
|[SWC-109](SWC-109/SWC-109.md)|未初始化的存储指针|[CWE-824: 访问未初始化的指针](https://cwe.mitre.org/data/definitions/824.html)|
|[SWC-108](SWC-108/SWC-108.md)|状态变量默认可见性|[CWE-710: 编码标准不当的遵循](https://cwe.mitre.org/data/definitions/710.html)|
|[SWC-107](SWC-107/SWC-107.md)|重入性|[CWE-841: 不正确的行为工作流强制执行](https://cwe.mitre.org/data/definitions/841.html)|
|[SWC-106](SWC-106/SWC-106.md)|未受保护的SELFDESTRUCT指令|[CWE-284: 不当的访问控制](https://cwe.mitre.org/data/definitions/284.html)|
|[SWC-105](SWC-105/SWC-105.md)|未受保护的以太提取|[CWE-284: 不当的访问控制](https://cwe.mitre.org/data/definitions/284.html)|
|[SWC-104](SWC-104/SWC-104.md)|未检查的函数调用返回值|[CWE-252: 未检查的返回值](https://cwe.mitre.org/data/definitions/252.html)|
|[SWC-103](SWC-103/SWC-103.md)|浮动指示|[CWE-664: 对资源的生命周期进行不当控制](https://cwe.mitre.org/data/definitions/664.html)|
|[SWC-102](SWC-102/SWC-102.md)|过时的编译器版本|[CWE-937: 使用已知漏洞的组件](http://cwe.mitre.org/data/definitions/937.html)|
|[SWC-101](SWC-101/SWC-101.md)|整数溢出和下溢|[CWE-682: 不正确的计算](https://cwe.mitre.org/data/definitions/682.html)|
|[SWC-100](SWC-100/SWC-100.md)|函数的默认可见性|[CWE-710: 编码规范不当](https://cwe.mitre.org/data/definitions/710.html)|