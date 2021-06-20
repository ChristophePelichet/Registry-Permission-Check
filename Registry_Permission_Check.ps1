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
Write a log (configured by the variable $LOGFULLPATH) with the status (configured by the variable $regPermOk or $regPermKo).

.CONFIGURATION
Configure the registry key you want to check with the variable : $regkey
Configure the account for which you want to check access on the registry key with the variable : $regkeyPerm
Configure the desired text in the log file for the result of the control with the variables : $regPermOk and $regPermKo
Configure the log dir path and the log file name with the variables : $regPermLogDir and $regPermLogFile
Configure the tmp dir and file with the variables : $tmpdir and $tmpRight
Configure the log writed in the log file with th variabke : $date
Configure the text for the result in the log file with the variables : $regPermOk $regPermKo

.LINK

.NOTES
Written by: Christophe Pelichet (c.pelichet@ixion.ch)
 
Find me on: 
 
* LinkedIn:     https://linkedin.com/in/christophepelichet
* Github:       https://github.com/ChristophePelichet
 
Change Log
V1.01   -   06/20/2021  - Clean Code 
V1.00   -   09/29/2020  - Initial version 
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
$regkey = ""


## Registey Key Permission
$regkeyPerm = ""

## Reset registry permission list 
$regPemList = ""

## Log File Name 
$regPermLogDir  = ""
$regPermLogFile = ""
$regPermLogPath = "$regPermLogDir\$regPermLogFile"

## Temp Directory 
$tmpdir =""
$tmpRight = ""
$tmpRightPath = "$tmpdir\$tmpRight"

## Date
$date = (Get-Date -UFormat "%A %m/%d/%Y %R")

# Log Text
$regPermOk = "Permission OK"
$regPermKo = "Permission KO"


#######################################################
######################## Code #########################
#######################################################

## Clean temp right file before loop
if ( test-path $tmpRightPath ) { Remove-Item -Path $tmpRightPath }


## Get Registry Permission
(get-acl -Path $regkey).AccessToString | Format-List Owner | Out-File -FilePath  $tmpRightPath
$regPemList = Get-Content -Path $tmpRightPath

## Reset Loop Counter 
$regCount = 0

## Check if permission is system
foreach ( $regPermResult in $regPemList ) {
    if ( $regPermResult -match "$regkeyPerm" ) {
        $regCount++
    }
}

if ( $regCount -eq "1") {
    Write-Output "$date : $regPermOk" | Out-file -FilePath $regPermLogPath -Append
    } else {
    Write-Output "$date : $regPermKo" | Out-file -FilePath $regPermLogPath -Append
    }


## Clean temp right file after loop
Remove-Item -Path $tmpRightPath