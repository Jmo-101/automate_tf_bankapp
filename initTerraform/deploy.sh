!#/bin/bash

sudo apt install software-properties-common

sudo apt install add-apt-repository -y ppa:deadsnakes/ppa

sudo apt installpython3.7

sudo apt install build-essential

sudo apt install libmysqlclient-dev

sudo apt install python3.7-dev


python3.7 -m venv test
source test/bin/activate
git clone https://github.com/Jmo-101/automate_tf_bankapp.git
cd automate_tf_bankapp
pip install pip --upgrade
pip install -r requirements.txt
# Install required packages in the virtual environment
pip install mysqlclient
pip install gunicorn
python database.py
python load_data.py
python -m gunicorn app:app -b 0.0.0.0 -D && echo "Done"
source test/bin/activate
