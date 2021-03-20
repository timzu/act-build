FROM timzu/build-image

LABEL "com.github.actions.name"="Active Build Stage"
LABEL "com.github.actions.description"="GitHub Action Builder"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="blue"

LABEL version=v0.3.1
LABEL repository="https://github.com/timzu/act-build"
LABEL maintainer="Timur Galeev <timur_galeev@outlook.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
