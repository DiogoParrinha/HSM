# Hardware Secure Module for Smartfusion2 FPGA

This is the work of my Master thesis in Electrical and Computer Engineering at Instituto Superior Técnico, Lisbon. The goal is develop a Hardware Secure Module on a non-volatile FPGA (in this case, the Smartfusion2 FPGA). The HSM works together with a Windows API which should be used by a developer to integrate the system into another software.

The system contains a root administrator who can manage users (add/delete/modify).

The following features are available:
* Administrator can generate assymetric key pair for a certain user (both are stored securely in an external flash)
* User can request data to be signed using its previously generated private key (ECDSA)
* Provide X.509v3 digital certificates of generated public keys (to anyone to requests)
* Issue X.509v3 digital certificates for a given public key (requested by an administrator)
* Log actions executed from a certain server (author|action|date) (another software can use this to ensure non-repudiation of executed actions by server administrators for example)

This system uses the mbedTLS library to perform algorithms such as ECDSA and ECDH.
Because the Smartfusion2 ('S' models') provide Data Security features such as SHA-256, AES-256 and ECC, they are used to increase performance.

This repository contains two main folders: HSM and PC.

The HSM contains the software responsible for handling the Hardware Secure Module features, while the PC contains the PC driver that communicates with the device.


