import os
import subprocess
import sys

def run_command(command):
    """Runs a shell command and prints output in real time."""
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    for line in process.stdout:
        print(line, end="")
    process.wait()
    if process.returncode != 0:
        print(process.stderr.read(), file=sys.stderr)
        sys.exit(process.returncode)

# Step 1: Create virtual environment
venv_name = ".venv"
print(f"Creating virtual environment: {venv_name}...")
run_command(f"python -m venv {venv_name}")

# Step 2: Determine activation command based on OS
if os.name == "nt":
    python_cmd = os.path.join(venv_name, "Scripts", "python.exe")
else:
    python_cmd = os.path.join(venv_name, "bin", "python")

# Step 3: Upgrade pip & Install Jupyter
print("Upgrading pip and installing Jupyter...")
run_command(f"{python_cmd} -m pip install --upgrade pip")
run_command(f"{python_cmd} -m pip install jupyter ipykernel")

# Step 4: Install dependencies from requirements.txt (if exists)
requirements_file = "requirements.txt"
if os.path.exists(requirements_file):
    print(f"Installing dependencies from {requirements_file}...")
    run_command(f"{python_cmd} -m pip install -r {requirements_file}")
else:
    print(f"No {requirements_file} found. Skipping dependency installation.")

# Step 5: Add Virtual Environment to Jupyter as a Kernel
kernel_name = "Python (.venv)"
print(f"Adding Jupyter kernel: {kernel_name}...")
run_command(f"{python_cmd} -m ipykernel install --user --name=.venv --display-name \"{kernel_name}\"")

print("\n✅ Virtual environment, dependencies, and Jupyter kernel setup complete!")
print("To activate your virtual environment, use:")
print(f"  source {venv_name}/bin/activate  # (Mac/Linux)")
print(f"  {venv_name}\\Scripts\\activate  # (Windows)")
print("To start Jupyter Notebook, run:")
print("  jupyter notebook")
