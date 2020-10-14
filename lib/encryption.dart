import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_encryption/utils/custom_aes_encryption.dart';

class Encryption extends StatefulWidget {
  @override
  _EncryptionState createState() => _EncryptionState();
}

class _EncryptionState extends State<Encryption> {
  TextEditingController tieEncryption = TextEditingController();
  bool isEncrypted = false;
  CustomAESEncryption _aesEncryption = CustomAESEncryption();
  Encrypted encryptedText;

  String decryptedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AES Encryption"),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: tieEncryption,
              decoration: InputDecoration(hintText: "Enter text to encrypt"),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
                "Encrypted Text : ${encryptedText != null ? encryptedText.base64 : ''}"),
            SizedBox(
              height: 8,
            ),
            Text("Decrypted Text : $decryptedText"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      if (tieEncryption.text.toString().trim().length > 0) {
                        encryptedText = Encrypted.from64(_aesEncryption
                            .encrypt(tieEncryption.text.toString().trim()));
                        isEncrypted = true;
                        setState(() {});
                      }
                    },
                    child: Text("Encrypt"),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: RaisedButton(
                    onPressed: isEncrypted
                        ? () {
                      decryptedText = _aesEncryption.decrypt(encryptedText);
                      setState(() {});
                    }
                        : null,
                    child: Text("Decrypt"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
