#<center> SWC Registry</center>
##<center> Smart Contract Weakness Classification and Test Cases
</center>
以下表格概述了SWC注册表。每一行包含一个SWC标识符（ID），弱点标题，CWE父级和相关代码示例列表。ID和测试用例列中的链接指向相应的SWC定义。关系列中的链接指向CWE基本类型或类别。

| ID | Title | Relationships | Test cases |
|---|---|---|---|
|SWC-136|未加密的私有数据上链|[CWE-767: 通过公共方法访问关键私有变量](https://cwe.mitre.org/data/definitions/767.html)| [odd_even.sol]( https://swcregistry.io/docs/SWC-136#odd-evensol) [odd_even_fixed.sol](https://swcregistry.io/docs/SWC-136#odd-even-fixedsol)|
|SWC-135|没有效果的代码|[CWE-1164: 无关代码](https://cwe.mitre.org/data/definitions/1164.html)| [deposit_box.sol](https://swcregistry.io/docs/SWC-135#deposit-boxsol) [deposit_box_fixed.sol](https://swcregistry.io/docs/SWC-135#deposit-box-fixedsol)[wallet.sol](https://swcregistry.io/docs/SWC-135#walletsol) [wallet_fixed.sol](https://swcregistry.io/docs/SWC-135#wallet-fixedsol)