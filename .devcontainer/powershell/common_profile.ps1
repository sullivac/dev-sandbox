Import-Module -Name DockerCompletion
Import-Module -Name posh-git

$env:PATH = "${env:PATH}:/root/.nvm/versions/node/v12.16.0/bin"

Set-PSReadLineOption -EditMode Windows
