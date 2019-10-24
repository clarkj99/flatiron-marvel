# FLATIRON MARVEL API RUBY CLI
Ruby CLI to retrieve Marvel API data for characters, comics, and creators.

## DESCRIPTION
This work represents the tireless and devoted efforts of two remarkable Ruby developers:  Kuran Kumar, Clark Johnson.  It was developed as a Flatiron School project to answer some basic questions regarding the Marvel Comic Universe.  It polls the Marvel Developer API and use ActiveRecord to create a local sqlite3 database containing data for **comics**, **characters**, and **creators**. It also makes use of the [TTY gem](https://github.com/piotrmurach/tty) for enhanced CLI methods.

## INSTALL INSTRUCTIONS
This application uses data from the [Marvel Comics API](https://developer.marvel.com). To seed your data, you'll need a [developer key](https://developer.marvel.com/documentation/getting_started). 
Make sure to create "/.config.rb" file with contents:
```
CONFIG = {
    my_key: "public_api_key"
    secret_key: "private_api_key"
 }
 ```
 If you want any of the code to run :^)

 ```
 bundle install
 rake DB:SEED 
 ```
 *Note: to disable AcitveRecord Logging, add `ActiveRecord::Base.logger = nil` to your "./config/environment.rb"*

When ready to run, just `ruby marvel.rb`.
 
 ***MUST BE IN FULLSCREEN TO RUN!***

 ## CONTRIBUTORS

 Made with love by
 * [Kuran Kumar @kurankumar](https://github.com/kurankumar)
 * [J. Clark Johnson @clarkj99](https://github.com/clarkj99)

 ## LICENSE

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">Flatiron Marvel API Ruby CLI</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/clarkj99/flatiron-marvel" property="cc:attributionName" rel="cc:attributionURL">https://github.com/clarkj99/flatiron-marvel</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

