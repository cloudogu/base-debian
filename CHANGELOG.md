# Jenkins Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [13.6-2] - 2026-08-06
### Changed
- Update Debian 13.6 digest hash

## [13.6-1] - 2026-07-21
### Changed
- Update Debian to v13.6

## [13.5-3] - 2026-06-24
### Changed
- Update Debian 13.5 digest hash

## [13.5-2] - 2026-06-15
### Changed
- Update Makefiles to v10.9.1

## [13.5-1] - 2026-05-27
### Changed
- Update Debian to v13.5

## [13.4-1] - 2026-04-22
### Changed
- Update Debian to v13.4
- Update Makefiles to v10.9.0

## [13.3-6] - 2026-03-10
### Changed
- Update to Debian to v13.3

## [13.3-5] - 2026-02-17
### Changed
- Update doguctl to v0.15.1.

## [13.3-4] - 2026-02-12
### Security
- Update doguctl to v0.15.0 to fix [CVE-2025-61732](https://avd.aquasec.com/nvd/2026/CVE-2025-61732) and [CVE-2025-68121](https://avd.aquasec.com/nvd/2026/CVE-2025-68121).

## [13.3-3] - 2026-02-07
### Security
- Fixes [CVE-2025-15467](https://avd.aquasec.com/nvd/2025/cve-2025-15467)

## [13.3-2] - 2026-01-19
### Security
- Fixes [CVE-2026-0861](https://avd.aquasec.com/nvd/2026/cve-2026-0861)

## [13.3-1] - 2026-01-15
### Changed
- Update Debian to v13.3

## [13.2-1] - 2025-11-20
### Changed
- [#33] Update Debian to v13.2

## [13.1-1] - 2025-09-10
### Changed
- [#31] Update Debian to v13.1
- [#31] Update Makefiles to v10.2.1
### Security
- [#31] Fixes CVE-2025-58050

## [13.0-1] - 2025-08-13
### Changed
- [#29] Update Debian to v13.0
- [#29] Update doguctl to v0.13.3
- [#29] Update Makefiles to v10.2.0
### Security
- [#29] Fixes CVE-2023-45853

## [12.9-1] - 2025-02-21
### Changed
- [#27] Upgrade debian to v12.9
- [#27] Update doguctl to version 0.13.2

## [12.7-3] - 2025-01-06
## Security
- [#25] Update doguctl to version 0.13.1
   - Fixes CVE-2024-45337 

## [12.7-2] - 2024-09-23
### Changed
- [#23] Relicense to AGPL-3.0-only

## [12.7-1] - 2024-09-17
### Changed
- Upgrade to debian 12.7
- Upgrade doguctl to v0.12.2

## [12.6-1] - 2024-08-06
### Changed
- [#21] Upgrade debian to v12.6
- [#21] Upgrade doguctl to v0.12.1

### Security
- this release closes CVE-2024-41110

## [12.5-4] - 2024-06-27
### Changed
- [#30] Update doguctl to v0.12.0

### Security
- this release closes the following CVEs
    - CVE-2024-24788
    - CVE-2024-24789
    - CVE-2024-24790

## [12.5-3] - 2024-06-25
### Changed
- [#17] Update doguctl to v0.11.0
- Update makefiles to 9.0.5

## [12.5-2] - 2024-06-06
### Changed
- [#15] Update doguctl to v0.10.0

## [12.5-1] - 2024-04-05
### Changed
- Update debian to 12.5 (#11)

## [12.2-1] - 2023-11-06
### Changed
- Update debian to 12.2 (#8)

## [11.8-2] - 2024-06-06
### Changed
- [#15] Backport from 12.5-2: Update doguctl to v0.10.0

## [11.8-1] - 2023-11-02
### Changed
- Update debian to 11.8 (#7)

## [11.6-1] - 2023-04-21
### Changed
- Update debian to 11.6 (#3)
- Remove curl,wget and vim-tiny

## [11.2-2] - 2022-01-31
### Changed
- Unpack doguctl to /usr/bin to make the `doguctl` command available (#1)

## [11.2-1] - 2022-01-28
### Added
- Initial content to create the debian base image
