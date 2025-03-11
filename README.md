# Forecasting at Scale


## Setup the Python forecasting environment

- Make sure you have the recent version of Python (tested with version 3.12) on your system.

- Download the repository and unzip to a folder.

- Inside the folder, run the command inside your terminal:
   ```bash
   python setup.py
   ```

The script will:
   - Create a virtual environment `.venv` in the folder.
   - Install Jupyter and `ipykernel`.
   - Install all dependencies from `requirements.txt`.
   - Register the virtual environment as a Jupyter kernel.

This automates everything you need for your environment setup.

## To use it in Jupyter:
   - Open Jupyter Notebook: `jupyter notebook`
   - Select **Kernel** > **Change Kernel** > **Python (forecasting)**


## Using Spark

### try spark!
If you have a Linux-like environment, such as WLS, macOS or a Linux server, you could try `setup_spark.sh` to simulate a standalone Spark environment.

```bash
bash setup_spark.sh 3.12 3.5.4
```
### Heavy computing on top of a Slurm server

Read more at https://github.com/feng-li/spark-on-slurm.


