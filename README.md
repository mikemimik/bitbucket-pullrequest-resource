# Bitbucket Pullrequest Resource For Concourse

This resource sends a build status payload to bitbucket to signify the status of a commit.

# Source Configuration
* `username`: _Required_. Username to bitbucket account with access to the repository being worked with.
* `password`: _Required_. Password (or App Password) to bitbucket account with access to the repository being worked with.

# Behavior

## `CHECK`
> no-op function
## `IN`
> no-op function
## `OUT`

### Parameters
* `status`: _Required_. Can be one of `[ 'INPROGRESS', 'SUCCESSFUL', 'FAILED', 'STOPPED' ]`
* `project`: _Required_. Bitbucket repository owner (organization account slug, or user account slug).
* `repository`: _Required_. Bitbucket repository slug.

# Examples
#### Resource Type:
```
resource_types:
- name: bitbucket-build-notification-resource
  type: docker-image
  source:
    repository: mperrotte/bitbucket-build-notification-resource
```

#### Resource:
```
resources:
- name: build-notify
  type: bitbucket-build-notification-resource
  source:
    username: ((bitbucket-username))
    password: ((bitbucket-password))
```

```
resources:
- name: pipeline-generator
  type: pipeline-resource
  source:
    target: http://localhost:8080
    teams:
    - name: main
      username: concourse
      password: changeme
    - name: other_team
      username: other_concourse
      password: other_changeme
```

#### Plan usage
```
plan:
- get: some-git-resource
- task: build-testing
  file: some-git-resource/task/file.yml
  on_success:
    put: build-notify
    params:
      status: SUCCESSFUL
      project: ((bitbucket-repository-owner))
      repository: ((bitbucket-repository-name))
  on_failuer:
    put: build-notify
    params:
      status: FAILED
      project: ((bitbucket-repository-owner))
      repository: ((bitbucket-repository-name))
  on_abort:
    put: build-notify
    params:
      status: STOPPED
      project: ((bitbucket-repository-owner))
      repository: ((bitbucket-repository-name))
```