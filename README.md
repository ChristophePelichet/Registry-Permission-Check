# Registry Permission CHeck V1.0                                                                                                                                   

## Description
Simple script ton check if a permission is applied and write a log if ok or not. Useful for debugging coupled with a schedule task to see when the permission changes.

## OUTPUTS
Write a log (configured by the variable $LOGFULLPATH) with the status (configured by the variable $REGPERMOK or $REGPERMKO).

## CONFIGURATION
Configure the registry key you want to check with the variable : $REGKEY
Configure the account for which you want to check access on the registry key with the variable : $REGKEYPERM
Configure the desired text in the log file for the result of the control with the variables : $REGPERMOK and $REGPERMKO
Configure the log dir path and the log file name with the variables : $REGPERMLOGDIR and $REGPERMLOGFILE
Configure the tmp dir and file with the variables : $TMPDIR and $TMPRIGHT
Configure the log writed in the log file with th variabke : $DATE
Configure the text for the result in the log file with the variables : $REGPERMOK $REGPERMKO

## Change Log 
V1.00 - 09/29/2020 - Initial version 
