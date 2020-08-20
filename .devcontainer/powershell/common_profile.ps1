Import-Module -Name DockerCompletion
Import-Module -Name posh-git

$env:PATH = "${env:PATH}:/root/.nvm/versions/node/v12.18.1/bin"

Set-PSReadLineOption -EditMode Windows

if ($env:SYNC_LOCALHOST_KUBECONFIG) {
    $kubePath = $HOME | Join-Path -ChildPath .kube
    New-Item -ItemType Directory -Path $kubePath -Force | Out-Null
    $kubeLocalhostSourcePath = $HOME | Join-Path -ChildPath .kube-localhost -AdditionalChildPath *
    Copy-Item -Recurse -Path $kubeLocalhostSourcePath -Destination $kubePath -Force
    $kubeConfigPath = $kubePath | Join-Path -ChildPath config
    sed -i -e "s/localhost/host.docker.internal/g" $kubeConfigPath
}

git config --global core.editor "code --wait"

$keychainResult = & keychain --eval --agents ssh github_ed25519

$keychainResult |
ForEach-Object -Process { $_ -split ';' } |
Where-Object -FilterScript { $_.StartsWith("SSH") } |
ForEach-Object -Process {
    $tokens = $_ -split '='

    $envVarPath = Join-Path -Path env: -ChildPath $tokens[0]

    if (-not $(Test-Path -Path $envVarPath)) {
        New-Item -Path env:\ -Name $tokens[0] -Value $tokens[1] | Out-Null
    }
}
