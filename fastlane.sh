#!/usr/bin/env bash

case "${BUILD_NUMBER_STRATEGY}" in
  github)
    export FL_BUILD_NUMBER="${RUN_NUMBER}"
    ;;
  store)
    export FL_BUILD_NUMBER='store'
    ;;
  *)
    export FL_BUILD_NUMBER=''
esac

# Unset optional variables that are empty
[[ -z "${FL_ENFORCED_BRANCH}" ]] && unset FL_ENFORCED_BRANCH
[[ -z "${FL_COMMIT_INCREMENT}" ]] && unset FL_COMMIT_INCREMENT
[[ -z "${FL_PUBLISH_BUILD}" ]] && unset FL_PUBLISH_BUILD
[[ -z "${FL_TEAM_ID}" ]] && unset FL_TEAM_ID
[[ -z "${FL_ITC_TEAM_ID}" ]] && unset FL_ITC_TEAM_ID
[[ -z "${FL_IOS_CONFIGURATION}" ]] && unset FL_IOS_CONFIGURATION
[[ -z "${FL_XCODE_WORKSPACE}" ]] && unset FL_XCODE_WORKSPACE
[[ -z "${FL_IOS_PODFILE}" ]] && unset FL_IOS_PODFILE
[[ -z "${FL_APPLE_ENTERPRISE}" ]] && unset FL_APPLE_ENTERPRISE

# Execute fastlane using wrapper
./fastlanew ios "${BUILD_LANE}"
