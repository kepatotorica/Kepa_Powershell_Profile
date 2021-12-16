Import-Module oh-my-posh
Set-PoshPrompt -Theme patriksvensson
# Set-PoshPrompt -Theme pararussel
# on first set up
# function InstallPowerShellPowerLineAndFont if you don't have any fonts

$PROFILE_LOCATION = "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
$BASH_HOME = "C:\Users\KTotorica"
$pcty = "C:\Paylocity"
function pay { set-location "$pcty" }
function edit { code "$PROFILE_LOCATION" }
function editTerminal { code "$PROFILE_LOCATION" }

function startupconfig { Copy-Item -Path 'C:\Users\KTotorica\Desktop\Book Notes\backup_sln.startup.json' -Destination 'C:\Paylocity\paylocity.taxfiling.transmission\src\Paylocity.TaxFiling.Transmission.sln.startup.json' }
function startup { Copy-Item -Path 'C:\Users\KTotorica\Desktop\Book Notes\backup_sln.startup.json' -Destination 'C:\Paylocity\paylocity.taxfiling.transmission\src\Paylocity.TaxFiling.Transmission.sln.startup.json' }
function zips { Invoke-Expression "cd C:\Paylocity\paylocity.taxfiling.transmission\src\Paylocity.TaxFiling.Transmission.Service\bin\paylocity.taxfiling.formgeneration.zipfiles; open ." }
function forms { Invoke-Expression "cd C:\Paylocity\paylocity.taxfiling.transmission\src\Paylocity.TaxFiling.Transmission.Service\bin; open ." }
#P
$transsrc = $pcty + "\paylocity.taxfiling.transmission\src"
function logpretty { Invoke-Expression "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all" }
function oneline { Invoke-Expression "git log --oneline" }
function checkout { Invoke-Expression "git checkout -" }
function pay { set-location "$pcty" }
function transapi { Invoke-Expression "cd $transsrc\paylocity.taxfiling.transmission.api " }
# function trans {Invoke-Expression "cd "$pcty"paylocity.taxfiling.transmission\"}
function trans { Invoke-Expression "cd $transsrc\.." }
function transdb { Invoke-Expression "cd $transsrc\paylocity.taxfiling.transmission.db" }
function transui { Invoke-Expression "cd $transsrc\paylocity.taxfiling.transmission.ui.web" }
function taxd { Invoke-Expression "cd $transsrc\paylocity.taxfiling.taxdistro " }
function setup { Invoke-Expression "cd C:\Paylocity\DevBuildTasks\; .\ConfigurationDatabaseSetup.bat; cd C:\Paylocity\Escher\DeveloperTasks\DatabaseSetup; .\ConfigurationDatabase_Deploy.bat" }
function pdfs { Invoke-Expression "cd C:\Paylocity\paylocity.taxfiling.transmission\src\Paylocity.TaxFiling.ReportGeneration.Service\bin\Debug\; start . ; echo 'most recent pdf'; ls -Art | egrep '\.pdf$' | tail -n 1; cd -" }
function rmpdfs { Invoke-Expression "cd C:\Paylocity\paylocity.taxfiling.transmission\src\Paylocity.TaxFiling.ReportGeneration.Service\bin\Debug\; rm *.pdf; cd -" }
#TODOASDF this doesn't work yet but I would like to figure it out so I can just type open pdf
function openpdf { Invoke-Expression "explorer < ls -Art | egrep '\.pdf$' | tail -n 1; cd -" }

#git
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
function desktop { Invoke-Expression 'cd $BASH_HOME\Desktop' }
function Desktop { Invoke-Expression 'cd $BASH_HOME\Desktop' }
function open { Invoke-Expression "start ." }

function settings { Invoke-Expression "code $BASH_HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" }
function reset { Invoke-Expression ". $PROFILE_LOCATION" }

# TODO figure out how to do this with Powershell
function updatePowershell { Invoke-Expression "git clone https:\\github.com\kepatotorica\bashrc.git; cd bashrc; sh install.sh; cd -; rm -fr bashrc" }

function commit {
  rmorig
  $BRANCH_NAME = GetTicketNumber;
  if ($BRANCH_NAME -ne "master") {
    Invoke-Expression "git add ."
    Write-Host "git commit -am ""${BRANCH_NAME}: $Args""" -ForegroundColor DarkGray
    Invoke-Expression "git commit -am ""${BRANCH_NAME}: $Args"""
  }
  else {
    Write-Host  "You should not be commiting on master!!!" -ForegroundColor DarkRed
  }       
}


function GetTicketNumber {
  $Branch = (Invoke-Expression "git symbolic-ref --short HEAD");
  if ($Branch -eq "master") {
    "master"
  }
  else {
    ($Branch -split '/')[1]
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
  (Get-ChildItem -Recurse -Filter $Args[0]).Name
}

function InstallPowerShellPowerLineAndFont {
  # you may need to actually set the font in your shell
  Invoke-Expression "git clone https://github.com/ryanoasis/nerd-fonts"
  Install-Module oh-my-posh 
  Set-PoshPrompt -Theme patriksvensson
  # install font here I like the jetbrains font
  # https://github.com/ryanoasis/nerd-fonts
  Invoke-Expression "./install.ps1 ""JetBrainsMono NF"""
}
