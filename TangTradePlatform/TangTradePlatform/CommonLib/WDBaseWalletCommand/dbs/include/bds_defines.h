//
//  dbs_defines.h
//  testL
//
//  Created by walker on 2017/10/14.
//  Copyright © 2017年 walker. All rights reserved.
//

#ifndef dbs_defines_h
#define dbs_defines_h


#define ERROR_NONE      0
#define ERROR_FAILED    -1

#define BDS_CHAIN_ID    "4a93e8abe6ab5f2b935d692e13eea73cdbfb288959fb41640b829d25b7f4bd84"

namespace bds
{
    namespace cli
    {
        enum api_t
        {
            wallet_api = 0,
            database_api
        };
    }
}


#endif /* dbs_defines_h */
