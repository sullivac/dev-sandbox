Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

PowerShellGet\Install-Module -Name DockerCompletion -Scope CurrentUser -Force -AllowPrerelease
PowerShellGet\Install-Module -Name posh-git -Scope CurrentUser -Force -AllowPrerelease
