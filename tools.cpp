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


#define ALOG(level, TAG, ...)  do{\
  __android_log_with_line(level,TAG,__FILE__,__LINE__,__VA_ARGS__);\
  }while(0)

void __android_log_with_line(int level, const char *tag, const char* file, int line, const char *fmt, ...)
{
    char buf[2048] = {0};
    va_list args;
    va_start(args,fmt);
    vsnprintf(buf,2048,fmt,args);
    __android_log_print(level,tag,"%s:%d %s",file,line,buf);
}

