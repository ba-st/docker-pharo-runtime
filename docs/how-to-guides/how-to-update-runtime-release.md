# How to update the VM release

Once a [new release](https://github.com/pharo-project/pharo/releases)
of the Pharo Image was produced:

- Lookup for the corresponding commit hash in the release page
- Go to <https://files.pharo.org/image/>
- Locate directory corresponding to the new version
- Within find a zip file corresponding to the commit hash with a name like
  `Pharo{{version}}-SNAPSHOT.build.{{build_number}}.sha.{{commit_hash}}.arch.64bit.zip}`
  (beware that multiple files with the same version might be available)
- Look for a commit equal to the one mentioned in the Pharo Image release
- Update the `Dockerfile` in the `source` folder to download the new zip
- In the exceptional case that several patch versions are released,
  you can get the latest Pharo commit
- New releases should follow the format `Pharo Image Version [Current Date]`,
  in case a patch commit was used, increase the patch part of the version
- After creating a new release, a new branch must be created
  so that it can be referenced by dependent projects