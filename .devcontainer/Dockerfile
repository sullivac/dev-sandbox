FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list \
    && apt-get update 2>&1 \
    && apt-get -y install --no-install-recommends \
    apt-utils \
    dialog 2>&1 \
    && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg-agent \
    lsb-release \
    procps \
    sed \
    software-properties-common \
    unzip 2>&1 \
    #
    # Install Node.js 12.18.1 with nvm
    && curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash 2>&1 \
    && /bin/bash -c "source $HOME/.nvm/nvm.sh \
    && nvm install 14.16.0 \
    && npm install -g npm npm-check-updates" 2>&1 \
    #
    # Install python3
    && apt-get install -y \
    python3 \
    python3-pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    #
    # Install OpenJDK 11
    && apt-get install -y openjdk-11-jdk \
    #
    # Install Gradle 6.8.3
    && curl -o gradle.zip https://downloads.gradle-dn.com/distributions/gradle-6.8.3-all.zip \
    && mkdir /opt/gradle \
    && unzip -d /opt/gradle gradle.zip \
    && rm gradle.zip \
    #
    # Install .NET 5.0
    && curl -sSL https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb 2>&1 \
    && dpkg -i /tmp/packages-microsoft-prod.deb 2>&1 \
    && apt-get update 2>&1 \
    && apt-get install -y dotnet-sdk-5.0 \
    && rm -rf /tmp/packages-microsoft-prod.deb 2>&1 \
    #
    # Install Docker CE CLI
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" 2>&1 \
    && apt-get update 2>&1 \
    && apt-get install -y docker-ce-cli 2>&1 \
    #
    # Install kubectl
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl 2>&1 \
    && chmod +x ./kubectl 2>&1 \
    && mv ./kubectl /usr/local/bin 2>&1 \
    #
    # Install PowerShell
    && curl -sSL -o /tmp/powershell.deb https://github.com/PowerShell/PowerShell/releases/download/v7.1.2/powershell_7.1.2-1.ubuntu.18.04_amd64.deb 2>&1 \
    && dpkg -i --force-all /tmp/powershell.deb 2>&1 \
    && apt-get install -yf 2>&1 \
    && rm -rf /tmp/powershell.deb 2>&1 \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.local/share/powershell/Scripts 2>&1

COPY Install-Modules.ps1 /root/.local/share/powershell/Scripts/

RUN pwsh -NoProfile -NonInteractive -C "& { /root/.local/share/powershell/Scripts/Install-Modules.ps1 }" 2>&1 \
    && mkdir -p /root/.config/powershell 2>&1

COPY powershell/ /root/.config/powershell/

VOLUME [ "/root/.vscode-server/extensions", "/root/.local/share/powershell", "/root/.googleapis", "/workspaces" ]

ENV DEBIAN_FRONTEND=dialog
