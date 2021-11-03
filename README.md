# Registry Permission Check V1.01

[![CodeQL](https://github.com/ChristophePelichet/Registry-Permission-Check/PSScriptAnalyzer/badge.svg)](https://github.com/ChristophePelichet/Registry-Permission-Check/actions?query=workflow%3APSScriptAnalyzer)

## Description
Simple script ton check if a permission is applied and write a log if ok or not. Useful for debugging coupled with a schedule task to see when the permission changes.

## OUTPUTS
Write a log (configured by the variable $LOGFULLPATH) with the status (configured by the variable $REGPERMOK or $REGPERMKO).

## CONFIGURATION
    - Configure the registry key you want to check with the variable : $regkey
    - Configure the account for which you want to check access on the registry key with the variable : $regkeyPerm
    - Configure the desired text in the log file for the result of the control with the variables : $regPermOk and $regPermKo
    - Configure the log dir path and the log file name with the variables : $regPermLogDir and $regPermLogFile
    - Configure the tmp dir and file with the variables : $tmpdir and $tmpRight
    - Configure the log writed in the log file with th variabke : $date
    - Configure the text for the result in the log file with the variables : $regPermOk $regPermKo

### Change Log
V1.01   -   06/20/2021  - Clean Code 
V1.00   -   09/29/2020  - Initial version 
