FROM zengmingjian/code-server:0.0.11

CMD ["--bind-addr=0.0.0.0:8080"]
ENTRYPOINT ["bootstrap"]
