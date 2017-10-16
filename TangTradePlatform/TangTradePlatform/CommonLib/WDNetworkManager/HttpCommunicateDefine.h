//http后缀
typedef NS_ENUM(NSInteger,HTTP_COMMAND_LIST){
    HTTP_COMMAND_LIST_Register,//注册
    HTTP_COMMAND_LIST_Login,//登录
    HTTP_COMMAND_LIST_History,//交易历史记录
    HTTP_COMMAND_LIST_Receive_Change,//接收历史记录
    HTTP_COMMAND_LIST_Service_Charge,//交易手续费
    /*******************/
    HTTP_METHOD_RESERVE,
    HTTP_METHOD_COUNT,
};

//#ifdef __ONLY_FOR_HTTP_COMMUNICATE__
//   NSString *urlString = @"http://173.15.20.186:80/upf/TMemberController.do?isSignUser";  ****************************************************************************/

static char cHttpMethod[HTTP_METHOD_COUNT][256] = {
    "account_create",//注册
    "account_login",//登录
    "get_account_history",//交易历史记录
    "get_receive_exchange",//接收历史记录
    "get_fees",//交易手续费
};

//WebSocket后缀
typedef NS_ENUM(NSInteger,WebSocket_COMMAND_LIST){
    WebSocket_COMMAND_LIST_TradeFor24Hour,
    /*******************/
    WebSocket_METHOD_RESERVE,
    WebSocket_METHOD_COUNT,
};

//#ifdef __ONLY_FOR_HTTP_COMMUNICATE__
//   NSString *urlString = @"http://173.15.20.186:80/upf/TMemberController.do?isSignUser";  ****************************************************************************/

static char cWebSocketMethod[WebSocket_METHOD_COUNT][256] = {
    "get_24_volume",//24小时市场行情
};

