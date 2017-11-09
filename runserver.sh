pip3 install -r requirements.txt
cd Brynhildr
python3 run.py > ../brynhildr_run.log 2>../brynhildr_error.log &
echo "Backend started"
cd ../Sigrdrifa
python3 -m http.server 8000 > ../sigrdrifa_run.log 2>../sigrdrifa_error.log &
echo "Frontend started"
