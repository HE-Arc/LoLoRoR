# LoLoRoR
LoL on RubyOnRails
Web application to track your friends on the popular game League of Legends. It will allow your to access their match history and rank, aswell as the friends they usually play with.

## Dependances :
Redis : REmote DIctionary Server, it's an open-source data structure server with key-value storage.

API League of Legends : The official API we use for retrieve all the informations about the summoner. In order to send request to the API, we need an API key.

## How to use the project :
1. install redis : https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis
2. run the command : bundle install
3. run the command : rake db:create db:migrate
  * If you already have an older version of the database, run : rake db:drop
4. Find the file app.yml in folder config and make sure the values are correct
  * If you don't have this file, create a new one with the name app.yml and copy-paste this and fill the gap :

```
 # file config/app.yml
 
defaults: &defaults
  :email_username: XXX
  :email_password: XXX
  :api_key: XXX
 
development:
  # we are using standard YML inheritance here, very powerful and native !
  <<: *defaults
  :secret_key:XXX
 
test:
  <<: *defaults
  :secret_key: XXX
 
production:
  <<: *defaults
  :secret_key: XXX
  :db_name: XXX
  :db_username: XXX
  :db_password: XXX
```
