#!/usr/bin/env bash
set -e
eval $(ssh-agent -s)

GIT_SSH=/usr/bin/ssh

echo "Do a SSH add with the key under env 'SSH_PRIVATE_KEY'"
mkdir -p ${SSH_ROOT_FOLDER}/
echo "$SSH_PRIVATE_KEY"
echo "$SSH_PRIVATE_KEY" | base64 -d > ${SSH_ROOT_FOLDER}/id_rsa
#echo "$SSH_PRIVATE_KEY"==== | fold -w 4 | sed '$ d' | tr -d '\n' | base64 -di > ${SSH_ROOT_FOLDER}/id_rsa
chmod 600 ${SSH_ROOT_FOLDER}/id_rsa


echo "Set StrictHostKeyChecking no"
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ${SSH_ROOT_FOLDER}/config

#Whitelist some well-known git repositories management
if [[ -n "${SSH_IGNORE_DEFAULT_HOSTS}" ]]; then
  echo "Not whitelisting default hosts"
else
  echo "Whitelist  github.com in ${SSH_ROOT_FOLDER}/known_hosts"
  ssh-keyscan -t rsa github.com >> ${SSH_ROOT_FOLDER}/known_hosts
  echo "Whitelist  gitlab.com in ${SSH_ROOT_FOLDER}/known_hosts"
  ssh-keyscan -t rsa gitlab.com >> ${SSH_ROOT_FOLDER}/known_hosts
  echo "Whitelist  bitbucket.org in ${SSH_ROOT_FOLDER}/known_hosts"
  ssh-keyscan -t rsa bitbucket.org >> ${SSH_ROOT_FOLDER}/known_hosts
fi

# Add an extra one on demand
if [[ -n "${SSH_EXTRA_KNOWN_HOST}" ]]; then
  echo "Whitelist  ${SSH_EXTRA_KNOWN_HOST} in ${SSH_ROOT_FOLDER}/known_hosts"
  ssh-keyscan -t rsa ${SSH_EXTRA_KNOWN_HOST} >> ${SSH_ROOT_FOLDER}/known_hosts
fi
