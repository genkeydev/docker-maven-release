# Docker maven release

The docker image pre-setup with git, maven and gpg and a script to trigger a release by a bot

# features supported
- GPG signing
- SSH git repo authentication
- Committing with a bot user
- incrementing Major, Minor or patch version
- Rolling back release if mvn prepared failed.
- custom release branch name
- timestamp on logs to facilitate troubleshooting maven performance issue.

# Script
Script name: release.sh

## version number

By default, the patch version number will be increased

## Environment variables

The script is expecting some environment variables:


- GPG_ENABLED: enable GPG signing
- GPG_KEY_ID: GPG signing KID
- GPG_KEY: GPG private key base64 encoded.
- GPG_PASSPHRASE: GPG passphrase

- SSH_PRIVATE_KEY: SSH private key base64 encoded.
- SSH_ROOT_FOLDER: by default `${SSH_ROOT_FOLDER}`
- SSH_IGNORE_DEFAULT_HOSTS: Doesn't add github.com, gitlab.com and bitbucket.org to .ssh/known_hosts
- SSH_EXTRA_KNOWN_HOST: Add an extra hostname you need to get added to .ssh/known_hosts
- SSH_PASSPHRASE: SSH passphrase

- MAVEN_REPO_SERVER_ID: !!DEPRECATED: Use MAVEN_SERVERS instead!! Maven server repository id to push the artifacts to
- MAVEN_REPO_SERVER_USERNAME: !!DEPRECATED: Use MAVEN_SERVERS instead!! Maven server repository username
- MAVEN_REPO_SERVER_PASSWORD: !!DEPRECATED: Use MAVEN_SERVERS instead!! Maven server repository password
- MAVEN_SERVERS: The maven server repositories, in a JSON format. Example: '[{"id": "serverId1", "username": "username", "password": "password1", "privateKey": "privatekey1", "passphrase": "passphrase1"}, {"id": "serverId2", "username": "username2", "password": "password2"}]'
- MAVEN_PROJECT_FOLDER: the folder on which to execute maven
- MAVEN_ARGS: The maven arguments for the release
- MAVEN_OPTION: the maven options for the release
- MAVEN_DEVELOPMENT_VERSION_NUMBER: development version number format
- MAVEN_RELEASE_VERSION_NUMBER: the release version number format

- DOCKER_REGISTRY_ID: ID of your registry; ex: `registry.hub.docker.com`
- DOCKER_REGISTRY_USERNAME: the username for your docker registry
- DOCKER_REGISTRY_PASSWORD: the password for your docker registry

- GIT_RELEASE_BOT_NAME: The git user name for committing the release
- GIT_RELEASE_BOT_EMAIL: The git user email for committing the release

- SKIP_GIT_SANITY_CHECK: true to skip the git sanity check, basically resetting the branch just in case
- SKIP_PERFORM: "false" to not skip the maven perform

- GITREPO_ACCESS_TOKEN: GIT repo access token to push release commits

- CI_COMMIT_SHA: The commit SHA that triggered the workflow.
- CI_COMMIT_REF_NAME: The branch or tag ref ®that triggered the workflow.

- VERSION_MAJOR: "true" to increment the major version
- VERSION_MINOR: "true" to increment the minor version
- VERSION_PATCH: "true" to increment the minor version

- RELEASE_BRANCH_NAME: if defined, filter the branches to trigger a release on.
