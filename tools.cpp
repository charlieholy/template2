#define LOGO(COLOR,LEVEL,FMT,...) do{\
										time_t now;\
										char szTime[32];\
										time(&now);\
										strftime(szTime, sizeof(szTime), "%Y-%m-%d %H:%M:%S", localtime(&now) );\
										fprintf(stdout, "%s%s [%s] %s:%d " FMT, COLOR, szTime, LEVEL, __FILE__, __LINE__, ##__VA_ARGS__);\
										fflush(stdout);\
									}while(0)

#define LOGD(fmt,...) LOGO("\033[0;33;40m", "DEBUG", fmt, ##__VA_ARGS__)
#define LOGI(fmt,...) LOGO("\033[0;32;40m", "INFO ", fmt, ##__VA_ARGS__)
#define LOGE(fmt,...) LOGO("\033[0;31;40m", "ERROR", fmt, ##__VA_ARGS__)
