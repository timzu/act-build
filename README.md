# Action Build

[![GitHub Actions status](https://github.com/timzu/github-actions-docker/workflows/Build-Tag/badge.svg)](https://github.com/timzu/github-actions-docker/actions)
[![GitHub Releases](https://img.shields.io/github/release/timzu/github-actions-docker.svg)](https://github.com/timzu/github-actions-docker/releases)


## Usage

```yaml
name: Build

on: push

jobs:
  builder:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@master
        with:
          fetch-depth: 1

      - name: Bump Version
        uses: timzu/github-actions-docker@master
        with:
          args: --version

      - name: Commit & Push to GitHub
        uses: timzu/github-actions-docker@master
        with:
          args: --commit
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          MESSAGE_PATH: ./target/commit_message

      - name: Publish to AWS S3
        uses: timzu/github-actions-docker@master
        with:
          args: --publish
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_REGION: "eu-central-1"
          FROM_PATH: "./target/publish"
          DEST_PATH: "s3://your_bucket_name/path/"
          OPTIONS: "--acl public-read"

      - name: Release to GitHub
        uses: timzu/github-actions-docker@master
        with:
          args: --release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          TARGET_COMMITISH: main
          TAG_NAME: "v0.0.1"

      - name: Docker Build & Push to Docker Hub
        uses: timzu/github-actions-docker@master
        with:
          args: --docker
        env:
          USERNAME: ${{ secrets.DOCKER_USERNAME }}
          PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
          DOCKERFILE: "Dockerfile"
          IMAGE_NAME: "USERNAME/IMAGE_NAME"
          TAG_NAME: "v0.0.1"
          LATEST: "true"

      - name: Docker Build & Push to GitHub Package
        uses: timzu/github-actions-docker@master
        with:
          args: --docker
        env:
          USERNAME: ${{ secrets.GITHUB_USERNAME }}
          PASSWORD: ${{ secrets.GH_PERSONAL_TOKEN }}
          REGISTRY: "docker.pkg.github.com"
          DOCKERFILE: "Dockerfile"
          IMAGE_NAME: "IMAGE_NAME"
          TAG_NAME: "v0.0.1"
          LATEST: "true"

      - name: Docker Build & Push to AWS ECR
        uses: timzu/github-actions-docker@master
        with:
          args: --ecr
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          IMAGE_URI: "xxxx.dkr.ecr.eu-central-1.amazonaws.com/IMAGE_NAME"
          DOCKERFILE: "Dockerfile.aws"
          TAG_NAME: "v0.0.1"
          LATEST: "true"

      - name: Post to Slack
        uses: timzu/github-actions-docker@master
        with:
          args: --slack
        env:
          SLACK_TOKEN: ${{ secrets.SLACK_TOKEN }}
          JSON_PATH: ./target/slack_message.json
```
