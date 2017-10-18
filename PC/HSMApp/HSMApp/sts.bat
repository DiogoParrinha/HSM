
@echo off

del "timestamp\verify.txt"

:: set OPENSSL_CONF=C:\OpenSSL-Win32\bin\openssl.cfg

:: Create timestamp request
:: openssl ts -query -data "timestamp\nonce.txt" -cert -sha256 -no_nonce -out "timestamp\request.tsq"

:: Request timestamp
:: timestamp\curl -s -S -H "Content-Type: application/timestamp-query" --data-binary @"timestamp\request.tsq" "http://tsa.safecreative.org/" -o "timestamp\response.tsr"

:: Verify
openssl ts -verify -in "timestamp\response.tsr" -data "timestamp\nonce.txt" -CAfile "timestamp\SafeCreative_TSA.cer"

:: Detailed info
openssl ts -reply -in "timestamp\response.tsr" -text > "timestamp\verify.txt"