#$HOMEDRIVE="d:"
#$HOMEPATH=Get-Location #"."
#ECHO HOMEDRIVE=$HOMEDRIVE
#ECHO HOMEPATH=$HOMEPATH

#choco install openssl

#openssl genrsa -out %HOMEDRIVE%%HOMEPATH%\.oci\key.pem -aes128 -passout stdin 2048
#openssl genrsa -out .\.oci\key.pem -aes128 -passout stdin 2048
#openssl genrsa -out .\.oci\key.pem -aes128 -passout stdin 2048

#openssl genrsa -out -in .\.oci\key.pem -out .\.oci\key_public.pem
#openssl rsa -pubout -in .\.oci\key.pem -out .\.oci\key_public.pem

#type .\.oci\key_public.pem
#openssl rsa -pubout -outform DER -in .\.oci\key.pem | openssl md5 -c

#ECHO done
#choco install gcloudsdk

#Install-Module GoogleCloud -Confirm
gcloud init

$ProjectId="blessedbeyond"#-beyond-foundation"
$AccountId="devops"
ECHO ProjectId=$ProjectId\nAccountId=$AccountId

#gcloud auth login

gcloud config set project $ProjectId

#gcloud iam service-accounts create $AccountId
$iamaccount = "$($AccountId)@$($ProjectId).iam.gserviceaccount.com"
ECHO "iamaccount=$($iamaccount)"
gcloud iam service-accounts keys create key.json --iam-account=$iamaccount
#export GOOGLE_APPLICATION_CREDENTIALS=key.json
#setx GOOGLE_APPLICATION_CREDENTIALS=key.json
$env:GOOGLE_APPLICATION_CREDENTIALS = Resolve-Path 'key.json'

#./my_application.sh

Write-Output Done