# Our system is super easy to deploy.
# Firstly, make sure you have MySQL 5.7 and Python 3.6+ (with pip) installed on you system.
# You could use following command to get the source code
git clone https://github.com/jslu0418/Brynhildr.git
# After that, go to the root directory of source code
cd Brynhildr
# Then initialize the database.
./init_db.sh
# start system (it will check package dependencies at first)
./runserver.sh
