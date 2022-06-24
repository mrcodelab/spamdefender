# spamdefender
Restrict internet traffic from spam/adult/malicious content and/or attackers

# About

We all know there's a ton of links on the internet that will redirect the unsuspecting to <i>questionable</i> websites. Tragically, the generation who raised us to "Never trust strangers you meet on the internet" is now one of the most susceptable to click-bait and phishing. This toolset is created and maintained to defend my parents from spammers, phishers, and malicious "advertising" click-bait. I leverage the built in functionality of the Windows host file and PowerShell scripting. I've included some common Windows tune up tasks to keep their computers running efficiently, longer. I don't have a way to sign PowerShell scripts to Microsoft's satisfaction so execution policy in my test environment is "Bypass". I've added a self-validating hash check to confirm the version running is the same one I commit. This tool is free and open to anyone who wants to review my code - hopefully you'll find it helpful!

<h3>For my fellow script kiddies out there, I'm applying the basic principles of PiHole DNS on a by-machine basis and running Windows cleanup utilities</h3>

<h2>Things This Will Do</h2>
<ul>
<li>Update itself and validate against the hash value for the tool.</li>
<li>Run Windows and Microsoft update, install, and automatically reboot if necessary.</li>
<li>Deploy an extensive host file to redirect adult content and many click-bait websites to 127.0.0.1 giving the user "Address could not be resolved" error in the browser.*</li>
<li>Run the Windows Disk Cleanup utility to clear out the system clutter.</li>
<li>Dump the recycle bin.</li>
</ul>

<h2>Things This Cannot Do</h2>
<ul>
<li>Defend email in any way.</li>
<li>Prevent malicious code download or execution from a malicious link.</li>
<li>Replace a proper antivirus product.**</li>
<li>Prevent any inbound malicious activity to smartphones.</li>
</ul>

<h1>Pre-Requisites</h1>
<ul>
<li>PowerShell scripting <strong>MUST</strong> be enabled.</li>
</ul>

<h3>Caviats</h3>
*Deploying the host file requires 1) PowerShell running in admin mode, 2) Antivirus temporarily disabled. Windows Defender is ok with the operation, but because <i>hosts</i> is a system file, changing it in any way gets blocked by commercial antivirus products. So far I can confirm Webroot and McAfee will block the task.
**This tool <strong>WILL NOT, in any way</strong>, replace the need for antivirus software. I make no endorsements of any existing products on the market.
