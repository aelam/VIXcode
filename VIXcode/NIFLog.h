//
//  Created by Ryan W. on 10-7-28.
//

#define _NIF_LOG(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
 
#ifdef DEBUG
	#define NIF_TRACE(fmt, ...) NSLog(@" [LINE:%d] %s " fmt,__LINE__,__FUNCTION__, ##__VA_ARGS__)
#else
	#define NIF_TRACE(fmt, ...)
#endif

#define NIF_INFO(fmt, ...)  NSLog(@"- %s [LINE:%d]" fmt,__FUNCTION__,__LINE__, ##__VA_ARGS__)
#define NIF_ERROR(fmt, ...) NSLog(@"! %s [LINE:%d]" fmt,__FUNCTION__,__LINE__, ##__VA_ARGS__)

