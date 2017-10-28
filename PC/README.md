# Extended PKCS#11 driver for Windows + Demo

This readme explains how it is possible to run an application that uses the extended PKCS#11 API to integrate with the HSM.

Steps:
1. Install FlashPro5 so that the hardware drivers are installed.
2. Connect the Smartfusion2 Security Evaluation kit to your PC.
3. The API uses COM7 by default - make sure the FlashPro5 Serial Converter D port is set to COM7 by checking your Device Manager.
4. Make sure OpenSSL is installed for the Simple Time Service (STS) to work: https://slproweb.com/products/Win32OpenSSL.html https://www.tbs-certificates.co.uk/FAQ/en/openssl-windows.html
5. Make sure cURL is installed for the STS to work: https://curl.haxx.se/dlwiz/
6. sts.bat and /timestamp must be in the same path as the executable.
7. Create two projects with Visual Studio inside a single solution: (this way you don't need to copy the DLL into the right directory)
	a. One contains the PKCS11_Driver files.
	b. The other one contains the demo (HSMApp).
8. You may need DIRENT on your system, for example: https://github.com/tronkko/dirent
8. Compile and run the executable.