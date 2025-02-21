#! /usr/bin/env bash

set -e

python3_ver=$1
spark_ver=$2

# Connect to PKU Internet
# curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d cmd=open -d username=2412345678 -d password=MyPassWord -d iprange=free https://its4.pku.edu.cn/cas/ITSClient

if [ -z ${python3_ver} ] | [ -z ${spark_ver} ] ;then
    echo -e "
    Python or Spark version not given! Use this default command:

    bash setup_spark.sh 3.12  3.5.4

    "
    python3_ver=3.12
    spark_ver=3.5.4

fi

miniforge_home=$HOME/.local/miniforge3

# Install minforge if mamba not available
if [[ ! -f ${miniforge_home}/bin/python3 ]]; then

    # Force download the json file
    curl -L -O "https://mirrors.tuna.tsinghua.edu.cn/github-release/conda-forge/miniforge/LatestRelease/Miniforge3-$(uname)-$(uname -m).sh"
    bash "Miniforge3-$(uname)-$(uname -m).sh" -b -u -p "${miniforge_home}"

#    ln -sfv ${miniforge_home}/bin/mamba ${HOME}/.local/bin/
fi


# Install dependency
${miniforge_home}/bin/mamba install openjdk=17                      --yes
${miniforge_home}/bin/mamba install pyspark="$spark_ver" plotly     --yes
${miniforge_home}/bin/mamba install ipykernel                       --yes

# Make pyspark availale for jupyter
mkdir -p ${HOME}/.local/share/jupyter/kernels/pyspark

# Set JAVA_HOME dynamically (Detect Java 11 installation)
JAVA_HOME=${miniforge_home}
PYSPARK_PYTHON=${miniforge_home}/bin/python
SPARK_HOME=${miniforge_home}

# Ensure the kernel directory exists
$PYSPARK_PYTHON -m ipykernel install --user --name pyspark --display-name pyspark

# mkdir -p ${HOME}/.local/share/jupyter/kernels/pyspark
# Write the CORRECT JSON content with the dynamic JAVA_HOME
cat > ${HOME}/.local/share/jupyter/kernels/pyspark/kernel.json <<EOF
{
  "argv": [
    "$PYSPARK_PYTHON",
    "-m",
    "ipykernel_launcher",
    "-f",
    "{connection_file}"
  ],
  "display_name": "Python$python3_ver (PySpark$spark_ver)",
  "language": "python",
  "env": {
    "JAVA_HOME": "$JAVA_HOME"
  }
}
EOF

echo "✅ Pyspark kernel written successfully with JAVA_HOME: $JAVA_HOME"
