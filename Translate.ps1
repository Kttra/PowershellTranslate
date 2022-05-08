<#  Powershell script that translates text to english
    using google translate api.

    If the file doesn't run properly on windows, you need to
    run the script using powershell.

    If the script immediately closes, try running the following
    command in powershell as administrator:
    
        set-executionpolicy remotesigned

    The issue could be PowerShell's default security level, where
    (IIRC) will only run signed scripts. This command will tell
    PowerShell to allow local (that is, on a local drive) unsigned
    scripts to run.
#>
param (
    [Parameter(Mandatory=$false)]
    [String]
    $TargetLanguage = "English", # See list of possible languages in $LanguageHashTable below.

    [Parameter(Mandatory=$false)] 
    [String]
    $Text = " " # This can either be the text to translate, or the path to a file containing the text to translate
)
# Create a Hashtable containing the full names of languages as keys and the code for that language as values
$LanguageHashTable = @{ 
Afrikaans='af' 
Albanian='sq' 
Arabic='ar' 
Azerbaijani='az' 
Basque='eu' 
Bengali='bn' 
Belarusian='be' 
Bulgarian='bg' 
Catalan='ca' 
'Chinese Simplified'='zh-CN' 
'Chinese Traditional'='zh-TW' 
Croatian='hr' 
Czech='cs' 
Danish='da' 
Dutch='nl' 
English='en' 
Esperanto='eo' 
Estonian='et' 
Filipino='tl' 
Finnish='fi' 
French='fr' 
Galician='gl' 
Georgian='ka' 
German='de' 
Greek='el' 
Gujarati='gu' 
Haitian ='ht' 
Creole='ht' 
Hebrew='iw' 
Hindi='hi' 
Hungarian='hu' 
Icelandic='is' 
Indonesian='id' 
Irish='ga' 
Italian='it' 
Japanese='ja' 
Kannada='kn' 
Korean='ko' 
Latin='la' 
Latvian='lv' 
Lithuanian='lt' 
Macedonian='mk' 
Malay='ms' 
Maltese='mt' 
Norwegian='no' 
Persian='fa' 
Polish='pl' 
Portuguese='pt' 
Romanian='ro' 
Russian='ru' 
Serbian='sr' 
Slovak='sk' 
Slovenian='sl' 
Spanish='es' 
Swahili='sw' 
Swedish='sv' 
Tamil='ta' 
Telugu='te' 
Thai='th' 
Turkish='tr' 
Ukrainian='uk' 
Urdu='ur' 
Vietnamese='vi' 
Welsh='cy' 
Yiddish='yi' 
}
#Loop the program
while($true) {
# Determine the target language
if ($LanguageHashTable.ContainsKey($TargetLanguage)) {
    $TargetLanguageCode = $LanguageHashTable[$TargetLanguage]
}
elseif ($LanguageHashTable.ContainsValue($TargetLanguage)) {
    $TargetLanguageCode = $TargetLanguage
}
else {
    throw "Unknown target language. Use one of the languages in the `$LanguageHashTable hashtable."
}
# Create a list object to store the finished translation in.
$Translation = New-Object System.Collections.Generic.List[System.Object]
$inputFromUser = @()
$input = ''
While($input -ne "q") {
If ($input -ne $null) {
$InputFromUser += $input.Trim()
}
$input = Read-Host "Enter text to translate here (Enter 'q' to exit)"
}
$inputFromUser = $inputFromUser[1..($inputFromUser.Length-1)].Trim()
$Uri = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$($TargetLanguageCode)&dt=t&q=$inputFromUser"
# Get the response from the web request, then throw a bunch of regex at it to clean it up.
$RawResponse = (Invoke-WebRequest -Uri $Uri -Method Get).Content
$CleanResponse = $RawResponse -split '\\r\\n' -replace '^(","?)|(null.*?\[")|\[{3}"' -split '","'
$CleanResponse = $CleanResponse -replace "\]|\[|_en_2022q1.md|\,|", ""
<# 
Selecting every odd line and adding it to the $Translation list, we recreate the full translated text.
#>
$LineNumber = 0
foreach ($Line in $CleanResponse) {
    $LineNumber++
    if($LineNumber%2) {
        $Translation.Add($Line)
    }
}
$Translation
}
