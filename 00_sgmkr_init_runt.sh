echo -e "establecer host de confianza para descarga de librerias...."

pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"

echo -e "instalar y actualizar wheel para archivos .whl......"

pip install -U pip setuptools wheel

echo -e "instalar y actualizar gestor de paquetes pip....."

yum install -y pip 

pip install --upgrade pip

echo -e "Actualizar Repositorio sagemaker......."

pip install --upgrade sagemaker


echo -e "establecer entorno y version de python..." 

pip install virtualenv

virtualenv -p python3.10 RUNT

source RUNT/bin/activate

pip install ipykernel

python -m ipykernel install --user --name RUNT

echo -e "instalar librerias...." 

pip install nbformat
pip install connectorx
pip install sqldf
pip install redshift-connector
pip install duckdb
pip install pandas
pip install numpy
pip install pyarrow
pip install pyodbc
# pip install xgboost
pip install SQLAlchemy
pip install fastparquet
# pip install spacy
pip install openpyxl
pip install s3fs
pip install dask
pip install psycopg2-binary
pip install fsspec
pip install psycopg2
pip install papermill 


echo -e "instalar los modulos de spacy..."

# pip install es_core_news_sm-3.8.0-py3-none-any.whl

# pip install es_dep_news_trf-3.8.0-py3-none-any.whl


echo  -e "establecer conector odbc...."

# sudo su yum install -y unixODBC unixODBC-devel
sudo su - <<EOF

yum update -y

yum install -y unixODBC unixODBC-devel

curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

sudo ACCEPT_EULA=Y yum install -y msodbcsql18

EOF

echo -e "Entorno Listo.........." 


echo -e "Ejecutando Cuadernillo.........." 
# papermill RUNT.ipynb RUNT.ipynb 


papermill pipeline_RUNT.ipynb pipeline_RUNT.ipynb