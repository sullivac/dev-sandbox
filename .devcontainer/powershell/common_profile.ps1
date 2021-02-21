Import-Module -Name DockerCompletion
Import-Module -Name posh-git

$env:JAVA_HOME = "/usr/lib/jvm/java-11-openjdk-amd64"
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
