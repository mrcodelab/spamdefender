# SpamDefender
Restrict internet traffic from spam/adult/malicious content and/or attackers

# About

We all know there's a ton of links on the internet that will redirect the unsuspecting to <i>questionable</i> websites. Tragically, the generation who raised us to "Never trust strangers you meet on the internet" is now one of the most susceptable to click-bait and phishing. This toolset is created and maintained to defend my parents from spammers, phishers, and malicious "advertising" click-bait. I leverage the built in functionality of the Windows hosts file and PowerShell scripting. I've included some common Windows tune up tasks to keep their computers running efficiently, longer. I don't have a way to sign PowerShell scripts to Microsoft's satisfaction so execution policy in my test environment is "Bypass". I've added a self-validating hash check to confirm the version running is the same one I commit.

I would encourage any mildy tech savvy parent to skim through the hosts file. You need to understand 1) this hosts file is relatively small compared to a PiHole DNS blacklist, 2) the internet is full of unsavory things that children could accidentally connect to because the url looks so close to reputable companies.

This tool is free and open to anyone who wants to review my code - hopefully you'll find it helpful!

<h3>For my fellow script kiddies out there, I'm applying the basic principles of PiHole DNS on a by-machine basis and running Windows cleanup utilities</h3>

<h2>Things This Will Do</h2>
<ul>
<li>Confirm a security flaw in MS Office is blocked from remote exploit.</li>
<ul><li>Removes the MSDT registry vulnerability</li></ul>
<li>Update itself and validate against the hash value for the tool.</li>
<li>Run Windows and Microsoft update, install, and automatically reboot if necessary.</li>
<li>Deploy an extensive hosts file to redirect adult content and many phishing/click-bait websites to 127.0.0.1 giving the user "Address could not be resolved" error in the browser.*</li>
<li>Run the Windows Disk Cleanup utility to clear out the system clutter.</li>
<li>Dump the recycle bin.</li>
</ul>

<h2>Things This Cannot Do</h2>
<ul>
<li>Defend email in any way.</li>
<li>Prevent malicious code download or execution from a malicious link.</li>
<li>Replace a proper antivirus product.**</li>
<li>Prevent any malicious activity targeting smartphones.</li>
</ul>

<h1>Pre-Requisites</h1>
<ul>
<li>PowerShell scripting <strong>MUST</strong> be enabled.</li>
<ul><li>Set-ExecutionPolicy Bypass***</li></ul>
</ul>

<h2>Platforms</h2>
This toolset is written in PowerShell and tested on Windows 10. I do not have the wherewithall to write or test for any other operating system (looking at you Apple).

<br>
<h2>1st Time Setup</h2>
<ol>
<li>Create a folder in 'C:\Program Files\' called zAdmin<li>
<li>Run powershell.exe as administrator</li>
<li>Set-ExecutionPolicy Bypass</li>
<li>Save spamdefender.ps1 to the new zAdmin folder</li>
<li>Disable antivirus for 1st run</li>
<li>From the admin powershell window run: <i>powershell.exe 'C:\Program Files\zAdmin\spamdefender.ps1'</i>
<ul><li><strong>Select reboot option to immediately reboot the computer and turn antivirus back on!</strong></li></ul>
</ol>


<h3>Caviats</h3>
*Deploying the hosts file requires 1) PowerShell running in admin mode, 2) Antivirus temporarily disabled. Windows Defender is ok with the operation, but because <i>hosts</i> is a system file, changing it in any way gets blocked by commercial antivirus products. So far I can confirm Webroot and McAfee will block the task.<br>
**This tool <strong>WILL NOT, in any way</strong>, replace the need for antivirus software. I make no endorsements of any existing products on the market.<br>
***I can't afford the infrastructure to be a "Trusted Publisher" in Microsoft's eyes. My script security model is a SHA256 hash test. If the hash test fails for any reason, the script will not update; instead it will run against the last successful hash version. This prevents code tampering after publishing the latest version.<br>

<strong>NOTE: </strong>When this tool says it is deleting something, it is a hard delete. There is no getting it back from Recycle Bin.
<p>Note: The hosts file does not change often. After the initial run of spamdefender.ps1, the script will mostly ignore that step. When an updated hosts file is published the script will prompt you to disable antivirus and re-run to get the latest filter.</p>
