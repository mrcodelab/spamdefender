# version MAJ.MIN.r.yyyymm
# version 1.0.1.202206
$version = "1.0.1.202206"
$u=$env:UserName
$c=$env:COMPUTERNAME
Write-Output "Hi $u. "
$b="C:\Program Files\zAdmin"
$h = "C:\Windows\System32\drivers\etc\hosts"
Write-Host "You are running version $version of Spam Defender."
$task = Read-Host "Do you need a reboot (r) OR shutdown(s) OR keep awake(k)"
$task = $task.ToUpper()

try {
    if ( Test-Path -Path $b ) {
        Write-Host "The folder already exists."
    }
    else{
        mkdir $b
    }
}
catch {
    {1:<#Do this if a terminating exception happens#>}
}
function msdtTest {
    try {
        New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
    }
    catch {
        -ErrorAction Ignore
    }

    Set-Location -Path HKCR:\
    $keyname = "HKCR:\ms-msdt"
    if ( Get-ChildItem -Path $keyname -ErrorAction Ignore ) {
        Write-Host "it exists" -ForegroundColor Red
        Remove-Item -Recurse -Force $keyname -WhatIf
        Write-Host "MSDT is removed." -ForegroundColor Green
    }
    else {
        write-host "MSDT is already gone." -ForegroundColor Green
    }
}

function stateTogg {
    if ( $task -eq 'S' ) {
        Stop-Computer -Force
        }
    elseif ($task -eq 'R') {
        Restart-Computer -Force
        }
    else { Write-Host "Keeping awake"}
}

function gitUpdater{
    try {
        Write-Host "Updating the maintenance and security files" -ForegroundColor Yellow
        Invoke-WebRequest -Uri https://raw.githubusercontent.com/mrcodelab/spamdefender/main/spamdefender.ps1 -OutFile '$HOME\Downloads'
        $zip1 = Get-FileHash -Algorithm SHA256 $HOME\Downloads\spamdefender.ps1 | Select-Object -ExpandProperty Hash
        Invoke-WebRequest -Uri https://raw.githubusercontent.com/mrcodelab/hashes/main/sd-hash.txt -OutFile '$HOME\Downloads'
        $hash1 = Get-Content $HOME\Downloads\sd-hash.txt
        if ( $zip1 -eq $hash1 ) {
            Move-Item spamdefender.ps1 $b
            Write-Host "Spam Defender file updated." -ForegroundColor Green
        }
        else { Write-Host "The Spam Defender hash did not match! The code was not updated." -ForegroundColor Red }
    }
    catch {
        Write-Host "There was an issue updating the Spam Defender file." -ErrorAction SilentlyContinue
    }

    try {
        Invoke-WebRequest -Uri https://raw.githubusercontent.com/mrcodelab/spamdefender/main/hosts -OutFile '$HOME\Downloads'
        $zip2 = Get-FileHash -Algorithm SHA256 $HOME\Downloads\hosts | Select-Object -ExpandProperty Hash
        Invoke-WebRequest -Uri https://raw.githubusercontent.com/mrcodelab/hashes/main/sdh-hash.txt -OutFile '$HOME\Downloads'
        $hash2 = Get-Content $HOME\Downloads\hosts_hash.txt
        if ( $zip2 -eq $hash2 ) {
            $ucheck = Get-FileHash -Algorithm SHA256 $h | Select-Object -ExpandProperty Hash
            if ( $hash2 -ne $ucheck ) {
                Write-Host "The hosts file has been updated. Please disable your antivirus and re-run spamdefender to get the latest filter."
                Move-Item $Home\Downloads\hosts $h -ErrorAction SilentlyContinue
            }
            Move-Item $Home\Downloads\hosts $h
            Write-Host "Hosts file updated." -ForegroundColor Green
        }
        else { Write-Host "The host hash did not match! The host file was not updated." -ForegroundColor Red }
    }
    catch {
        Write-Host "Security file update blocked by antivirus. No biggie." -ForegroundColor White -ErrorAction SilentlyContinue
    }

}

function updater {
    Get-WUInstall -Install -AcceptAll -AutoReboot -Hide
    Get-WUInstall -MicrosoftUpdate -Install -AcceptAll -AutoReboot -Hide
}

function dldclnr {
    if( $c -ne "MightyMouse"){
        $dldclnr = Read-Host "Do you want to erase everything in the downloads folder? (Yes/No)"
        $dldclnr = $dldclnr.ToUpper()
        if( $dldclnr -eq "YES" ) {
            Remove-Item -Path $Home\Downloads\* -Recurse -Force
            Write-Host "Done cleaning downloads" -ForegroundColor Green
        }
        else{
            Write-Host "No problem, skipping this step."
        }
    }
    else { 
        Remove-Item $HOME\Downloads\*.gz -Recurse
        Write-Host "Not deleting downloads folder" 
    }
}

function cleanup {
    Set-Location $HOME
    Clear-RecycleBin -DriveLetter C -Force -ErrorAction SilentlyContinue
    Write-Host "Recycle Bin cleaned - Ignore the error. It works." -ForegroundColor Green
    Write-Host "Cleaning the temp folder." -ForegroundColor Yellow
    Remove-Item -Path C:\Windows\Temp\* -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Temp folder cleaned." -ForegroundColor Green
    Set-Location $PSScriptRoot
    Start-Process -FilePath "C:\WINDOWS\system32\cleanmgr.exe" /sagerun:1 | Out-Null
    Wait-Process -Name cleanmgr
}


function common {
    Write-Host "Testing MSDT vulnerability" -ForegroundColor Yellow
    msdtTest
    Set-Location $b
    Write-Host "Updating Windows" -ForegroundColor Yellow
    updater
    gitUpdater
    Write-Host "Windows update complete." -ForegroundColor Green
    Write-Host "Cleaning up the system bloat" -ForegroundColor Yellow
    cleanup
    Write-Host "Disk cleanup complete." - -ForegroundColor Green
    stateTogg
    Set-Location $HOME
}

Write-Host "Running common workload" -ForegroundColor Yellow

common
dldclnr
Write-Host "Thank you for using Spam Defender!"

Stop-Process -Name powershell
