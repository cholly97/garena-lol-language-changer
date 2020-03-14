## What is this?

A tool to change the client and in-game language for Garena League of Legends.

LoL is not run by Riot in many regions of Southeast Asia, and instead it is licensed to Garena, which makes the experience different in many ways, one of them being that there is no official way to change the language of the client and in-game UI through either Garena's launcher, or the League client.

According to [this](https://www.reddit.com/r/leagueoflegends/comments/8lrmcp/how_to_change_ingame_language_for_garena_lol/e3jd0aa/) reddit post, it turns out that the thing determining the language of the game and client is just a launch parameter of LeagueClient.exe. Thus, it is possible to change the language if you first launch LoL normally through the Garena client, then inspect the command line arguments of the LeagueClient.exe process, and then close and relaunch using the same arguments, except with the locale changed. You can save this command as a .bat file, but because Garena has their own launcher which authenticates you, with the authentication tokens passed in as arguments, you must reinspect those arguments every time you log off and on again, or if there is a network change, etc.

All in all, the method outlined in the post works but is not perfect. Firstly, it uses a third party program to inspect command line arguments. Secondly, there are quite a few steps which are quite annoying to do each time you want to play, and is probably not worth the effort to a lot of people. This PowerShell script I wrote attempts to solve these two problems by automating the process.

## How does the script work?

PowerShell is bundled with Windows, and can be used to inspect processes' command line arguments. This script simply looks for the LeagueClient.exe process, and if it exists, stops it, then takes it's command and replaces the locale in the arguments, and then saves the command into a batch file. The script is then run (regardless of whether the first step worked) in order to (re)start the client in the right language.

Originally, I wanted to run the executable with its arguments from inside PowerShell. Unfortunately, due to how PowerShell required using regexes to decompose the command string into the excecutable, followed by each argument. But that felt too complicated for such a simple task so instead I went with the quick and dirty solution instead. While it is an uglier solution, in that it has to write to disk instead of keeping everything in memory, it has less moving parts, and has the benefit of allowing you to skip opening the League client before running the script, as long as you had already run the script once with the League client open in your current login session, in order to update the authentication tokens in the command arguments.

Because PowerShell scripts can't be double-clicked to run, I've also included a shortcut that runs the script as long as it is in the same directory as the script, with admin privileges. The script requires elevated privileges or else it may fail to close the original LeagueClient.exe and thus be unable to start a new instance with the right language, and/or fail to get the command used to start LeagueClient.exe.
