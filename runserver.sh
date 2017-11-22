pip3 install -r requirements.txt
ps -ef|grep python3|grep 'http.server 8000'|awk '{print $2}'|xargs -I{} kill -9 {}
ps -ef|grep python3|grep 'run.py'|awk '{print $2}'|xargs -I{} kill -9 {}
cd Brynhildr
python3 run.py > ../brynhildr_run.log 2>../brynhildr_error.log &
echo "Backend started"
cd ../Sigrdrifa
python3 -m http.server 8000 > ../sigrdrifa_run.log 2>../sigrdrifa_error.log &
echo "Frontend started"
