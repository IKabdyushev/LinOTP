FROM oraclelinux:7.6
RUN export http_proxy=${HTTP_PROXY} && export https_proxy=${HTTP_PROXY} && \
    echo -e "proxy=${HTTP_PROXY}\ntimeout=120" >> /etc/yum.conf && \
    echo -e "[extras741708]\nname=Extras packages for CentOS 7.4.1708 for x86_64\nbaseurl=http://vault.centos.org/centos/7.4.1708/extras/x86_64/\nenabled=1" > /etc/yum.repos.d/CentOS-7.4.1708.repo && \
    yum clean all && yum -y update && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/python-qrcode-5.0.1-1.el7.noarch.rpm -o python-qrcode-5.0.1-1.el7.noarch.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/python-webob-1.2.3-7.el7.noarch.rpm -o python-webob-1.2.3-7.el7.noarch.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/python-webtest-1.3.4-6.el7.noarch.rpm -o python-webtest-1.3.4-6.el7.noarch.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/python-twisted-core-12.2.0-4.el7.x86_64.rpm -o python-twisted-core-12.2.0-4.el7.x86_64.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/python-pygments-1.4-10.el7.noarch.rpm -o python-pygments-1.4-10.el7.noarch.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/perl-Switch-2.16-7.el7.noarch.rpm -o perl-Switch-2.16-7.el7.noarch.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/perl-WWW-Curl-4.15-13.el7.x86_64.rpm -o perl-WWW-Curl-4.15-13.el7.x86_64.rpm && \
    curl https://rpmfind.net/linux/centos/7.6.1810/os/x86_64/Packages/python-zope-interface-4.0.5-4.el7.x86_64.rpm -o python-zope-interface-4.0.5-4.el7.x86_64.rpm && \
    yum -y localinstall *.rpm && rm -rf *.rpm && \
    yum -y localinstall http://linotp.org/rpm/el7/linotp/x86_64/Packages/LinOTP_repos-1.1-1.el7.x86_64.rpm && \
    yum -y install python-psycopg2

RUN yum -y localinstall --nogpgcheck http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm && \
    yum -y --nogpgcheck --enablerepo=ol7_optional_latest,epel install LinOTP  LinOTP_postgresql httpd mod_ldap mod_wsgi && \
    yum clean all && rm -rf /var/cache/yum && chown apache:apache /etc/linotp2/linotpapp.wsgi

ENTRYPOINT [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]