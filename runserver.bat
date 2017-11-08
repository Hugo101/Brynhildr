cd Brynhildr
start /b cmd /c call "python.exe" "run.py" > "..\brynhildr_run.log" 2>"..\brynhildr_error.log"
echo "Backend started"
cd ../Sigrdrifa
start /b cmd /c call "python.exe" "-m" "http.server" "8000" > "..\sigrdrifa_run.log" 2>"..\sigrdrifa_error.log"
echo "Frontend started"
