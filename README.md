# Bitbucket Pullrequest Resource For Concourse

This resource is used to watch a branch in a specific repository and capture all of the PR's
created against that branch.

# Source Configuration


# Behavior

## `CHECK`

## `IN`

## `OUT`

### Parameters

# Examples
#### Resource Type:
```
resource_types:
- name: git-bitbucket-pr
  type: docker-image
  source:
    repository: mperrotte/bitbucket-pullrequest-resource
```

#### Resource:
```
resources:
- name: repository-to-watch
  type: git-bitbucket-pr
  source:
    username: ((bitbucket-username)) # INFO(mperrotte): used for git-bitbucket-pr resource (API)
    password: ((bitbucket-password)) # INFO(mperrotte): used for git-bitbucket-pr resource (API)
    private_key: ((private-key)) # INFO(mperrotte): used for bitbucket git resource (GIT)
    uri: ((repository-uri))
    project: ((repository-owner))
    repository: ((repository-name))
    branch: ((branch-to-watch))
    source_dir: # INFO(mperrotte): undocumented as of yet
```

#### Plan usage
```
plan:
- get: repository-to-watch
  trigger: true
  version: every
- task: build-testing
  file: repository-to-watch/task/file.yml
```