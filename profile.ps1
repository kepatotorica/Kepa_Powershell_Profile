#If your profile is in another location than edit do the following
# run the following
#  PWD (FROM WITHIN THE REPO)
#      use the result of PWD as the path in the next command + \profile.ps1
#  code $Profile
# Then paste this into the editor opened from the last command (with the edits from the PWD step)
#    $fileContents = [string]::join([environment]::newline, (get-content -path C:\Users\kepat\Kepa_Powershell_Profile\profile.ps1))
#    invoke-expression $fileContents


oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\patriksvensson.omp.json" | Invoke-Expression

$PROFILE_LOCATION = "C:\Users\kepat\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$BASH_HOME = $Home
$pcty = "C:\Paylocity"
function pay { set-location "$pcty" }
function edit { code "$PROFILE_LOCATION" }
function editTerminal { code "$PROFILE_LOCATION" }

#PS
function source { Invoke-Expression ". $PROFILE_LOCATION" }

#git
function logpretty { Invoke-Expression "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all" }
function oneline { Invoke-Expression "git log --oneline" }
function rmorig { Invoke-Expression "Get-ChildItem -Recurse -Filter '*.orig' | Remove-Item" }
function fetch { Invoke-Expression "git fetch --all" }
function gitreset { Invoke-Expression "git reset --hard " }
function status { Invoke-Expression "git status " }
function merge { Invoke-Expression "git mergetool; rmorig" }
function Merge { Invoke-Expression "git mergetool; rmorig" }
function vsmerge { Invoke-Expression "git mergetool vscode; rmorig" }
function cleanrepo { Invoke-Expression "echo 'git clean -fdx'; temp; git reset --hard; git clean -fdx" }
function gitclean { Invoke-Expression "echo 'git clean -fdx'; temp; git reset --hard; git clean -fdx" }
function temp { Invoke-Expression "git branch -d temp; git checkout -b temp; git checkout -" }
function master { Invoke-Expression "git checkout master; git pull" }
# https:\\stackoverflow.com\questions\5189560\squash-my-last-x-commits-together-using-git\5201642#5201642
function squash { Invoke-Expression "echo 'git reset --soft HEAD~1 && git commit'" }
function cc { Invoke-Expression "echo 'git reset --soft HEAD~1 && git commit, use cc(num commits to squash)'" }
function ccb { Invoke-Expression "git reset HEAD@{1}" }
function cc1 { Invoke-Expression "git reset --soft HEAD~1" }
function cc2 { Invoke-Expression "git reset --soft HEAD~2" }
function cc3 { Invoke-Expression "git reset --soft HEAD~3" }
function cc4 { Invoke-Expression "git reset --soft HEAD~4" }
function cc5 { Invoke-Expression "git reset --soft HEAD~5" }
function cc6 { Invoke-Expression "git reset --soft HEAD~6" }
function cc7 { Invoke-Expression "git reset --soft HEAD~7" }

#Explorer
function cdDownloads { Invoke-Expression 'cd $BASH_HOME\Downloads' }
function downloads { Invoke-Expression 'cd $BASH_HOME\Downloads' }
function Downloads { Invoke-Expression 'cd $BASH_HOME\Downloads' }
function desktop { Invoke-Expression 'cd $BASH_HOME\OneDrive\Desktop' }
function Desktop { Invoke-Expression 'cd $BASH_HOME\OneDrive\Desktop' }
function open { Invoke-Expression "explorer ." }
function smartcopy {
    $sourceDirectory = Read-Host -Prompt "Enter the source directory (e.g., \\This PC\Switch\4: Installed games)"
    $destinationDirectory = Read-Host -Prompt "Enter the destination directory (e.g., D:\a emulation\Switch\games)"
    robocopy "$sourceDirectory" "$destinationDirectory" /XO /E

    Write-Host "Files copied from '$sourceDirectory' to '$destinationDirectory'"
    Read-Host -Prompt "Press Enter to exit..."
}

