--MergePdf Powershell module utilizes the PDFsharp .NET open-source library for merging of multiple PDFs.
Installation
By default, the Powershell package repository is set as “untrusted”.

PS C:\Windows\system32> Get-PSRepository
/*

Name                      InstallationPolicy   SourceLocation
----                      ------------------   --------------
PSGallery                 untrusted              https://www.powershellgallery.com/api/v2

*/

--To trust this repo, run: Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
PS C:\Windows\system32> Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

/*
Name                      InstallationPolicy   SourceLocation
----                      ------------------   --------------
PSGallery                 untrusted              https://www.powershellgallery.com/api/v2
*/
--Install the module using:
PS C:\Windows\system32> Install-Module -Name MergePdf

PS C:\Windows\system32> Get-ExecutionPolicy
/*
Restricted
*/
--If the output results in “Restricted” make sure the execute the following step.

PS C:\Windows\system32> Set-ExecutionPolicy RemoteSigned
/*
Execution Policy Change
The execution policy helps protect you from scripts that you do not trust. Changing the execution policy might expose you to the security risks described in the about_Execution_Policies help
topic at https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the execution policy?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): y
PS C:\Windows\system32> Get-ExecutionPolicy
RemoteSigned
*/
--Check again the the ExecutionPolicy and please make sure it stated “RemoteSigned”.
PS C:\Windows\system32> cd D:\UserData\Desktop\pdf
PS D:\UserData\Desktop\pdf> dir

/*
    Directory: D:\UserData\Desktop\pdf


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----          3/3/2023  10:35 AM         145078 pdf-1.pdf
-a----         5/22/2023   3:39 PM        1107080 pdf-2.pdf
-a----         5/22/2023   3:39 PM       11926781 pdf-3.pdf
-a----          3/3/2023  10:35 AM         832254 pdf-4.pdf
*/

PS D:\UserData\Desktop\pdf> Merge-pdf
/*
WARNING: OutputPath parameter is not provided. Using current location.


    Directory: D:\UserData\Desktop\pdf


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----          6/9/2023  12:04 PM        3014917 Merged.pdf

*/
PS D:\UserData\Desktop\pdf> dir


    Directory: D:\UserData\Desktop\pdf

/*
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        12/21/2022   4:23 PM         799652 005112680_ANITA KUMARI SAH (2).PDF
-a----        12/21/2022   4:28 PM         629956 005112949_REKHA DEVHI CHAUDHARY.PDF
-a----        12/21/2022   4:29 PM         826857 005113369_SHARMILA KUMARI PAHARI (2).PDF
-a----        12/21/2022   4:24 PM         754966 005113506_NIRAMALA CHAUDHARY (2).PDF
-a----          6/9/2023  12:04 PM        3014917 Merged.pdf
*/