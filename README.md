# packer-vsphere
Encode password for unnatend

```Powershell
$UnEncodedText = 'Pa$$w0rd'
$EncodedText =[Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($UnEncodedText))
write-host "Encoded Password:" $EncodedText             

Encoded Password: [encoded password]
```