# Base image with Python and Jupyter
FROM python:3.9-slim

# Set environment variables
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv $VIRTUAL_ENV

# Install Jupyter in the virtual environment
RUN pip install --upgrade pip && \
    pip install jupyter ipykernel jupyterlab

# Copy requirements file to the container
COPY requirements.txt .

# Install Python dependencies in the virtual environment
RUN pip install -r requirements.txt

# Create a custom Jupyter kernel using the virtual environment
RUN python -m ipykernel install --user --name=ub_kernel --display-name "Python (UB)"

# Expose the default Jupyter Notebook port
EXPOSE 8888

# Set working directory for notebooks
WORKDIR /home/jupyter

# Copy all content (e.g., notebooks) to the container
COPY ./notebooks .

# Remove existing Jupyter config if present (to avoid conflicts)
RUN rm -rf ~/.jupyter

# Generate Jupyter configuration file
RUN jupyter server --generate-config

# Set up a password for Jupyter Lab
RUN python -c "from jupyter_server.auth import set_password; set_password('jupyter')"

# Configure Jupyter
RUN echo "c.ServerApp.allow_origin = '*'" >> ~/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.allow_remote_access = True" >> ~/.jupyter/jupyter_server_config.py

# Disable token and password authentication by directly setting the config file
# RUN echo "c.IdentityProvider.token = ''" >> ~/.jupyter/jupyter_server_config.py && \
#    echo "c.ServerApp.password = ''" >> ~/.jupyter/jupyter_server_config.py && \
#    echo "c.ServerApp.allow_origin = '*'" >> ~/.jupyter/jupyter_server_config.py && \
#    echo "c.ServerApp.allow_remote_access = True" >> ~/.jupyter/jupyter_server_config.py && \
#    echo "c.ServerApp.disable_check_xsrf = True" >> ~/.jupyter/jupyter_server_config.py

# Run Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]