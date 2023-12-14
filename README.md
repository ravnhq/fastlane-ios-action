# Fastlane iOS for GitHub Actions

# Project Setup

Refer to the [RAVN Mobile CI/CD](https://github.com/ravnhq/mobile-cicd) on how to configure the pipeline for your
project before using this action.

_Planned: Allow run in "standalone" mode without needing to set up fastlane files in project manually._

# Xcode SDKs

GitHub macOS runners already have SDKs (and other utilities) installed for iOS (see [here][xcode-sdks]). If the runner
you're using does not come with this support out of the box it must be manually configured before running this action.

[xcode-sdks]: https://github.com/actions/runner-images/blob/main/images/macos/macos-13-Readme.md#xcode

# Example

```yaml
name: Deploy release
on:
  push:
    branches: [ main ] # or master, etc.

jobs:
  deploy:
    runs-on: macos-latest
    steps:
      - name: Build and publish
        uses: ravnhq/fastlane-ios-action@v1
        with:
          build-lane: release
          enforced-branch: main
          run-id-as-build: true
          commit-increment: false
          publish-build: true
          app-identifier: com.domain.application
          team-id: ${{ secrets.APPLE_TEAM_ID }}
          scheme: 'app'
          configuration: 'Release'
          xcodeproj: './app.xcodeproj'
          xcworkspace: './app.xcworkspace'
          apple-key-id: ${{ secrets.APPLE_KEY_ID }}
          apple-issuer-id: ${{ secrets.APPLE_ISSUER_ID }}
          apple-key-base64: ${{ secrets.APPLE_KEY }}
          enterprise: false
          match-password: ${{ secrets.MATCH_PASSWORD }}
```

Refer to the following section for a complete list of inputs.

# Inputs

Refer to the `inputs` section in the file [`action.yml`](action.yml) for a complete list of variables that can be set,
overall these variables overlap with the expected environment variables by the fastlane pipeline (with a few small
differences such as files expecting base64 contents).

To get the contents of a file in base64 you can run the following command:

```shell
cat path/to/your/file.json | base64 
```

And just copy the output, additionally, if you're on Mac you can append `pbcopy` to copy the output directly to your
clipboard:

```shell
cat path/to/your/file.json | base64 | pbcopy
```

#### Variables

| Input              | Description                                                                                                                | Required | Default   |
|--------------------|----------------------------------------------------------------------------------------------------------------------------|:--------:|-----------|
| `build-lane`       | The build lane that should be executed (values: beta, release)                                                             |    ✓     |           |
| `enforced-branch`  | Branch to enforce, recommended (supports regex)                                                                            |          |           |
| `run-id-as-build`  | Whether or not to use GitHub build id as build number                                                                      |          | `true`    |
| `commit-increment` | Whether or not to commit and push version increment                                                                        |          | `false`   |
| `publish-build`    | Whether or not to publish build artifacts to the App Store (or TestFlight)                                                 |          | `true`    |
| `upload-artifacts` | Whether or not to upload output artifacts to GitHub Actions                                                                |          | `true`    |
| `app-identifier`   | App Store application bundle identifier                                                                                    |    ✓     |           |
| `team-id`          | App Store Connect Team ID (if any)                                                                                         |          |           |
| `itc-team-id`      | iTunes Connect Team ID (if any)                                                                                            |          |           |
| `scheme`           | iOS project scheme to build                                                                                                |    ✓     |           |
| `configuration`    | iOS project configuration to use                                                                                           |          | `Release` |
| `xcodeproj`        | Path to main XCode project (required if not found automatically)                                                           |    *     |           |
| `xcworkspace`      | Path to main XCode workspace                                                                                               |          |           |
| `podfile`          | Path to the Podfile (if any) or parent dir, if not defined will try to look for one based on the path of the Xcode project |          | *         |
| `apple-key-id`     | Apple App Store Connect Key ID                                                                                             |    ✓     |           |
| `apple-issuer-id`  | Apple App Store Connect Issuer ID                                                                                          |    ✓     |           |
| `apple-key-base64` | Apple App Store Connect Key contents (.p8) in base64                                                                       |    ✓     |           |
| `enterprise`       | Whether or not it is Apple Enterprise                                                                                      |          | `false`   |
| `match-password`   | Password to encrypt/decrypt certificates using match                                                                       |    ✓     |           |
