//
//  cli.h
//  testL
//
//  Created by walker on 2017/10/14.
//  Copyright © 2017年 walker. All rights reserved.
//

#ifndef bds_cli_h
#define bds_cli_h


#include <string>
#include "bds_defines.h"


namespace bds
{
    namespace cli
    {
        class wallet_pri;
        
        class wallet
        {
        public:
            wallet();
            
            int init(char* sz_chain_id, char* sz_ws_server);
            
            void uninit();
            
            int run_command(api_t api, std::string& line, std::string& res);
            
        private:
            std::shared_ptr<wallet_pri>  ptr_wallet_;
            
        };
    }
}


#endif /* bds_cli_h */
