#!/bin/sh
#  
#  COURSE v3
#  FastAI 1.0
#  Please do note that running scripts like this from the Internet is a dangerous practice

#wget http://us.download.nvidia.com/XFree86/Linux-x86_64/418.43/NVIDIA-Linux-x86_64-418.43.run
#bash NVIDIA-Linux-x86_64-418.43.run

echo -e "\n###\n"
echo -e "Installing Anaconda3"
echo -e "\n###\n"

wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b

echo -e "\n###\n"
echo -e "Installing FastAI v3"
echo -e "\n###\n"

cd
git clone https://github.com/fastai/fastai.git
cd fastai/

echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
export PATH=~/anaconda3/bin:$PATH
source ~/.bashrc
cd ..

conda create -n fastai python=3.6
source activate fastai
conda install pytorch torchvision -c pytorch 
conda install -c fastai fastai 
conda env update

echo 'source activate fastai' >> ~/.bashrc
source activate fastai
source ~/.bashrc

echo -e "\n###\n"
echo -e "Preparing Jupyter Enviroment"
echo -e "\n###\n"

jupyter notebook --generate-config --allow-root
echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
# The below line is for Rendsolve's Jupyter Portal. Can be removed if running local
echo "c.NotebookApp.base_url = '/jupyter/'" >> ~/.jupyter/jupyter_notebook_config.py
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension --sys-prefix

echo -e "\n###\n"
echo -e "\n\nSystem will now reboot!"
echo -e "\n###\n"

reboot
