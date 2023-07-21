#<center> SWC注册表</center>
##<center> 智能合约弱点分类与测试案例</center>
以下表格概述了SWC注册表。每一行包含一个SWC标识符（ID），弱点标题，CWE父级和相关代码示例列表。ID和测试用例列中的链接指向相应的SWC定义。关系列中的链接指向CWE基本类型或类别。

| ID | Title | Relationships | Test cases |
|---|---|---|---|
|SWC-136|未加密的私有数据上链|[CWE-767: 通过公共方法访问关键私有变量](https://cwe.mitre.org/data/definitions/767.html)| [odd_even.sol]( https://swcregistry.io/docs/SWC-136#odd-evensol) <br> [odd_even_fixed.sol](https://swcregistry.io/docs/SWC-136#odd-even-fixedsol)|
|SWC-135|没有效果的代码|[CWE-1164: 无关代码](https://cwe.mitre.org/data/definitions/1164.html)|[deposit_box.sol](https://swcregistry.io/docs/SWC-135#deposit-boxsol) <br>[deposit_box_fixed.sol](https://swcregistry.io/docs/SWC-135#deposit-box-fixedsol)<br> [wallet.sol](https://swcregistry.io/docs/SWC-135#walletsol)<br> [wallet_fixed.sol](https://swcregistry.io/docs/SWC-135#wallet-fixedsol)|
|SWC-134|使用硬编码的gas数量进行消息调用|[CWE-655: 不正确的初始化](https://cwe.mitre.org/data/definitions/767.html)|[hardcoded_gas_limits.sol](https://swcregistry.io/docs/SWC-135#deposit-boxsol)|
|SWC-133|多个变长参数的哈希碰撞|[CWE-294: 通过捕获重放绕过身份验证](https://cwe.mitre.org/data/definitions/294.html)|[access_control.sol](https://swcregistry.io/docs/SWC-133#access-controlsol)<br>[access_control_fixed_1.sol](https://swcregistry.io/docs/SWC-133#access-control-fixed-1sol)<br>[access_control_fixed_2.sol](https://swcregistry.io/docs/SWC-133#access-control-fixed-2sol)|
|SWC-132|意外的以太余额|[CWE-667：不正确的锁定](https://cwe.mitre.org/data/definitions/667.html)|[Lockdrop.sol](https://swcregistry.io/docs/SWC-132#lockdropsol)|
|SWC-131|存在未使用的变量|[CWE-1164: 无关代码](https://cwe.mitre.org/data/definitions/1164.html)|[unused_state_variables.sol]( https://swcregistry.io/docs/SWC-131#unused-state-variablessol) <br> [unused_state_variables_fixed.sol](https://swcregistry.io/docs/SWC-131#unused-state-variables-fixedsol)<br>[unused_variables.sol](https://swcregistry.io/docs/SWC-131#unused-variablessol)  <br>[unused_variables_fixed.sol](https://swcregistry.io/docs/SWC-131#unused-variables-fixedsol)|
|SWC-130|从右到左覆盖控制字符（U+202E）|[CWE-451：用户界面（UI）对关键信息的误传](http://cwe.mitre.org/data/definitions/451.html)|[guess_the_number.sol](https://swcregistry.io/docs/SWC-130#guess-the-numbersol)|
|SWC-129|印刷错误|[CWE-480: 使用错误的运算符](https://cwe.mitre.org/data/definitions/480.html)|[typo_one_command.sol](https://swcregistry.io/docs/SWC-129#typo-one-commandsol)<br>[typo_safe_math.sol](https://swcregistry.io/docs/SWC-129#typo-safe-mathsol)<br>[typo_simple.sol](https://swcregistry.io/docs/SWC-129#typo-simplesol)|
|SWC-128|使用区块燃气限制进行拒绝服务攻击（DoS）|[CWE-400: 未受控制的资源消耗](https://cwe.mitre.org/data/definitions/400.html)|[dos_address.sol](https://swcregistry.io/docs/SWC-128#dos-addresssol)<br>[dos_number.sol](https://swcregistry.io/docs/SWC-128#dos-numbersol)<br>[dos_simple.sol](https://swcregistry.io/docs/SWC-128#dos-simplesol)|
|SWC-127|使用函数类型变量进行任意跳转|[CWE-695：使用低级功能](https://cwe.mitre.org/data/definitions/695.html)|[FunctionTypes.sol](https://swcregistry.io/docs/SWC-127#functiontypessol)|
|SWC-126|不足的燃气欺诈|[CWE-691：不足的控制流管理](https://cwe.mitre.org/data/definitions/691.html)|[relayer.sol] <br> [relayer_fixed.sol]|
|SWC-125|错误的继承顺序|[CWE-696：错误的行为顺序](https://cwe.mitre.org/data/definitions/696.html)|[MDTCrowdsale.sol]|
|SWC-124|写入任意存储位置|[CWE-123: 写入任意存储位置](https://cwe.mitre.org/data/definitions/123.html)|[arbitrary_location_write_simple.sol] <br> [arbitrary_location_write_simple_fixed.sol]| <br> [mapping_write.sol]|
|SWC-123|违反要求|[CWE-573: 调用方不正确地遵循规范](https://cwe.mitre.org/data/definitions/573.html)|[requirement_simple.sol] <br> [requirement_simple_fixed.sol]|
|SWC-122|缺乏适当的签名验证|[CWE-345: 数据真实性验证不足](https://cwe.mitre.org/data/definitions/345.html)|
|SWC-121|缺乏防止签名重放攻击的保护措施|[CWE-347: 不正确验证加密签名](https://cwe.mitre.org/data/definitions/347.html)|
|SWC-120|链属性的弱随机性来源|[CWE-330: 使用不足够随机的值](https://cwe.mitre.org/data/definitions/330.html)|[guess_the_random_number.sol] <br> [guess_the_random_number_fixed.sol] <br> [old_blockhash.sol] <br> [old_blockhash_fixed.sol] <br> [random_number_generator.sol]|
|SWC-119|阴影状态变量|[CWE-710: 缺乏对编码规范的正确遵循](http://cwe.mitre.org/data/definitions/710.html)|[ShadowingInFunctions.sol] <br> [TokenSale.sol] <br> [TokenSale_fixed.sol]|
|SWC-118|错误的构造函数名称|[CWE-665: 不正确的初始化](http://cwe.mitre.org/data/definitions/665.html)|[incorrect_constructor_name1.sol] <br> [incorrect_constructor_name1_fixed.sol] <br> [incorrect_constructor_name2.sol] <br> [incorrect_constructor_name2_fixed.sol]|
|SWC-117|签名可伸缩性|[CWE-347: 不正确的加密签名验证](https://cwe.mitre.org/data/definitions/347.html)|[incorrect_constructor_name1.sol] <br> [incorrect_constructor_name1_fixed.sol]|
|SWC-116|将区块值作为时间的代理|[CWE-829: 从不可信控制领域包含功能](https://cwe.mitre.org/data/definitions/829.html)|[time_lock.sol] <br> [timed_crowdsale.sol]|
|SWC-115|通过tx.origin进行授权|[CWE-477: 使用已过时的函数](https://cwe.mitre.org/data/definitions/477.html)|[mycontract.sol] <br> [mycontract_fixed.sol]|
|SWC-114|交易订单依赖性|[CWE-362: 并发执行时使用共享资源时缺乏适当的同步（'竞态条件'）](https://cwe.mitre.org/data/definitions/362.html)|[ERC20.sol] <br> [eth_tx_order_dependence_minimal.sol]|
|SWC-113|拒绝服务与失败的呼叫|[CWE-703: 异常条件的不当检查或处理](https://cwe.mitre.org/data/definitions/703.html)|[send_loop.sol]|
|SWC-112|将委托调用给不受信任的被调用方|[CWE-829: 包含来自不受信任的控制领域的功能](https://cwe.mitre.org/data/definitions/829.html)|[proxy.sol] <br> [proxy_fixed.sol] <br> [proxy_pattern_false_positive.sol]|
|SWC-111|使用已弃用的Solidity函数|[CWE-477：使用过时的函数](https://cwe.mitre.org/data/definitions/477.html)|[deprecated_simple.sol] <br> [deprecated_simple_fixed.sol]|
|SWC-110|断言违规|[CWE-670: 始终不正确的控制流实现](https://cwe.mitre.org/data/definitions/670.html)|[assert_constructor.sol] <br> [assert_minimal.sol] <br> [assert_multitx_1.sol] <br> [assert_multitx_2.sol] <br> [constructor_create.sol] <br> [constructor_create_argument.sol] <br> [constructor_create_modifiable.sol] <br> [gas_model.sol] <br> [gas_model_fixed.sol] <br> [mapping_perfomance_2.sol] <br> [mapping_performance_1.sol] <br> [out-of-bounds-exception.sol] <br> [return_memory.sol] <br> [runtime_create_user_input.sol] <br> [runtime_user_input_call.sol] <br> [sha_of_sha_2_mappings.sol] <br> [sha_of_sha_collision.sol] <br> [sha_of_sha_concrete.sol] <br> [token-with-backdoor.sol] <br> [two_mapppings.sol] <br> [simpledschief.sol] |
|SWC-109|未初始化的存储指针|[CWE-824: 访问未初始化的指针](https://cwe.mitre.org/data/definitions/824.html)|[crypto_roulette.sol] <br> [crypto_roulette_fixed.sol]|
|SWC-108|状态变量默认可见性|[CWE-710: 编码标准不当的遵循](https://cwe.mitre.org/data/definitions/710.html)|[storage.sol]|
|SWC-107|重入性|[CWE-841: 不正确的行为工作流强制执行](https://cwe.mitre.org/data/definitions/841.html)|[modifier_reentrancy.sol] <br> [modifier_reentrancy_fixed.sol] <br> [simple_dao.sol] <br> [simple_dao_fixed.sol]|
|SWC-106|未受保护的SELFDESTRUCT指令|[CWE-284: 不当的访问控制](https://cwe.mitre.org/data/definitions/284.html)|[WalletLibrary.sol] <br> [simple_suicide.sol] <br> [suicide_multitx_feasible.sol] <br> [suicide_multitx_infeasible.sol]|
|SWC-105|未受保护的以太提取|[CWE-284: 不当的访问控制](https://cwe.mitre.org/data/definitions/284.html)|[tokensalechallenge.sol] <br> [rubixi.sol] <br> [multiowned_not_vulnerable.sol] <br> [multiowned_vulnerable.sol] <br> [simple_ether_drain.sol] <br> [wallet_01_ok.sol] <br> [wallet_02_refund_nosub.sol] <br> [wallet_03_wrong_constructor.sol] <br> [wallet_04_confused_sign.sol]|
|SWC-104|未检查的函数调用返回值|[CWE-252: 未检查的返回值](https://cwe.mitre.org/data/definitions/252.html)|[unchecked_return_value.sol]|
|SWC-103|浮动指示|[CWE-664: 对资源的生命周期进行不当控制](https://cwe.mitre.org/data/definitions/664.html)|[floating_pragma.sol] <br> [floating_pragma_fixed.sol] <br> [no_pragma.sol] <br> [semver_floating_pragma.sol] <br> [semver_floating_pragma_fixed.sol]|
|SWC-102|过时的编译器版本|[CWE-937: 使用已知漏洞的组件](http://cwe.mitre.org/data/definitions/937.html)|[version_0_4_13.sol]|
|SWC-101|整数溢出和下溢|[CWE-682: 不正确的计算](https://cwe.mitre.org/data/definitions/682.html)|[tokensalechallenge.sol] <br> [integer_overflow_mapping_sym_1.sol] <br> [integer_overflow_mapping_sym_1_fixed.sol] <br> [integer_overflow_minimal.sol] <br> 