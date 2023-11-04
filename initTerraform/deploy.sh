!#/bin/bash

sudo apt install software-properties-common

sudo apt install add-apt-repository -y ppa:deadsnakes/ppa

sudo apt install python3.7

sudo apt install -y python3.7-venv

sudo apt install build-essential

sudo apt install libmysqlclient-dev

sudo apt install python3.7-dev

sudo apt update


/usr/bin/git clone https://github.com/auzhangLABS/c4_deployment-6-main.git /home/ubuntu/c4_deployment-6-main

cd /home/ubuntu/c4_deployment-6-main && /usr/bin/python3.7 -m venv /home/ubuntu/c4_deployment-6-main/test

source /home/ubuntu/c4_deployment-6-main/test/bin/activate

pip install pip --upgrade
pip install -r requirements.txt
# Install required packages in the virtual environment
pip install mysqlclient
pip install gunicorn
python database.py
python load_data.py
python -m gunicorn app:app -b 0.0.0.0 -D && echo "Done"
source test/bin/activate
