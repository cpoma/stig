# CHANGELOG

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [UNRELEASED]
### Added
-- [isuftin@usgs.gov] - Sticking to major version of CentOS in Test Kitchen
-- [isuftin@usgs.gov] - STIG 6.1.6 - File permissions for /etc/passwd-
-- [cpoma@mitre.org] - Added default["stig"]["mount_disable"]["disable_usb_storage"] to disable USB Storage. RHEL-06-000503 - CCI-001250
-- [cpoma@mitre.org] - Configure /etc/security/limits.conf max_login default to 10 or less. This capability uses a DataBag value in proc_hard.rb, if present
-- [cpoma@mitre.org] - Added default['stig']['postfix']['smtpd_client_restrictions_rhel'] for use in
templates/default/etc_man.cf_rhel.erb to disable mail relaying. RHEL-07-040480 - CCI-000366
-- [kdshah@mitre.org] - Added template for /etc/inittab - CCE-4241-6
-- [kdshah@mitre.org] - Added default['stig']['login_defs']['pass_min_length'],
default['stig']['login_defs']['umask'], default['stig']['login_defs']['inactive_days'], default['stig']['login_defs']['fail_delay'] for use in templates/default/etc_default_useradd.erb and templates/default/logon_defs.erb
-- [kdshah@mitre.org] - Added local_users recipe to remove users and folders that do not belong. Set shells for various service accounts.
### Updated
-- [isuftin@usgs.gov] - STIG 6.2.7 - Update script to check for users having a home dir
-- [isuftin@usgs.gov] - Narrowed down sshd MACs config to what works for EL6 and EL7
-- [isuftin@usgs.gov] - STIG 6.2.2-6.2.4 - Updated grep testing criteria for audit script
-- [isuftin@usgs.gov] - STIG 5.2.12 - Updated ClientAliveInterval to 300 and ClientAliveCountMax to 0
-- [isuftin@usgs.gov] - STIG 5.1.3 - 5.1.7 - Change permissions for cron files from 0600 to 0700
-- [isuftin@usgs.gov] - STIG 4.1.9 - Update audit.rules for /vat/log/wtmp and
/var/log/btmp from session to logins
-- [isuftin@usgs.gov] - STIG 4.1.7 - Update audit.rules with expanded MAC-policy check
-- [isuftin@usgs.gov] - STIG 2.2.15 - Change inet_interfaces from localhost to loopback_only
-- [isuftin@usgs.gov] - Removed `-e` flag from proc_hard recipe's sysctl resource
since I do not want errors from that guard ignored
-- [isuftin@usgs.gov] - Fixed ChefSpec test for updated functionality in proc_hard
-- [isuftin@usgs.gov] - Fixed node concatenation in rsyslog recipe. Now no longer directly manipulating node attributes
-- [isuftin@usgs.gov] - Updated deprecated fauxhai CnetOS 6 version from 6.7 to 6.9
-- [isuftin@usgs.gov] - proc_hard recipe now calls on the sysctl cookbook's
sysctl_param resource instead of any recipe. This allows the this cookbook to use
sysctl cookbook version >= 1.0.0
-- [isuftin@usgs.gov] - Removed version constraint from Berksfile for sysctl
-- [isuftin@usgs.gov] - Updated Chefspec test to remove test for sysctl::apply recipe
-- [isuftin@usgs.gov] - Add guard to sysctl call in order to work around bug https://github.com/chef/chef/issues/7189
-- [isuftin@usgs.gov] - Switched Changelog format
-- [isuftin@usgs.gov] - Fixed styling for Rubocop 0.55.0
-- [kdshah@mitre.org] - Added SSH private host key file permission to recipe/sshd_config.rb
### Fixed
-- [cpoma@mitre.org] - Bugfix in stig/recipes/mail_transfer_agent.rb to use platform_family versus platform
-- [cpoma@mitre.org] - Bugfix in stig/attributes/default.rb - Errors out and sshd dies (bricking machine) on RH 7
when FIPS Mode is enabled. Non-FIPS compliant MACs were specified. FIPS MODE is required to be enabled - RHEL-07-021350 - CCI-002476
Old Line: default['stig']['sshd_config']['macs'] = 'hmac-md5,hmac-sha1,hmac-ripemd160,hmac-sha1-96,hmac-md5-96'
Replaced with: default['stig']['sshd_config']['macs'] = 'hmac-sha2-512,hmac-sha2-256,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com'
See https://people.redhat.com/swells/scap-security-guide/tables/table-rhel7-stig.html
See http://csrc.nist.gov/groups/STM/cmvp/documents/140-1/140sp/140sp2630.pdf
-- [cpoma@mitre.org] - Added "install fat /bin/true" to stig/templates/etc_modprobe.d_CIS.conf.erb. This will fully disable vfat.

