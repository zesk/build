# Current plans

- `usage.sh` and related `usageArgument` will be moved to a less verbose type-checking interface modeled after the `decorate` pattern which seemed to work well.
- Continue migration to local `local` usage instead of head of function (`example.sh` arguments handling)
- Move `docs` to something not Bash-based perhaps
- Start writing some tutorials on how to get it set up and working (video?)

## Done

- "Work on 30-minute build timing or make it faster somehow" - Added `--tag` to `testSuite` to skip slow tests each run
- "Move away from `.check-assertions`" - now just checks everything - may not be a good choice
- Move away from `.debugging` markers - now uses a hash of the file stored in the file itself. (Ignoring the hash line.)

## Slowest tests 2025

- 60 seconds - `testDeployApplication`
- 52 seconds - `testIdenticalChecks`
- 43 seconds - `testPHPBuild`
- 42 seconds - `testDeployToRemote`
- 38 seconds - `testHookSystem`
- 38 seconds - `testAWSIPAccess`
- 34 seconds - `testUsageArgumentFunctions`
- 34 seconds - `testAdditionalBins`
- 33 seconds - `testDeployBuildEnvironment`
- 31 seconds - `testBuildEnvironmentLoadAll`
- 27 seconds - `testIdenticalCheckAndRepairMap`
- 25 seconds - `testPackageAPI`
- 24 seconds - `testWrapperShellScripts`
- 24 seconds - `testGitVersionList`
- 23 seconds - `testLogFileRotate1`
- 22 seconds - `testSugar`
- 22 seconds - `testLogFileRotate`
- 22 seconds - `testInstallTerraform`
- 21 seconds - `testBadNumericSamples`
- 20 seconds - `testIsUpToDate`
- 20 seconds - `testDeployRemoteFinish`
- 19 seconds - `testFileMatches`
- 19 seconds - `testDaemontools`
- 18 seconds - `testInstallOpenTofu`
- 18 seconds - `testHooksWhichSeemBenign`
- 16 seconds - `testValidateCharacterClass`
- 15 seconds - `testAwsEnvironmentFromCredentials`
- 14 seconds - `testUnsignedIntegerSamples`
- 14 seconds - `testPythonInstallation`
- 14 seconds - `testIdenticalCheckSingles`
- 13 seconds - `testProcessWait`
- 12 seconds - `testVersionNext`
- 12 seconds - `testUnsignedNumberSamples`
- 11 seconds - `testSignedNumberSamples`
- 11 seconds - `testServiceToPort`
- 11 seconds - `testRunCount`
- 11 seconds - `testInstallBinBuild`
- 10 seconds - `testBashPrompt`
