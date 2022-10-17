#set-variable HOMEDRIVE=d:
#set-variable HOMEPATH=.
#ECHO HOMEDRIVE=%HOMEDRIVE%
#ECHO HOMEPATH=%HOMEPATH%

#choco install openssl

#openssl genrsa -out %HOMEDRIVE%%HOMEPATH%\.oci\key.pem -aes128 -passout stdin 2048
#openssl genrsa -out .\.oci\key.pem -aes128 -passout stdin 2048
openssl genrsa -out .\.oci\key.pem -aes128 -passout stdin 2048

#openssl genrsa -out -in .\.oci\key.pem -out .\.oci\key_public.pem
openssl rsa -pubout -in .\.oci\key.pem -out .\.oci\key_public.pem

#type .\.oci\key_public.pem
openssl rsa -pubout -outform DER -in .\.oci\key.pem | openssl md5 -c

#ECHO done
Write-Output Done