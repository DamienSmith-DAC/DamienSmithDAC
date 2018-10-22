# Certificate Expiration Check

## SUMMARY

Check the certificate expiration status for each of application.

## ISSUE

[DAC-1393](https://nswdac.atlassian.net/browse/DAC-1393) Check SSL certificate expiration on DAC servers

## MODULE

[https://github.com/NSWDAC/Platform/tree/master/Operations](https://github.com/NSWDAC/Platform/tree/master/Operations)

## USAGE

1.  clone the module:
    1.  git clone [https://github.com/NSWDAC/Platform.git](https://github.com/NSWDAC/Platform.git)
2.  change to Certificate Expiry Check directory:
    1.  cd "Certificate Expiry Check"
3.  run the script:
    1.  perl [cert-expiry.pl](http://cert-expiry.pl)
4.  it will send the emails with html format to users declared by $to in the script

## NOTE

-   The check list captured from [DAC Platform User Applications](http://nswdac.atlassian.net/wiki/spaces/DELV/pages/63766934/DAC+Platform+User+Applications).
-   Update the hash array in the module for checking the required applications or links.
-   This script needs openssl to parsing the certificate details, check the availability of openssl in the server before run the script.

## SNAPSHOT

![](https://nswdac.atlassian.net/wiki/download/thumbnails/823164982/image2018-10-23_10-19-2.png?version=1&modificationDate=1540250344623&cacheVersion=1&api=v2&width=512 "Operations > Platform maintenance > image2018-10-23_10-19-2.png")
