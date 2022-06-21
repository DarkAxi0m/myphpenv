# myphpenv
Overly Simple Docker PHP development environment 


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
* `install` script
