# myphpenv
Overly Simple Docker PHP development environment 

Containers for PHP 7.4, 8.0, 8.1. Setup with:
*7.3 is not currently working*

* traefik
* composer
* redis session handleing
* mysql/mariadb server
* PDO Drivers
  * Sqlsrv (MS SQL)
  * Mysql



## Setup
*lots more to think about here*

### create html and mysql folders
* /var/docker/html
* /var/docker/mysql

### setup mydev
* git clone etc etc
* `ln -s *path to repo*/mydev  /usr/local/bin`


### setup hosts file
/etc/hosts

```
127.0.0.1	w74.localhost      
127.0.0.1	w80.localhost     
127.0.0.1	w81.localhost    
```




## mydev commandds

Most of these should be self explaining, ill flesh this out if this becomes usefull
* mydev start
* mydev stop
* mydev restart
* mydev clean

connect to a bash propmt for each php env
* mydev bash74
* mydev bash80
* mydev bash81


## TODO

* lots
* documentation
* `install` script