#Expo
# $moveToHoppyDays = "cd C:\Users\kepat\hoppy-days-monorepo\hoppy-days;"
function androidDebug { Invoke-Expression 'adb shell input keyevent 82' }
function debugAndroid { Invoke-Expression 'adb shell input keyevent 82' }
function debug { Invoke-Expression "adb shell input keyevent 82" }
function publish { Invoke-Expression "eas submit" }
function submitAndroid { Invoke-Expression "eas submit -p android --latest" }
function publishAndroid { Invoke-Expression "eas submit -p android --latest" }
function publishIos { Invoke-Expression "eas submit -p ios" }
function submitIos { Invoke-Expression "eas submit -p ios" }
function cleanExpo { Invoke-Expression "expo r -c;" }
function expoCache { Invoke-Expression "expo r -c;" }
function easBuildDevelopment { Invoke-Expression "eas build --profile development --platform android" }
function buildDev { Invoke-Expression "eas build --profile development --platform android" }
function buildDevAndroid { Invoke-Expression "eas build --profile development --platform android" }
function buildDevIos { Invoke-Expression "eas build --profile development --platform ios" }
function buildIos { Invoke-Expression "eas build -p ios" }
function buildAndroid { Invoke-Expression "eas build -p android" }
function buildAndroidLocal { Invoke-Expression "wsl; cd /mnt/c/Users/kepat/free-games-sonar/free-game-sonar; eas build --platform android --local" }
function runDevelop { Invoke-Expression "npx expo start --dev-client" }
function runDev { Invoke-Expression "npx expo start --dev-client" }

#General
function settings { Invoke-Expression "code $BASH_HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" }
function reset { Invoke-Expression ". $PROFILE_LOCATION" }

function waitSeconds {
    $multiple = $Args[0] * 60
    Start-Sleep $multiple;
}

function wait {
    $multiple = $Args[0] * 60
    Start-Sleep $multiple;
}
function waitMinutes {
    $multiple = $Args[0] * 60
    Start-Sleep $multiple;
}

function waitHours {
    $multiple = $Args[0] * 60 * 60
    Start-Sleep $multiple;
}

function commit {
    rmorig
    $BRANCH_NAME = GetTicketNumber;
    if ($BRANCH_NAME -ne "master") {
        Invoke-Expression "git add ."
        if ($BRANCH_NAME) {
            $BRANCH_NAME = "${BRANCH_NAME}: "
        }
        Write-Host "git commit -am ""${BRANCH_NAME}$Args""" -ForegroundColor DarkGray

        Invoke-Expression "git commit -am ""${BRANCH_NAME}$Args"""
    }
    else {
        Write-Host  "You should not be commiting on master!!!" -ForegroundColor DarkRed
    }       
}

function buildSubmit {
    # Invoke-Expression "$moveToHoppyDays"
    rmorig
    $confirm = Read-Host "Have you incremented the build number? (y/n)"
    if ($confirm -ne "y") {
        Write-Host "Build process aborted." -ForegroundColor DarkRed
        return
    }

    $BRANCH_NAME = GetTicketNumber;
    if ($BRANCH_NAME -ne "main") {
        Write-Host  "$BRANCH_NAME Only submit builds from main!!!" -ForegroundColor DarkRed
    }
    else {
        Invoke-Expression "git pull"
        # Invoke-Expression "eas build -p android; eas submit -p android --latest"
        Invoke-Expression "eas build -p ios; eas submit -p ios --latest; eas build -p android; eas submit -p android --latest"
        Write-Host "git commit -am ""New Build and Submissions for IOS and Android""" -ForegroundColor DarkGray
        Invoke-Expression "git push"
    }       
}

function GetTicketNumber {
    $Branch = (Invoke-Expression "git symbolic-ref --short HEAD");
    if ($Branch -eq "main") {
        "main"
    }
    else {
        $list = (($Branch -split '/')[1] -split '-')
        $list[0] + "-" + $list[1]
    }
}

