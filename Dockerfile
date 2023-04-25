FROM timzu/docker-builder:v0.2.5

LABEL "com.github.actions.name"="Active Build Stage"
LABEL "com.github.actions.description"="GitHub Action Builder"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="blue"

LABEL version=v0.3.24
LABEL repository="https://github.com/timzu/github-actions-build"
LABEL maintainer="Timur Galeev <timur_galeev@outlook.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
