# Use the official Miniconda image
FROM continuumio/miniconda3:latest

# Set the working directory in the container
WORKDIR /app

# Copy the reinvent.yml file into the Docker image
COPY reinvent.yml /app/reinvent.yml

# Install mamba and create the conda environment from the reinvent.yml file
RUN conda install -n base -c conda-forge mamba && \
    mamba env create -f reinvent.yml

# Install pip manually in case it is missing in the environment
RUN conda run -n reinvent.v3.2 python -m ensurepip --upgrade
RUN conda run -n reinvent.v3.2 python -m pip install --upgrade pip setuptools wheel

# Set the default shell to use bash and activate the conda environment
SHELL ["conda", "run", "-n", "reinvent.v3.2", "/bin/bash", "-c"]

# Copy the main.py script into the container
COPY main.py .

# Run the main.py script using the conda environment's Python interpreter
CMD ["python", "main.py"]
