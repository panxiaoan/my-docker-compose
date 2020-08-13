FROM openjdk:8
LABEL version="Mycat-server-1.6.7.5-release-20200410174409"
LABEL maintainer="xiaoan.pan@qq.com"
LABEL description="mycat images"
ENV mycat-version Mycat-server-1.6.7.5-release-20200410174409-linux.tar.gz
USER root
COPY libs/Mycat-server-1.6.7.5-release-20200410174409-linux.tar.gz /
RUN tar -zxf /Mycat-server-1.6.7.5-release-20200410174409-linux.tar.gz
ENV MYCAT_HOME=/mycat
ENV PATH=$PATH:$MYCAT_HOME/bin
WORKDIR $MYCAT_HOME/bin
RUN chmod u+x ./mycat
EXPOSE 8066 9066
CMD ["./mycat","console"]