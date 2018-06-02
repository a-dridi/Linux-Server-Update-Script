#!/bin/sh

#Automatic Package Update Script for Ubuntu/Debian machine
#Send email about upgrade with log file
#NEEDS packages: mktemp,  python environment, python-gtk2, python-apt, python-dev and aptitude

#Created by http://www.github.com/a-dridi

# Set here your email address.
admin_email="myemail@domain"

# DO NOT EDIT THIS. This is used to create a temporary path in /tmp to write a temporary log
# file.
tempfile=$(mktemp)

#Creating a lockfile to prevent system shutdown or reboot during upgrade process
python -c 'import apt_pkg, gtk; apt_pkg.get_lock("/var/run/unattended-upgrades.lock"); gtk.main()' &

# Commands to update the system and to write the log
# file at the same time.
echo "aptitude update" >> ${tempfile}
aptitude update >> ${tempfile} 2>&1
echo "" >> ${tempfile}
echo "aptitude -y full-upgrade" >> ${tempfile}
aptitude -y full-upgrade >> ${tempfile} 2>&1
echo "" >> ${tempfile}
echo "aptitude clean" >> ${tempfile}
aptitude clean >> ${tempfile} 2>&1

# Commands to send the temporary log via mail. information about whether the upgrade
# was succesful or not is written in the subject field.
if grep -q 'E: \|W: ' ${tempfile} ; then
        mail -s "Linux Server - Update FAILED $(date)" ${admin_email} < ${tempfile}
        echo "Linux Server - Update FAILED $(date)" > /var/log/dailyupdate.log
        cat ${tempfile} >> /var/log/dailyupdate.log
else
        mail -s "Linux Server - Update was sucessfull $(date)" ${admin_email} < ${tempfile}
        echo "Linux Server - Update was sucessfull $(date)" > /var/log/dailyupdate.log
        cat ${tempfile} >> /var/log/dailyupdate.log
fi

# Remove the before created temporary log file.
rm -f ${tempfile}

#delete lockfile - Upgrade process ends here
rm -rf /var/run/unattended-upgrades.lock
