# Current plans

- `usage.sh` and related `usageArgument` will be moved to a less verbose type-checking interface modeled after the
  `decorate` pattern which seemed to work well.
- Continue migration to local `local` usage instead of head of function (`example.sh` arguments handling)
- Move `docs` to something not Bash-based perhaps
- Start writing some tutorials on how to get it set up and working (video?)

## Done

- "Work on 30-minute build timing or make it faster somehow" - Added `--tag` to `testSuite` to skip slow tests each run
- "Move away from `.check-assertions`" - now just checks everything - may not be a good choice
- Move away from `.debugging` markers - now uses a hash of the file stored in the file itself. (Ignoring the hash line.)

## Slowest tests 2025

- 81.283 testDeployToRemote
- 61.936 testDeployApplication
- 55.622 testDeployBuildEnvironment
- 53.482 testIdenticalChecks
- 52.711 testHookSystem
- 45.741 testAWSIPAccess
- 44.642 testUsageArgumentFunctions
- 42.04 testBuildEnvironmentLoadAll
- 41.934 testPHPBuild
- 37.705 testLogFileRotate1
- 37.45 testLogFileRotate
- 33.429 testAdditionalBins
- 32.793 testIdenticalCheckAndRepairMap
- 28.876 testIsUpToDate
- 27.622 testDeployRemoteFinish
- 26.053 testBadNumericSamples
- 25.65 testPackageAPI
- 24.031 testWrapperShellScripts
- 23.334 testDocSections
- 22.598 testRunCount
- 21.804 testServiceToPort
- 21.288 testVersionNext
- 20.092 testFileMatches
- 19.438 testDaemontools
- 18.317 test__catchCode
- 15.679 testAwsEnvironmentFromCredentials
- 15.661 testIdenticalCheckSingles
- 15.267 testUnsignedIntegerSamples
- 14.945 testValidateCharacterClass
- 14.739 testHooksWhichSeemBenign
- 14.211 testUnsignedNumberSamples
- 14.19 testIterm2
- 14.076 testBashPrompt
- 13.185 testSignedNumberSamples
- 12.705 testLinkCreate
- 12.571 testMapPrefixSuffix
- 12.456 testServiceToPortStandard
- 12.369 testSugar
- 12.332 testEnvironmentFileLoad
- 11.931 testProcessWait
- 10.549 testExecutableCallable
- 10.537 testInstallBinBuild
- 10.498 testListAppend
- 10.371 testGitCommitFailures
- 10.316 testRepeat2
- 10.267 testIsMappable
- 10.173 testIsTrue
- 9.331 testSignedIntegerSamples
- 9.059 testIncrementor
- 8.828 testNotExecutable
