# QPID
This is production ready docker image for apache qpid broker via official ubuntu ppa

## Custom entrypoint
You need use your entrypoint.sh for qpid-config

##### Example entrypoint.sh
```bash
#!/bin/bash
echo 'I am alive'
# Waiting qpid deamon
sleep 5
echo 'I am starting qpid-config'\n\
qpid-config --durable add queue my_queue
echo 'The queues created'
```

##### Basic
```bash
docker run --entrypoint="qpid" diamon/qpid
```

## How to change default password?
```bash
$ git clone https://github.com/zhilyaev/qpid.git
$ cd qpid
$ docker build --build-arg qpid_admin_pass=12346 --build-arg qpid_user_pass=password124 -t your_name_image .
```