function mp4tomp3 {
    param (
        [string]$inputFile
    )

    # Construct the full path
    $inputFile = Join-Path (Get-Location) $inputFile

    # Check if the input file exists
    if (Test-Path $inputFile -PathType Leaf) {
        $outputFile = $inputFile -replace '.mp4', '.mp3'
        ffmpeg -i "$inputFile" -q:a 0 -map a "$outputFile"
        Write-Host "Conversion complete. Output file: $outputFile"
    }
    else {
        Write-Host "Invalid file path. Please provide a valid .mp4 file path."
    }
}

function stereotomono {
    param (
        [string]$inputFile
    )

    # Construct the full path
    $inputFile = Join-Path (Get-Location) $inputFile

    # Check if the input file exists
    if (Test-Path $inputFile -PathType Leaf) {
        $outputFile = $inputFile -replace '.mp4', '_mastered.mp4'
        ffmpeg -i "$inputFile" -af "pan=mono|c0=FL" -c:v copy "$outputFile"        
        Write-Host "Conversion complete. Output file: $outputFile"
    }
    else {
        Write-Host "Invalid file path. Please provide a valid .mp4 file path."
    }
}

function pp {
    $BRANCH_NAME = Invoke-Expression "git symbolic-ref --short HEAD"
    Write-Output "Working on branch {$BRANCH_NAME}:'r"
    BRANCH_NAME=$(git symbolic-ref --short HEAD)
    Write-Output "git push --set-upstream origin ${BRANCH_NAME}"
    git push --set-upstream origin ${BRANCH_NAME}
}

function find {
  (Get-ChildItem -Recurse -Filter $Args[0]).FullName
}

function MoveAllSubFilesToRoot {
    # Create a folder on your thumb drive (for example "E:\drive photos")
    $TopLevelFolder = "C:\Users\kepat\Downloads\backup"
    Write-Output "Operating against $TopLevelFolder to change that edit profile"

    # Define the size limit for each folder (10 GB in bytes)
    $FolderSizeLimit = 200GB #Break these up into nice chunks

    # Initialize variables
    $CurrentFolderIndex = 1
    $CurrentFolderSize = 0
    $CurrentFolderPath = "$TopLevelFolder\Folder$CurrentFolderIndex"

    # Create the first folder
    New-Item -ItemType Directory -Path $CurrentFolderPath

    # Get all files from all subfolders
    $Files = Get-ChildItem -Path $TopLevelFolder -Recurse -File

    foreach ($File in $Files) {
        $FileSize = $File.Length
   
        if (($CurrentFolderSize + $FileSize) -gt $FolderSizeLimit) {
            # Start a new folder
            $CurrentFolderIndex++
            $CurrentFolderSize = 0
            $CurrentFolderPath = "$TopLevelFolder\Folder$CurrentFolderIndex"
            New-Item -ItemType Directory -Path $CurrentFolderPath
        }

        # Move the file to the current folder
        $DestinationPath = Join-Path -Path $CurrentFolderPath -ChildPath $File.Name
        Move-Item -Path $File.FullName -Destination $DestinationPath -Force

        # Update the current folder size
        $CurrentFolderSize += $FileSize
    }


    Write-Host "Files have been moved into folders"
}

function InstallPowerShellPowerLineAndFont {
    #Needs version 2.1.0 for autocomplete Install-Module -Name PSReadLine -Scope CurrentUser -Force
    #History complete for powershell
    Uninstall-Module -Name PSReadLine -AllVersions -Force
    Install-Module -Name PSReadLine -Scope CurrentUser -Force

    #Theme for powershell
    winget install JanDeDobbeleer.OhMyPosh -s winget
    winget install --id Git.Git -e --source winget
    source
    # Might need to restart for oh-my-posh to get hit below
    oh-my-posh font install 
    # oh-my-posh font install JetBrainsMono
    # I like JetBrainsMono
    Write-Output "Exit and restart the powershell then go to windows powershell settings in terminal, then appearance then change the font to JetBrainsMono NF"
}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
