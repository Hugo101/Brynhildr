# may need execute "Set-ExecutionPolicy unrestricted" under a powershell of administrator
get-command "python" >$null 2>&1
if ( $? -eq $False) {
    $dir=pwd|findstr ":"
    $dir=$dir.Trim()
    $filename="python-3.6.3-amd64-webinstall.exe"
    $url="https://www.python.org/ftp/python/3.6.3/python-3.6.3-amd64-webinstall.exe"
    $WC = New-Object System.Net.WebClient
    $WC.UseDefaultCredentials = $true
    $WC.DownloadFile($url, "$dir\$filename")
}
