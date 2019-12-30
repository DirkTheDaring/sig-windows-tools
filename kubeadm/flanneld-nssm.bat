REM @ECHO OFF
SETLOCAL ENABLEEXTENSIONS

SET IPADDRESS=%1

REM set path to nssm  (installed by chocolatey)
SET PATH=%PATH%;C:\ProgramData\chocolatey\lib\NSSM\tools
REM echo %PATH%

ECHO remove flanneld if installed
nssm.exe stop   FlannelD
nssm.exe remove FlannelD confirm

REM Now setup flanneld via nssm (installed with chocolatey)
nssm.exe install FlannelD "C:\ProgramData\Kubernetes\flanneld.exe"
nssm.exe set FlannelD DependOnService :kubelet
nssm.exe set FlannelD Description "FlannelD Kubernetes Service"
nssm.exe set FlannelD DisplayName FlannelD
nssm.exe set FlannelD ObjectName LocalSystem
nssm.exe set FlannelD Start SERVICE_AUTO_START
nssm.exe set FlannelD Type SERVICE_WIN32_OWN_PROCESS
nssm.exe set FlannelD AppEnvironmentExtra NODE_NAME=qemu-pc
nssm.exe set FlannelD AppParameters -kubeconfig-file="c:\ProgramData\Kubernetes\config" -iface=%IPADDRESS% -ip-masq=1 -kube-subnet-mgr=1
nssm.exe set FlannelD AppStdout C:\ProgramData\Kubernetes\logs\flanneld\flanneldsvc.log
nssm.exe set FlannelD AppStderr C:\ProgramData\Kubernetes\logs\flanneld\flanneldsvc.log

nssm.exe start FlannelD
nssm.exe dump FlannelD 
