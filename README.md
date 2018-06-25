Drone-GitHub-status-report-bot
========================

![license](https://img.shields.io/badge/license-GPLv3.0-brightgreen.svg?style=flat) ![](https://img.shields.io/docker/pulls/peterdavehello/drone-github-status-report-bot.svg) ![](https://images.microbadger.com/badges/image/peterdavehello/drone-github-status-report-bot.svg) ![](https://images.microbadger.com/badges/version/peterdavehello/drone-github-status-report-bot.svg)

A [Drone](https://drone.io) CI v0.5 plugin to help report pull request build status on GitHub with "review" feature.

GitHub repository:
 - https://github.com/PeterDaveHello/Drone-GitHub-status-report-bot

Docker hub repository:
  - https://hub.docker.com/r/peterdavehello/drone-github-status-report-bot/
  
## How to use it?

1. Add image `peterdavehello/drone-github-status-report-bot:latest` to the last step of your Drone pipelnie in the `.drone.yml` flie, specify it to **pull request** event, and the **status** (`failure`, `success`, or both) you want the bot report.

  For example:
  
  ```yaml
    bot-review:
    image: peterdavehello/drone-github-status-report-bot:latest
    when:
      event: pull_request
      status: [ success, failure ]
   ```
   (https://github.com/cdnjs/cdnjs/blob/fe432d412dae1ed30bf14e5396c199e0e3876e79/.drone.yml#L5-L9)

2. [Create a GitHub personal token](https://github.com/settings/tokens/new?description=Drone-GitHub-status-report-bot) and set the  value to a secret variable `GITHUB_TOKEN` in Drone.

Now you can trigger a upll request event and the bot should report the status on the pull request!

## License

GPL-3.0