## [0.6.11]
### Updated
-- [isuftin@usgs.gov] - Due to a change in the Chef client @ 13.7.16, the aide
recipe needed to be updated. Also updated Rubocop, Chefspec and Foodcritic issues

## [0.6.10]
### Added
-- [jmorris@usgs.gov] - Added template for /etc/aide.conf and it updates the aide database
-- [jmorris@usgs.gov] - Added default attributes for Centos 6 & 7 for /etc/aide.conf
-- [jmorris@usgs.gov] - Added inspec and unit tests for /etc/aide.conf
### Updated
-- [jmorris@usgs.gov] - Corrected inspec tests centos7 to run aide tests for redhat platforms

## [0.6.9]
### Updated
-- [isuftin@usgs.gov] - Updated more audit not included in the last version
-- [isuftin@usgs.gov] - Combined two audit steps into one to save time/processing

## [0.6.8]
### Updated
-- [isuftin@usgs.gov] - Updated audit scripts to not double-check file mounts that
may appear twice in df output

## [0.6.7]
### Updated
-- [jmorris@usgs.gov] - Updated defaults for audit.rules to avoid 32/64 bit syscall mismatch warning
-- [jmorris@usgs.gov] - Updated unit tests to work around errors
-- [jmorris@usgs.gov] - Updated style tests for later version of foodcritic/rubocop
### Removed
-- [jmorris@usgs.gov] - Removed "redhat" from the test for purging the avahi-daemon package

## [0.6.6]
### Updated
-- [isuftin@usgs.gov] - Updating the cookbook to work properly with CentOS 7
-- [isuftin@usgs.gov] - Added disabling vfat and ipv6 to modprobe
-- [isuftin@usgs.gov] - Update avahi daemon recipe for CentOS 7 (chkconfig vs sysctl)
-- [isuftin@usgs.gov] - Update ipv6 recipe for CentOS 7
-- [isuftin@usgs.gov] - Fixed idempotency issue in ipv6 recipe for CentOS 6
-- [isuftin@usgs.gov] - Update dhcp recipe for CentOS 7
-- [isuftin@usgs.gov] - Update rsyslog.conf default attributes to the latest CIS recommendations
-- [isuftin@usgs.gov] - Update sshd_config template to put logic on keywords that may or may not exist in sshd
-- [isuftin@usgs.gov] - Switched system_auth recipe to use templates instead of very touchy sed/grep
-- [isuftin@usgs.gov] - Changed default PASS_MIN_DAYS in login_defs to 7 as per stig
-- [isuftin@usgs.gov] - Updated file_permissions recipe to not branch on ubuntu/rhel
-- [isuftin@usgs.gov] - Split InSpec tests into CentOS 6 and CentOS 7
-- [isuftin@usgs.gov] - Updated Gemfile to require a minimal inspec gem version

## [0.6.5]
### Updated
-- [isuftin@usgs.gov] - Leaving sysctl attribute mutation solely to the sysctl cookbook.
-- [isuftin@usgs.gov] - Removing STIG cookbook attributes for sysctl. Using only sysctl cookbook attributes

## [0.6.4]
### Updated
-- [isuftin@usgs.gov] - Update mail transfer agent recipe to fully parameterize the CentOS template for main.cf

## [0.6.3]
### Updated
-- [isuftin@usgs.gov] - Update the system_auth recipe to respect pre-existing symlinks
-- [isuftin@usgs.gov] - Fix boot_settings recipe to catch if selinux is disabled and move on

## [0.6.2]
### Updated
-- [isuftin@usgs.gov] - More testing
-- [isuftin@usgs.gov] - Updated auditd ruleset to include more rules
-- [isuftin@usgs.gov] - Created ChefSpec testing for auditd_rules recipe
-- [isuftin@usgs.gov] - Updated ServerSpec testing for all default auditd rules

