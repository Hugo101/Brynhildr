Powershell.exe -executionpolicy remotesigned -File "checkpython.ps1"
if exist "python-3.6.3-amd64-webinstall.exe" (
python-3.6.3-amd64-webinstall.exe InstallAllUsers=0 PrependPath=1 Include_pip=1 Include_launcher=0 Include_test=0 SimpleInstall=1 SimpleInstallDescription="Just for me, no test suite."
del /f /q python-3.6.3-amd64-webinstall.exe
)