FROM zengmingjian/web-ide:0.1.3

CMD ["--bind-addr=0.0.0.0:8080", "--disable-update-check"]
ENTRYPOINT ["bootstrap"]