## [0.6.1]
### Updated
-- [isuftin@usgs.gov] - More rubocop fixes
-- [isuftin@usgs.gov] - Rework of sshd_config recipe to allow more customization
-- [isuftin@usgs.gov] - Updated templates to point to proper GitHub URL
-- [isuftin@usgs.gov] - Updated dependency version for sysctl cookbook in Berksfile
-- [isuftin@usgs.gov] - Fixed kitchen converge warnings

## [0.6.0]
### Updated
-- [steve@bigsteve.us] - fix some rubocop violations
-- [steve@bigsteve.us] - switch to using chef inspec
-- [steve@bigsteve.us] - remove Centos 6.6 and 6.8  
-- [steve@bigsteve.us] - bump version to 0.6.0
-- [steve@bigsteve.us] - remove kitchen version pin.

## [0.5.5]
### Updated
-- [arothian@github] - Update aide to setup crontab for ubuntu

## [0.5.4]
### Updated
-- [isuftin@usgs.gov] - Fix an issue with auth-config being improperly written to for pass reuse limit

## [0.5.3]
### Updated
-- [isuftin@usgs.gov] - Switch sysctl write flags

## [0.5.2]
### Updated
-- [isuftin@usgs.gov] - Ignore errors on unknown sysctl keys

## [0.5.1]
### Updated
-- [isuftin@usgs.gov] - Included third-party sysctl cookbook as a hard-coupled dependency by calling it in proc_hard recipe

## [0.5.0]
### Updated
-- [isuftin@usgs.gov] - Switched sysctl.conf template writing out and brought in the third-party sysctl cookbook to handle writing .d config file
-- [isuftin@usgs.gov] - Updated serverspec testing

## [0.4.3]
### Updated
-- [isuftin@usgs.gov] - Updated to switch out which file in /etc/pam.d/system-auth* gets symlinked

## [0.4.2]
### Updated
-- [isuftin@usgs.gov] - Fix most foodcritic errors and warnings
-- [isuftin@usgs.gov] - CIS 1.6.2 (Configure ExecShield) was removed in 2.0.0 of all CIS STIG. No longer testing for it
-- [isuftin@usgs.gov] - Added updates to SSHD config to allow boolean for password authentication
-- [isuftin@usgs.gov] - Updated system auth recipe to be less destructive to /etc/pam.d/system-auth since that may be updated by authconfig
-- [isuftin@usgs.gov] - Fixed a few tests

## [0.4.1]
### Updated
-- [isuftin@usgs.gov] - Updated sshd config to include approved ciphers (RHEL6 STIG 6.2.11)
-- [isuftin@usgs.gov] - Added the ability to change `ChallengeResponseAuthentication` in sshd config
-- [isuftin@usgs.gov] - Added the ability to change `UsePAM` in sshd config

## [0.4.0]
### Updated
-- [isuftin@usgs.gov] - Users may now add auditd rules directly as a series of attributes

## [0.3.11]
### Updated
-- [isuftin@usgs.gov] - More Auditd fixes

## [0.3.10]
### Updated
-- [isuftin@usgs.gov] - Fix auditd default parameters which break the build
-- [isuftin@usgs.gov] - Add documentation for new attributes

## [0.3.9]
### Updated
-- [isuftin@usgs.gov] - Fully parameterized auditd configuration file
-- [isuftin@usgs.gov] - No longer calling the auditd cookbook directly from auditd.rb
-- [isuftin@usgs.gov] - Auditd cookbook is no longer a direct dependency of the STIG cookbook. Should be part of an overall runlist

## [0.3.8]
### Updated
-- [isuftin@usgs.gov] - Updated STIG and Audit rules to CIS RHEL Stig 1.4.0
-- [isuftin@usgs.gov] - Added CentOS 6 ruleset 3.2 - "Remove the X Window System"
-- [isuftin@usgs.gov] - Fixed and added many Serverspec tests
-- [isuftin@usgs.gov] - Corrected a typo in `check_duplicate_gid.sh` to correct STIG control number
-- [isuftin@usgs.gov] - Removed CIS wording from audit scripts
-- [isuftin@usgs.gov] - Enforced permissions on /boot/grub/grub.conf as per STIG 1.5.2
-- [isuftin@usgs.gov] - Removed grub.conf template
-- [isuftin@usgs.gov] - Updated mounting of /dev/shm to be idempotent
