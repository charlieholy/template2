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


////ijksdl_log移植
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

////av_log移植
#define av_log(avcl, level, fmt,...)  av_log_with_line(avcl,level,__FILE__,__LINE__,fmt,##__VA_ARGS__)

//void av_log(void *avcl, int level, const char *fmt, ...); //av_printf_format(3, 4);
void av_log_with_line(void *avcl, int level, const char* file, int line, const char *fmt, ...); 

void av_log_with_line(void *avcl, int level, const char* file, int line, const char *fmt, ...)
{
    AVClass* avc = avcl ? *(AVClass **) avcl : NULL;
    va_list vl;
    va_start(vl, fmt);
    if (avc && avc->version >= (50 << 16 | 15 << 8 | 2) &&
        avc->log_level_offset_offset && level >= AV_LOG_FATAL)
        level += *(int *) (((uint8_t *) avcl) + avc->log_level_offset_offset);
    char buf[1024] = {0};
    snprintf(buf,1024,"%s:%d %s",file,line,fmt);
    av_vlog(avcl, level, buf, vl);
}

///////ffprobe -v debug ~/opt/kyzx/video.mp4  查看ffmpeg的debug日志
