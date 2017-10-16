#pragma once
#ifndef __BASE_COMMAND_INCLUDE__
#define __BASE_COMMAND_INCLUDE__

///钱包API
//根据账户名称获取账户信息,account_name
#define CMD_GET_ACCOUNT "get_account %s"
//查询转账列表含转出和转入的BDS,account_name limit 最大100
#define CMD_GET_ACCOUNT_HISTORY "get_account_history %s %d"
//转账操作,参数 from，to，amount，symbol，memo，true
#define CMD_TRANSFER "transfer %s %s %s %s %s %s"
//买入操作,参数 buyer_account,base,quote,rate,amount,broadcast
#define CMD_BUY  "buy %s %s %s %s %s %s"
//卖出操作,参数 saller_account,base,quote,rate,amount,broadcast
#define CMD_SELL "sell %s %s %s %s %s %s"
//取消挂单操作,参数 order_id,broadcast
#define CMD_CANCAL "cancel_order %s %s"
//查询账户余额，参数 account_name
#define CMD_LIST_ACCOUNT_BALANCES  "list_account_balances %s"
//扫描区块信息
#define CMD_INFO  "info"
//查询最近的10个区块信息,参数block_num 区块号
#define CMD_GET_BLOCK "get_block %s"
//查询44种费用率
#define CMD_GET_OBJECT "get_object 2.0.0"
//升级账户,参数account_name, true
#define CMD_UPGRADE_ACCOUNT  "upgrade_account %s %s"
//查询现在所有的资产符号列表,最大100
#define CMD_LIST_ASSETS  "list_assets \"\" %d"
//查询返回市场订单，关于货币base和quote列表
#define CMD_GET_ORDER_BOOK "get_order_book %s %s %d"
//在特定的时间内以特定的汇率出售一定数量的资产的提议，参数 base， quote, limit 可撤销
#define CMD_GET_LIMIT_ORDERS "get_limit_orders %s %s %d"
//结算订单，从最早的结算日到最新的订单 参数asset_id ,limit
#define CMD_GET_SETTLE_ORDERS "get_settle_orders %s %d"
//查询货币喂价：参数只能资产符号如：CNY
#define CMD_GET_BITASSET_DATA "get_bitasset_data %s"
//导入key,参数 account_name_or_id, wif_key
#define CMD_IMPORT_KEY "import_key %s %s"
//导入账户余额,参数 account_name_or_id, wif_key, broadcast=true
#define CMD_IMPORT_BALANMCE "import_balance %s %saller_account %s"
//打印钱包的公key和私key
#define CMD_DUMP_PRIVATE_KEYS  "dump_private_keys"
//生成brain key
#define CMD_SUGGEST_BRAIN_KEY  "suggest_brain_key"
//载入钱包,参数 钱包文件名
#define CMD_LOAD_WALLET_FILE  "load_wallet_file %s"
//保存钱包，参数 钱包文件名
#define CMD_SAVE_SALLET_FILE   "save_wallet_file %s"
//获取所有账户id,参数获取的最大数量,最大值1000
#define CMD_LIST_ACCOUNTS  "list_accounts \"\" %d"
//设置钱包密码,参数 密码字符串
#define CMD_SET_PASSWORD  "set_password %s"
//解锁,参数密码
#define CMD_UNLOCK  "unlock %s"
//加锁,无参数
#define CMD_LOCK "lock"


///db api
//根据资产货币符号名称如CNY 查询资产id
#define CMD_LOOKUP_ASSET_SYMBOLS "lookup_asset_symbols [%s]"
//返回市场资产最近的撮合交易A：assetB,参数 assetA，assetB,starttime,stoptime,limit
#define CMD_GET_TRADE_HISTORY "get_trade_history %s %s %s %s %d"
//返回市场撮合资产,参数 base,quote
#define CMD_GET_TRADE "get_ticker %s %s"
//返回市场24hr Volume,参数 base，quote
#define CMD_GET_24HR  "get_24_volume %s %s"
//K线数据，参数base,quote,bucket, start_time,end_time
#define CMD_GET_MARKET_HISTORY "get_market_history %s %s %d %s %s"

#endif /*__BASE_COMMAND_INCLUDE__*/
