#!/bin/bash

#Return count of email accounts per cPanel user

output="User\tDomain\t# Email Accounts\n\n------------------\t---------------------------------------\t--------------------";

for i in `cat /etc/localdomains`; do
    line=`grep -E ^$i: /etc/userdomains`;
    if [ ! -z "$line" -a "$line" != " " ]; then
            re="^([^-]+): (.*)$";
            [[ $line =~ $re ]] && domain="${BASH_REMATCH[1]}" && user="${BASH_REMATCH[2]}";
            wc="`wc -l "/home/"$user"/etc/"$domain"/passwd" 2>/dev/null`";
            re="^([^-]+) (.*)$";
            [[ $wc =~ $re ]] && count="${BASH_REMATCclearH[1]}";
            output="$output\n$user\t$domain\t$count";
    fi
done

echo -ne $output | column -s $'\t' -t;
