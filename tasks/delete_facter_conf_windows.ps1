# Task to delete C:\ProgramData\PuppetLabs\facter\etc\facter.conf

Remove-Item -Path C:\ProgramData\PuppetLabs\facter\etc\facter.conf -Force

Write-Output "Deleted: C:\ProgramData\PuppetLabs\facter\etc\facter.conf"
