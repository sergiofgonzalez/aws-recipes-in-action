# The API &raquo; Using AWS SDK to list EC2 Servers using Node.js
> using `describeInstances` in a Node.js program

## Description
Illustrates how to create a simple *Node.js* program that uses the `aws-sdk` module and `jmespath` to retrieve information about instances.

The application also demonstrate how to select an specific credential set.

### Application Configuration
Application configuration is externalized in a file named `application.yml`. The keys can be overridden by environment variables or command line arguments if necessary.

The following keys are required:
+ `LOGGER__LEVEL` &mdash; the logging level for the application
+ `AWS__PROFILE` &mdash; the named profile that should be selected to run the application. This should be identified by a `[profile_name]` section in the `~/.aws/credentials` file.
+ `AWS__REGION` &mdash; the region from which the information should be queried.

If using *YAML* you can create an `application.yaml` file in your `src/` directory in which the keys are defined as follows:
```yaml
LOGGER:
  LEVEL: TRACE

AWS:
  PROFILE: hackathon
  REGION: us-east-2
```

**Note: About persisting application configuration in the repo**
It is **NOT** a good practice to commit application configuration in the repository as you may inadvertently end up committing secrets like DB password.
However, as in this case there is not relevant information there I have committed the `application.yaml`.