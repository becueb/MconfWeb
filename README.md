# Mconf-web [<img src="https://travis-ci.org/mconf/mconf-web.svg?branch=master" />](https://travis-ci.org/mconf/mconf-web) [<img src="https://codeclimate.com/github/mconf/mconf-web/badges/gpa.svg" />](https://codeclimate.com/github/mconf/mconf-web) [<img src="https://hakiri.io/github/mconf/mconf-web/master.svg" alt="security" />](https://hakiri.io/github/mconf/mconf-web/master) [<img src="http://inch-ci.org/github/mconf/mconf-web.svg?branch=master" alt="Inline docs" />](http://inch-ci.org/github/mconf/mconf-web)

Mconf-Web is the web application that provides access to web conferences in
Mconf-Live or BigBlueButton servers.

You can try out Mconf-Web at our free demo server at http://mconf.org.

Il faut absolument configurer Monit
Extrait du wiki Mconf-Web

 Monit

Monit is a tool for managing and monitoring processes in UNIX systems. It is installed as packages in your server and configured to monitor some processes needed by Mconf-Web. Monit will make sure all processes related to Mconf-Web are running, and it's your job to make sure that Monit is always running.

Install monit:

$ sudo apt-get install monit

You shouldn't have problems regarding the version of Monit being used, but, for a reference, these instructions have been tested with Monit 5.3.2.

The configuration files Mconf-Web uses for Monit are found in the application's folder config/monit/. We will simply include these files in Monit's configuration file, so they are loaded when monit starts. First, open the configuration file with an editor:

$ sudo vim /etc/monit/monitrc

Change the monitoring interval to 1 minute (it usually defaults to 2 minutes):

set daemon 60

Enable HTTP support by uncommenting the following lines:

set httpd port 2812 and
   use address localhost  # only accept connection from localhost
   allow localhost

Then install the configuration file:

sudo wget https://raw.github.com/mconf/mconf-web/v2.0.x/config/monit/resque_workers.monitrc -O /etc/monit/conf.d/resque_workers.monitrc

Notice that this file contains the path to the application and the user/group that should be used to run the processes. They are set to use the default folder (/var/www/mconf-web/current) and user/group (mconf:mconf), but you should always check them to see if they fit your environment!
Managing Monit: start, stop, log files

To start and stop Monit you can simply run:

$ sudo /etc/init.d/monit stop
$ sudo /etc/init.d/monit start

Be aware that stopping Monit will not stop the processes it monitors. You have to stop them individually before or after stopping Monit. When you start Monit, however, all processes are started. Monit is also started automatically when your server is started, so all processes will automatically be started.

You can check if the processes being monitored are running with:

$ ps aux | grep -e resque

The response you get should include the processes in the example output below:

mconf  13082  0.0 10.5 944220 106708 ?  Sl  Nov08  1:06 resque-1.25.1: Waiting for all

To start or stop the processes individually, use:

# for resque workers: all of them
$ sudo monit -g resque_workers start
$ sudo monit -g resque_workers stop

# for all services
$ sudo monit start all
$ sudo monit stop all

If any of the commands above fail with the message monit: Cannot connect to the monit daemon. Did you start it with http support?, you need to enable http support on Monit's config file. Open the configuration file at /etc/monit/monitrc. Search for a section similar to the one below and uncomment it:

set httpd port 2812 and
   use address localhost  # only accept connection from localhost
   allow localhost        # allow localhost to connect to the server and




Mconf-Web connects to an Mconf-Live or a
[BigBlueButton](http://www.bigbluebutton.org/) server and allows the users to
create and participate in web conferences. It provides functionalities that
are (by design) not implemented in the core of Mconf-Live/BigBlueButton, such
as:

* User authentication;
* Permission control to access web conference rooms;
* Follows a social network model with spaces (communities) that have events;
* Users have their own web conferences that they can share with other
  members or even invite external participants;
* Each space also has a web conference room that the members can use to
  interact;
* Events can be used to schedule web conferences.

For more details [read our wiki](https://github.com/mconf/mconf-web/wiki).

## License

This project is under the [AGPL version 3
license](http://www.gnu.org/licenses/agpl-3.0.html). See LICENSE.

## Contact

This project is developed as part of Mconf. Visit:

* [Mconf.org](http://mconf.org)
* [Mconf at GitHub](https://github.com/mconf)
* [Issue tracker](http://dev.mconf.org)
