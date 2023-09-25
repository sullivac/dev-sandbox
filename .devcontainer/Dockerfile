FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/us\.archive\.ubuntu\.com\/ubuntu\//' /etc/apt/sources.list \
    && apt-get update 2>&1 \
    && apt-get -y install --no-install-recommends \
    apt-utils \
    dialog 2>&1 \
    && apt-get install -y \
    ca-certificates \
    apt-transport-https 2>&1 \
    && apt-get update 2>&1 \
    && apt-get install -y \
    curl \
    gnupg \
    gnupg-agent \
    lsb-release \
    procps \
    sed \
    software-properties-common \
    unzip 2>&1 \
    && apt-get upgrade -y 2>&1

#
# Update Git
RUN add-apt-repository ppa:git-core/ppa 2>&1 \
    && apt-get install -y git 2>&1
#
# Install Node.js with nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash 2>&1 \
    && /bin/bash -c "source $HOME/.nvm/nvm.sh \
    && nvm install 18.18.0 \
    && npm install -g npm npm-check-updates" 2>&1
#
# Install python3
RUN apt-get install -y \
    python3 \
    python3-pip 2>&1 \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip
#
# Install OpenJDK
RUN apt-get install -y openjdk-17-jdk 2>&1
#
# Install Gradle
RUN curl -o gradle.zip https://downloads.gradle.org/distributions/gradle-8.3-all.zip 2>&1 \
    && mkdir /opt/gradle 2>&1 \
    && unzip -qq -d /opt/gradle gradle.zip 2>&1 \
    && rm gradle.zip 2>&1
#
# Install Docker CE CLI
RUN install -m 0755 -d /etc/apt/keyrings 2>&1 \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg 2>&1 \
    && chmod a+r /etc/apt/keyrings/docker.gpg 2>&1 \
    && echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update 2>&1 \
    && apt-get install -y docker-ce-cli 2>&1
#
# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 2>&1 \
    && chmod +x ./kubectl 2>&1 \
    && mv ./kubectl /usr/local/bin 2>&1
#
# Install Microsoft Package Dependencies
RUN curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb 2>&1 \
    && dpkg -i /tmp/packages-microsoft-prod.deb 2>&1 \
    && apt-get update 2>&1 \
    && rm -rf /tmp/packages-microsoft-prod.deb 2>&1 \
    #
    # Install .NET
    && apt-get install -y dotnet-sdk-6.0 2>&1 \
    #
    # Install PowerShell
    && add-apt-repository universe 2>&1 \
    && apt-get install -y powershell 2>&1
#
# Upgrade
RUN apt-get upgrade 2>&1
#
# Clean up
RUN apt-get autoremove -y 2>&1 \
    && apt-get clean -y 2>&1 \
    && rm -rf /var/lib/apt/lists/* 2>&1

RUN mkdir -p /root/.local/share/powershell/Scripts 2>&1

COPY Install-Modules.ps1 /root/.local/share/powershell/Scripts/

RUN pwsh -NoProfile -NonInteractive -C "& { /root/.local/share/powershell/Scripts/Install-Modules.ps1 }" 2>&1 \
    && mkdir -p /root/.config/powershell 2>&1

COPY powershell/ /root/.config/powershell/

VOLUME [ "/root/.vscode-server/extensions", "/root/.local/share/powershell", "/root/.googleapis", "/workspaces" ]

ENV DEBIAN_FRONTEND=dialog
