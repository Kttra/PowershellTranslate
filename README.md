# Powershell Translate
A powershell script that translates text given by the user (uses google translate). The script is set up to take in multiple lines until q is typed. After q is typed, the translation will be outputted. By default, the script translates text to English. Edit the script if you want to translate to a different language.

If the file doesn't run properly on windows, you need to run the script using powershell. In the event the script immediately closes, try running the following command in powershell as administrator:

```powershell
    set-executionpolicy remotesigned
```

The issue could be PowerShell's default security level, where (IIRC) will only run signed scripts. This command will tell PowerShell to allow local (that is, on a local drive) unsigned scripts to run.
