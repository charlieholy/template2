output/bin/ffmpeg -i video.mp4 -an video.yuv
ffplay -video_size 854_480 yuv_file.yuv

static FILE *yuv_file;
yuv_file = fopen("yuv_file.yuv420p","wb");

    av_log(NULL,AV_LOG_INFO,"charlie key_frame: %d\n",decoded_frame->key_frame);
    av_log(NULL,AV_LOG_INFO,"charlie pict_type : %d\n",decoded_frame->pict_type);
    av_log(NULL,AV_LOG_INFO,"charlie width : %d\n",decoded_frame->width);
    av_log(NULL,AV_LOG_INFO,"charlie height : %d\n",decoded_frame->height);
    av_log(NULL,AV_LOG_INFO,"charlie format name : %s\n",av_get_pix_fmt_name(decoded_frame->format));

    uint32_t pitchY = decoded_frame->linesize[0];
    uint32_t pitchU = decoded_frame->linesize[1];
    uint32_t pitchV = decoded_frame->linesize[2];
    av_log(NULL,AV_LOG_INFO,"charlie pitchY: %d\n",pitchY);
    av_log(NULL,AV_LOG_INFO,"charlie pitchU: %d\n",pitchU);
    av_log(NULL,AV_LOG_INFO,"charlie pitchV: %d\n",pitchV);
    uint8_t *avY = decoded_frame->data[0];
    uint8_t *avU = decoded_frame->data[1];
    uint8_t *avV = decoded_frame->data[2];


    char dumpbuf[4096] = {0};
    for(int i=0;i<decoded_frame->width;i++)
    {
        sprintf(dumpbuf+i*3,"%02x ",*(avY+i)&0xff);
    }
    //av_log(NULL,AV_LOG_INFO,"dumpbuf: %s\n",dumpbuf);

    for (uint32_t i = 0; i < decoded_frame->height; i++) {
        fwrite(avY, decoded_frame->width, 1, yuv_file);
        avY += pitchY;
    }
 
    for (uint32_t i = 0; i < decoded_frame->height/2; i++) {
        fwrite(avU, decoded_frame->width/2, 1, yuv_file);
        avU += pitchU;
    }
 
    for (uint32_t i = 0; i < decoded_frame->height/2; i++) {
        fwrite(avV, decoded_frame->width/2, 1, yuv_file);
        avV += pitchV;
    }
