#Script that installs apache2


#check to see if apache already exists on the machine

#check to see if apache already exists in shared folder

exec "wget http://mirror.catn.com/pub/apache//httpd/httpd-2.2.26.tar.gz"


exec "gzip -d httpd-2.2.26.tar.gz"
exec "tar xvf httpd-2.2.26.tar"
exec "mv httpd-2.2.26 /downloads/httpd-2.2.26"
exec "cd /downloads/httpd-2.2.26"
exec "./configure"
exec "make"
exec "make install"
exect "/usr/local/apache2 -k start"