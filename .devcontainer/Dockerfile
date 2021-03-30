FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/ubuntu.mirrors.tds.net\/pub\/ubuntu\//' /etc/apt/sources.list \
    && apt-get update 2>&1 \
    && apt-get -y install --no-install-recommends \
    apt-utils \
    dialog 2>&1 \
    && apt-get install -y ca-certificates 2>&1 \
    && apt-get install -y apt-transport-https 2>&1 \
    && apt-get update 2>&1 \
    && apt-get install -y \
    curl \
    gnupg-agent \
    liblttng-ust0 \
    lsb-release \
    procps \
    sed \
    software-properties-common \
    unzip 2>&1 \
    && apt-get upgrade -y 2>&1 \
    #
    # Update Git
    && add-apt-repository ppa:git-core/ppa 2>&1 \
    && apt-get install -y git 2>&1 \
    #
    # Install Node.js 14.16.0 with nvm
    && curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh | bash 2>&1 \
    && /bin/bash -c "source $HOME/.nvm/nvm.sh \
    && nvm install 14.16.0 \
    && npm install -g npm npm-check-updates" 2>&1 \
    #
    # Install python3
    && apt-get install -y \
    python3 \
    python3-pip 2>&1 \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    #
    # Install OpenJDK 14
    && apt-get install -y openjdk-14-jdk 2>&1 \
    #
    # Install Gradle 6.8.3
    && curl -o gradle.zip https://downloads.gradle-dn.com/distributions/gradle-6.8.3-all.zip 2>&1 \
    && mkdir /opt/gradle 2>&1 \
    && unzip -qq -d /opt/gradle gradle.zip 2>&1 \
    && rm gradle.zip 2>&1 \
    #
    # Install .NET 5.0
    && curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb 2>&1 \
    && dpkg -i /tmp/packages-microsoft-prod.deb 2>&1 \
    && apt-get update 2>&1 \
    && apt-get install -y dotnet-sdk-5.0 2>&1 \
    && rm -rf /tmp/packages-microsoft-prod.deb 2>&1 \
    #
    # Install Docker CE CLI
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" 2>&1 \
    && apt-get update 2>&1 \
    && apt-get install -y docker-ce-cli 2>&1 \
    #
    # Install kubectl
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 2>&1 \
    && chmod +x ./kubectl 2>&1 \
    && mv ./kubectl /usr/local/bin 2>&1 \
    #
    # Install PowerShell
    && curl -sSL -o /tmp/packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb 2>&1 \
    && dpkg -i /tmp/packages-microsoft-prod.deb 2>&1 \
    && rm -rf /tmp/packages-microsoft-prod.deb 2>&1 \
    && apt-get update 2>&1 \
    && add-apt-repository universe 2>&1 \
    && apt-get install -y powershell 2>&1 \
    #
    # Upgrade
    && apt-get upgrade 2>&1 \
    #
    # Clean up
    && apt-get autoremove -y 2>&1 \
    && apt-get clean -y 2>&1 \
    && rm -rf /var/lib/apt/lists/* 2>&1

RUN mkdir -p /root/.local/share/powershell/Scripts 2>&1

COPY Install-Modules.ps1 /root/.local/share/powershell/Scripts/

RUN pwsh -NoProfile -NonInteractive -C "& { /root/.local/share/powershell/Scripts/Install-Modules.ps1 }" 2>&1 \
    && mkdir -p /root/.config/powershell 2>&1

COPY powershell/ /root/.config/powershell/

VOLUME [ "/root/.vscode-server/extensions", "/root/.local/share/powershell", "/root/.googleapis", "/workspaces" ]

ENV DEBIAN_FRONTEND=dialog
