@REM <# : batch portion
@REM @REM ----------------------------------------------------------------------------
@REM @REM Licensed to the Apache Software Foundation (ASF) under one
@REM @REM or more contributor license agreements.  See the NOTICE file
@REM @REM distributed with this work for additional information
@REM @REM regarding copyright ownership.  The ASF licenses this file
@REM @REM to you under the Apache License, Version 2.0 (the
@REM @REM "License"); you may not use this file except in compliance
@REM @REM with the License.  You may obtain a copy of the License at
@REM @REM
@REM @REM    http://www.apache.org/licenses/LICENSE-2.0
@REM @REM
@REM @REM Unless required by applicable law or agreed to in writing,
@REM @REM software distributed under the License is distributed on an
@REM @REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM @REM KIND, either express or implied.  See the License for the
@REM @REM specific language governing permissions and limitations
@REM @REM under the License.
@REM @REM ----------------------------------------------------------------------------
@REM
@REM @REM ----------------------------------------------------------------------------
@REM @REM Apache Maven Wrapper startup batch script, version 3.3.2
@REM @REM
@REM @REM Optional ENV vars
@REM @REM   MVNW_REPOURL - repo url base for downloading maven distribution
@REM @REM   MVNW_USERNAME/MVNW_PASSWORD - user and password for downloading maven
@REM @REM   MVNW_VERBOSE - true: enable verbose log; others: silence the output
@REM @REM ----------------------------------------------------------------------------
@REM
@REM @IF "%__MVNW_ARG0_NAME__%"=="" (SET __MVNW_ARG0_NAME__=%~nx0)
@REM @SET __MVNW_CMD__=
@REM @SET __MVNW_ERROR__=
@REM @SET __MVNW_PSMODULEP_SAVE=%PSModulePath%
@REM @SET PSModulePath=
@REM @FOR /F "usebackq tokens=1* delims==" %%A IN (`powershell -noprofile "& {$scriptDir='%~dp0'; $script='%__MVNW_ARG0_NAME__%'; icm -ScriptBlock ([Scriptblock]::Create((Get-Content -Raw '%~f0'))) -NoNewScope}"`) DO @(
@REM   IF "%%A"=="MVN_CMD" (set __MVNW_CMD__=%%B) ELSE IF "%%B"=="" (echo %%A) ELSE (echo %%A=%%B)
@REM )
@REM @SET PSModulePath=%__MVNW_PSMODULEP_SAVE%
@REM @SET __MVNW_PSMODULEP_SAVE=
@REM @SET __MVNW_ARG0_NAME__=
@REM @SET MVNW_USERNAME=
@REM @SET MVNW_PASSWORD=
@REM @IF NOT "%__MVNW_CMD__%"=="" (%__MVNW_CMD__% %*)
@REM @echo Cannot start maven from wrapper >&2 && exit /b 1
@REM @GOTO :EOF
@REM : end batch / begin powershell #>
@REM
@REM $ErrorActionPreference = "Stop"
@REM if ($env:MVNW_VERBOSE -eq "true") {
@REM   $VerbosePreference = "Continue"
@REM }
@REM
@REM # calculate distributionUrl, requires .mvn/wrapper/maven-wrapper.properties
@REM $distributionUrl = (Get-Content -Raw "$scriptDir/.mvn/wrapper/maven-wrapper.properties" | ConvertFrom-StringData).distributionUrl
@REM if (!$distributionUrl) {
@REM   Write-Error "cannot read distributionUrl property in $scriptDir/.mvn/wrapper/maven-wrapper.properties"
@REM }
@REM
@REM switch -wildcard -casesensitive ( $($distributionUrl -replace '^.*/','') ) {
@REM   "maven-mvnd-*" {
@REM     $USE_MVND = $true
@REM     $distributionUrl = $distributionUrl -replace '-bin\.[^.]*$',"-windows-amd64.zip"
@REM     $MVN_CMD = "mvnd.cmd"
@REM     break
@REM   }
@REM   default {
@REM     $USE_MVND = $false
@REM     $MVN_CMD = $script -replace '^mvnw','mvn'
@REM     break
@REM   }
@REM }
@REM
@REM # apply MVNW_REPOURL and calculate MAVEN_HOME
@REM # maven home pattern: ~/.m2/wrapper/dists/{apache-maven-<version>,maven-mvnd-<version>-<platform>}/<hash>
@REM if ($env:MVNW_REPOURL) {
@REM   $MVNW_REPO_PATTERN = if ($USE_MVND) { "/org/apache/maven/" } else { "/maven/mvnd/" }
@REM   $distributionUrl = "$env:MVNW_REPOURL$MVNW_REPO_PATTERN$($distributionUrl -replace '^.*'+$MVNW_REPO_PATTERN,'')"
@REM }
@REM $distributionUrlName = $distributionUrl -replace '^.*/',''
@REM $distributionUrlNameMain = $distributionUrlName -replace '\.[^.]*$','' -replace '-bin$',''
@REM $MAVEN_HOME_PARENT = "$HOME/.m2/wrapper/dists/$distributionUrlNameMain"
@REM if ($env:MAVEN_USER_HOME) {
@REM   $MAVEN_HOME_PARENT = "$env:MAVEN_USER_HOME/wrapper/dists/$distributionUrlNameMain"
@REM }
@REM $MAVEN_HOME_NAME = ([System.Security.Cryptography.MD5]::Create().ComputeHash([byte[]][char[]]$distributionUrl) | ForEach-Object {$_.ToString("x2")}) -join ''
@REM $MAVEN_HOME = "$MAVEN_HOME_PARENT/$MAVEN_HOME_NAME"
@REM
@REM if (Test-Path -Path "$MAVEN_HOME" -PathType Container) {
@REM   Write-Verbose "found existing MAVEN_HOME at $MAVEN_HOME"
@REM   Write-Output "MVN_CMD=$MAVEN_HOME/bin/$MVN_CMD"
@REM   exit $?
@REM }
@REM
@REM if (! $distributionUrlNameMain -or ($distributionUrlName -eq $distributionUrlNameMain)) {
@REM   Write-Error "distributionUrl is not valid, must end with *-bin.zip, but found $distributionUrl"
@REM }
@REM
@REM # prepare tmp dir
@REM $TMP_DOWNLOAD_DIR_HOLDER = New-TemporaryFile
@REM $TMP_DOWNLOAD_DIR = New-Item -Itemtype Directory -Path "$TMP_DOWNLOAD_DIR_HOLDER.dir"
@REM $TMP_DOWNLOAD_DIR_HOLDER.Delete() | Out-Null
@REM trap {
@REM   if ($TMP_DOWNLOAD_DIR.Exists) {
@REM     try { Remove-Item $TMP_DOWNLOAD_DIR -Recurse -Force | Out-Null }
@REM     catch { Write-Warning "Cannot remove $TMP_DOWNLOAD_DIR" }
@REM   }
@REM }
@REM
@REM New-Item -Itemtype Directory -Path "$MAVEN_HOME_PARENT" -Force | Out-Null
@REM
@REM # Download and Install Apache Maven
@REM Write-Verbose "Couldn't find MAVEN_HOME, downloading and installing it ..."
@REM Write-Verbose "Downloading from: $distributionUrl"
@REM Write-Verbose "Downloading to: $TMP_DOWNLOAD_DIR/$distributionUrlName"
@REM
@REM $webclient = New-Object System.Net.WebClient
@REM if ($env:MVNW_USERNAME -and $env:MVNW_PASSWORD) {
@REM   $webclient.Credentials = New-Object System.Net.NetworkCredential($env:MVNW_USERNAME, $env:MVNW_PASSWORD)
@REM }
@REM [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
@REM $webclient.DownloadFile($distributionUrl, "$TMP_DOWNLOAD_DIR/$distributionUrlName") | Out-Null
@REM
@REM # If specified, validate the SHA-256 sum of the Maven distribution zip file
@REM $distributionSha256Sum = (Get-Content -Raw "$scriptDir/.mvn/wrapper/maven-wrapper.properties" | ConvertFrom-StringData).distributionSha256Sum
@REM if ($distributionSha256Sum) {
@REM   if ($USE_MVND) {
@REM     Write-Error "Checksum validation is not supported for maven-mvnd. `nPlease disable validation by removing 'distributionSha256Sum' from your maven-wrapper.properties."
@REM   }
@REM   Import-Module $PSHOME\Modules\Microsoft.PowerShell.Utility -Function Get-FileHash
@REM   if ((Get-FileHash "$TMP_DOWNLOAD_DIR/$distributionUrlName" -Algorithm SHA256).Hash.ToLower() -ne $distributionSha256Sum) {
@REM     Write-Error "Error: Failed to validate Maven distribution SHA-256, your Maven distribution might be compromised. If you updated your Maven version, you need to update the specified distributionSha256Sum property."
@REM   }
@REM }
@REM
@REM # unzip and move
@REM Expand-Archive "$TMP_DOWNLOAD_DIR/$distributionUrlName" -DestinationPath "$TMP_DOWNLOAD_DIR" | Out-Null
@REM Rename-Item -Path "$TMP_DOWNLOAD_DIR/$distributionUrlNameMain" -NewName $MAVEN_HOME_NAME | Out-Null
@REM try {
@REM   Move-Item -Path "$TMP_DOWNLOAD_DIR/$MAVEN_HOME_NAME" -Destination $MAVEN_HOME_PARENT | Out-Null
@REM } catch {
@REM   if (! (Test-Path -Path "$MAVEN_HOME" -PathType Container)) {
@REM     Write-Error "fail to move MAVEN_HOME"
@REM   }
@REM } finally {
@REM   try { Remove-Item $TMP_DOWNLOAD_DIR -Recurse -Force | Out-Null }
@REM   catch { Write-Warning "Cannot remove $TMP_DOWNLOAD_DIR" }
@REM }
@REM
@REM Write-Output "MVN_CMD=$MAVEN_HOME/bin/$MVN_CMD"
