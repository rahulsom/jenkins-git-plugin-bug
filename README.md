# Reproduction

2. Build the docker image
```shell
docker build -t jenkins-git-plugin-bug .
```

2. Run docker container
```shell
docker run --rm \
    -v jenkins_home:/var/jenkins_home \
    -p 8080:8080 \
    --name jenkins-git-plugin-bug \
    jenkins-git-plugin-bug
```

3. Create a git project that polls SCM

```xml
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@4.8.1">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/rahulsom/jenkins-git-plugin-bug</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/master</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="empty-list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>* * * * * </spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>cat README.md</command>
      <configuredLocalRules/>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
```

4. After its first build, update the git plugin.

# Expected
It should not rebuild since the repository has not changed.


# Actual
1. It assumes the commit has changed and rebuilds.

2. You see this line in the logs

```
2021-08-06 17:21:01.764+0000 [id=73]	WARNING	h.util.RobustReflectionConverter#doUnmarshal: Cannot convert type hudson.plugins.git.Revision to type org.eclipse.jgit.lib.ObjectId
```

3. The older build shows Revision as empty after upgrading the plugin
