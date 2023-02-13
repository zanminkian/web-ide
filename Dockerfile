FROM zengmingjian/web-ide:0.1.0

CMD ["--bind-addr=0.0.0.0:8080"]
ENTRYPOINT ["bootstrap"]
