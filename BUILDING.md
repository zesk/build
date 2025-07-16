# Zesk Build Tools Building

Currently built in BitBucket pipelines and then deployed to GitHub.

For building we depend on:

- [`mkdocs`](https://www.mkdocs.org/)
- [`docker`](https://www.docker.com/)

See [`./bitbucket-pipelines.yml`](./bitbucket-pipelines.yml) for build steps, but essentially:

1. `bin/build.sh` - Ensure files pass basic tests (identical and deprecated all pass) and (optionally) generate
   documentation
2. `bin/test.sh` - Run tests (30+ minutes for everything on 2x hardware)
3. `bin/deploy.sh` - Deploys to GitHub in `production`, deploys documentation

Deployment is currently being added to build and update documentation endpoint for always up-to-date online
documentation using `mkdocs`.