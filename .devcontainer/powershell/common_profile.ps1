Import-Module -Name DockerCompletion
Import-Module -Name posh-git

$env:JAVA_HOME = "/usr/lib/jvm/java-17-openjdk-amd64"

$paths = @(
    '/root/.nvm/versions/node/v16.16.0/bin',
    '/opt/gradle/gradle-6.8.3/bin'
) -join ':'

$env:PATH = "${env:PATH}:$paths"

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
