<#
██████╗ ███████╗ ██████╗ ███████╗██╗████████╗██████╗ ██╗   ██╗    ██████╗ ███████╗██████╗ ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗     ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗
██╔══██╗██╔════╝██╔════╝ ██╔════╝██║╚══██╔══╝██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔════╝██╔══██╗████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║    ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝
██████╔╝█████╗  ██║  ███╗███████╗██║   ██║   ██████╔╝ ╚████╔╝     ██████╔╝█████╗  ██████╔╝██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║    ██║     ███████║█████╗  ██║     █████╔╝ 
██╔══██╗██╔══╝  ██║   ██║╚════██║██║   ██║   ██╔══██╗  ╚██╔╝      ██╔═══╝ ██╔══╝  ██╔══██╗██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║    ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ 
██║  ██║███████╗╚██████╔╝███████║██║   ██║   ██║  ██║   ██║       ██║     ███████╗██║  ██║██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║    ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗
╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝
Version 1.0                                                                                                                                                                                          

                                                                                                                                                              
.SYNOPSIS
Registry_Permission_Check.ps1 - Simple script ton check if a permission is applied.

.DESCRIPTION
Simple script ton check if a permission is applied and write a log if ok or not. Useful for debugging coupled with a schedule task to see when the permission changes.

.OUTPUTS
Write a log (configured by the variable $LOGFULLPATH) with the status (configured by the variable $REGPERMOK or $REGPERMKO).

.CONFIGURATION
Configure the registry key you want to check with the variable : $REGKEY
Configure the account for which you want to check access on the registry key with the variable : $REGKEYPERM
Configure the desired text in the log file for the result of the control with the variables : $REGPERMOK and $REGPERMKO
Configure the log dir path and the log file name with the variables : $REGPERMLOGDIR and $REGPERMLOGFILE
Configure the tmp dir and file with the variables : $TMPDIR and $TMPRIGHT
Configure the log writed in the log file with th variabke : $DATE
Configure the text for the result in the log file with the variables : $REGPERMOK $REGPERMKO

.LINK

.NOTES
Written by: Christophe Pelichet (c.pelichet@ixion.ch)
 
Find me on: 
 
* LinkedIn:     https://linkedin.com/in/christophepelichet
* Github:       https://github.com/ChristophePelichet
 
Change Log 
V1.00 - 09/29/2020 - Initial version 
#>



########################################################
######################## Path ##########################
########################################################

## No Path

########################################################
###################### Functions #######################
########################################################

## No Functions 


#######################################################
###################### Variables ######################
#######################################################

## Registry Key Path 
$REGKEY = ""


## Registey Key Permission
$REGKEYPERM = ""

## Reset registry permission list 
$REGPERMLIST = ""

## Log File Name 
$REGPERMLOGDIR  = "C:\Temp"
$REGPERMLOGFILE = "permission_registry_log.txt"
$REGPERMLOGFUPA = "$REGPERMLOGDIR\$REGPERMLOGFILE"

## Temp Directory 
$TMPDIR ="C:\Temp"
$TMPRIGHT = "permission_registry_temp.txt"
$TMPRIGHTPATH = "$TMPDIR\$TMPRIGHT"

## Date
$DATE = (Get-Date -UFormat "%A %m/%d/%Y %R")

# Log Text
$REGPERMOK = "Permission OK"
$REGPERMKO = "Permission KO"


#######################################################
######################## Code #########################
#######################################################

## Clean temp right file before loop
if ( test-path $TMPRIGHTPATH ) { Remove-Item -Path $TMPRIGHTPATH }


## Get Registry Permission
(get-acl -Path $REGKEY).AccessToString | Format-List Owner | Out-File -FilePath  $TMPRIGHTPATH
$REGPERMLIST = Get-Content -Path $TMPRIGHTPATH

## Reset Loop Counter 
$REGCOUNT = 0

## Check if permission is system
foreach ( $REGPERMRESULT in $REGPERMLIST ) {
    if ( $REGPERMRESULT -match "$REGKEYPERM" ) {
        $REGCOUNT++
    }
}

if ( $REGCOUNT -eq "1") {
    Write-Output "$DATE : $REGPERMOK" | Out-file -FilePath $REGPERMLOGFUPA -Append
    } else {
    Write-Output "$DATE : $REGPERMKO" | Out-file -FilePath $REGPERMLOGFUPA -Append
    }


## Clean temp right file after loop
Remove-Item -Path $TMPRIGHTPATH