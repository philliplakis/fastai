#!/bin/sh
#  
#  COURSE v3
#  FastAI 1.0
#  Please do note that running scripts like this from the Internet is a dangerous practice

echo -e "Installation script for Ubuntu 16+"

echo -e "Set non-interactive frontend"
echo -e "Script will run without any prompts"
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    software-properties-common

echo -e "\n###\n"
echo -e "Installing NVIDIA drivers and CUDA"
echo -e "Driver version: 410.79"
echo -e "CUDA version: 10.0.130-1"
echo -e "\n###\n"

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb

dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

apt-get update
apt-get install cuda -y

echo -e "\n###\n"
echo -e "Installing Anaconda3"
echo -e "\n###\n"

wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b
cd

echo -e "\n###\n"
echo -e "Installing FastAI v3"
echo -e "\n###\n"

git clone https://github.com/fastai/course-v3.git
cd course-v3/
echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
export PATH=~/anaconda3/bin:$PATH
source ~/.bashrc
conda install -c pytorch cuda100 
conda env update
echo 'source activate fastai' >> ~/.bashrc
source activate fastai
source ~/.bashrc
cd ..

echo -e "\n###\n"
echo -e "Downloading Dogs Cats Dataset"
echo -e "\n###\n"

mkdir data
cd data
wget http://files.fast.ai/data/dogscats.zip
unzip -q dogscats.zip
cd ../course-v3/nbs/dl1/
ln -s ~/data ./

echo -e "\n###\n"
echo -e "Preparing Jupyter Enviroment"
echo -e "\n###\n"

jupyter notebook --generate-config
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
# The below line is for Rendsolve's Jupyter Portal. Can be removed if running local
echo "c.NotebookApp.base_url = '/jupyter/'" >> ~/.jupyter/jupyter_notebook_config.py
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension --sys-prefix

echo -e "\n###\n"
echo -e "Finished with no errors."
echo -e "\n\nSystem will now reboot!"
echo -e "\n###\n"

reboot
