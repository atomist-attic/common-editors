# Atomist 'common-editors'

[![Build Status](https://travis-ci.org/atomist-rugs/common-editors.svg?branch=master)](https://travis-ci.org/atomist-rugs/common-editors)
[![Slack Status](https://join.atomist.com/badge.svg)](https://join.atomist.com)

This [Rug](http://docs.atomist.com/) archive has an example editors
that showcase some of the features of Rug.  Take a look inside the
`.atomist` folder.

## Rugs

### AddApacheSoftwareLicense20

The AddApacheSoftwareLicense20 Editor adds the [Apache Software License
Version 2.0][apache] to a project.

[apache]: http://apache.org/licenses/LICENSE-2.0

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository

#### Parameters

This Editor has no parameters.

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:common-editors:AddApacheSoftwareLicense20
```

This will add a file named `LICENSE` to the top-level directory of the
project.  If you are happy with the change, commit the changes made by
the Editor and push the commit to GitHub.

### AddReadme

The AddReadme Editor adds a GitHub-like `README.md` file to the
top-level directory in a project.

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository

#### Parameters

To run this editor, you must supply the following parameters.

*   `project_name`: The name of the project, typically the repository
    name.
*   `description`: A one-sentence description of the project.

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:travis-editors:AddReadme \
    project_name=my-project \
    description="Better put this description in quotes."
```

This will add the `README.md` to the top-level directory of the
project.  The `README.md` will have the project name as a "h1" header
and the description as regular text beneath it.  If you are happy with
the change, commit the changes made by the Editor and push the commit
to GitHub.

### AddScalaMavenGitIgnore

The AddScalaMavenGitIgnore Editor adds a [`.gitignore`][gitignore]
file suitable for [Scala][scala] projects built with [Maven][mvn] in
the top-level directory of the project.

[gitignore]: https://git-scm.com/docs/gitignore
[scala]: https://www.scala-lang.org/
[mvn]: https://maven.apache.org/

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository for a Scala project built with Maven

#### Parameters

This Editor has no parameters.

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:common-editors:AddScalaMavenGitIgnore
```

This will add a file named `.gitignore` to the top-level directory of
the project.  If you are happy with the change, commit the changes
made by the Editor and push the commit to GitHub.

### ClassRenamer

The ClassRenamer Editor renames a Java class throughout an entire
project.  Currently this Editor is a bit brute force and replaces
every occurrence of the current name with the new name.

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository for a Java project

#### Parameters

To run this editor, you must supply the following parameters.

*   `old_class`: The name of the Java class to be renamed.
*   `new_class`: The new name for the Java class.

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:travis-editors:ClassRenamer \
    old_class=FooBar \
    new_class=MoreDescriptiveName
```

This will change all occurrences of "FooBar" with
"MoreDescriptiveName" throughout the code base.  If you are happy with
the change, commit the changes made by the Editor and push the commit
to GitHub.

### PackageMove

The PackageMove Editor renames a Java package throughout an entire
project, relocating files as appropriate.

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository for a Java project

#### Parameters

To run this editor, you must supply the following parameters.

*   `old_package`: The name of the Java package to be renamed.
*   `new_package`: The new name for the Java package.

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:travis-editors:PackageMove \
    old_package=com.pany.FooBar \
    new_package=com.pany.MoreDescriptiveName
```

This will change all occurrences of "com.pany.FooBar" package with
"com.pany.MoreDescriptiveName" throughout the code base, moving files
as appropriate.  If you are happy with the change, commit the changes
made by the Editor and push the commit to GitHub.

### PomParameterizer

The PomParameterizer Editor updates various project elements in
the [Maven][mvn] Project Object Model (POM) file.

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository for a project built with Maven

#### Parameters

To run this editor, you must supply the following parameters.

*   `artifact_id`: Optional Maven artifact ID, e.g., "fiddle-riddle".
    If a value is not provided, the value of the `project_name`
    parameter is used.
*   `group_id`: Maven group ID, e.g., "com.pany.project".
*   `project_name`: A valid GitHub repository name.  It must be 21
    characters or less to avoid truncating name when the its Slack
    channel is created.
*   `version`: [Semantic version][semver] of the project.  Default
    value is "0.1.0".

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:travis-editors:PomParameterizer \
    old_package=com.pany.FooBar \
    new_package=com.pany.MoreDescriptiveName
```

This will change all occurrences of "com.pany.FooBar" package with
"com.pany.MoreDescriptiveName" throughout the code base, moving files
as appropriate.  If you are happy with the change, commit the changes
made by the Editor and push the commit to GitHub.

### RemoveApacheSoftwareLicense20

The RemoveApacheSoftwareLicense20 Editor removes the file named
`LICENSE` from the project if that file looks like
the [Apache Software License Version 2.0][apache].

#### Prerequisites

Before running this Editor, you must have the following prerequisites
satisfied.

*   A git repository with the Apache Software License Version 2.0 in a
    file named `LICENSE` at the top-level directory of the repository

#### Parameters

This Editor has no parameters.

#### Running

Run it as follows:

```
$ cd to/your/repo
$ rug edit atomist-rugs:common-editors:RemoveApacheSoftwareLicense20
```

This will remove a file named `LICENSE` at the top-level directory of
the project if it appears to contain the Apache Software License
Version 2.0.  If you are happy with the change, commit the changes
made by the Editor and push the commit to GitHub.

## Support

General support questions should be discussed in the `#support`
channel on our community Slack team
at [atomist-community.slack.com](https://join.atomist.com).

If you find a problem, please create an [issue][].

[issue]: https://github.com/atomist-rugs/common-editors/issues

## Development

You can build, test, and install the project locally with
the [Rug CLI][cli].

[cli]: https://github.com/atomist/rug-cli

```
$ rug test
$ rug install
```

To create a new release of the project, simply push a tag of the form
`M.N.P` where `M`, `N`, and `P` are integers that form the next
appropriate [semantic version][semver] for release.  For example:

[semver]: http://semver.org

```
$ git tag -a 1.2.3
```

The Travis CI build (see badge at the top of this page) will
automatically create a GitHub release using the tag name for the
release and the comment provided on the annotated tag as the contents
of the release notes.  It will also automatically upload the needed
artifacts.

---
Created by Atomist. Need Help? <a href="https://join.atomist.com/">Join our Slack team</a>
