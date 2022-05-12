# Powershell Translate
A powershell script that translates text given by the user (uses google translate). The script is set up to take in a line. The translation will be immediately outputted afterwards. By default, the script translates text to English. Edit the script if you want to translate to a different language.

If the file doesn't run properly on windows, you need to run the script using powershell. In the event the script immediately closes, try running the following command in powershell as administrator:

```powershell
set-executionpolicy remotesigned
```

The issue could be PowerShell's default security level, where only signed scripts will run. In other words, this command will tell PowerShell to allow local unsigned scripts to run (scripts on a local drive).

**Script Example**
-------------
This is an example of the script translating Spanish to English. Do note that your results may vary because we are receiving the raw response from google translate. I have tried my best to clean up that response as much as possible, but because there are different languages to translate to and from, the script would end up more complicated.

```
Enter text to translate here: No puedo estar más seguro
I can't be more sure
Enter text to translate here: No puedo con esto.
I can not take this.
Enter text to translate here: Mirame a los ojos.
Look me in the eyes.
Enter text to translate here:
```
